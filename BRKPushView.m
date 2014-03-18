//
//  BRKPushView.m
//  PushView
//
//  Created by zakaria on 3/18/14.
//  Copyright (c) 2014 Zakaria Braksa. All rights reserved.
//

#define BRKPUSHVIEW_CONTAINER_HEIGHT 200
#define BRKPUSHVIEW_TOOLBAR_HEIGHT 35
#define BRKPUSHVIEW_GRAYBACKGROUND_OPACITY 0.8

#import "BRKPushView.h"

@interface BRKPushView () {
    UIToolbar *_toolbar;
    UIView *_container;
    UIView *_grayBackgroundView;
    NSString* _text;
}

@end

@implementation BRKPushView

-(id)initWithText:(NSString *)text{
    self = [super init];
    if (self) {
        self.text = text;
        self.userInteractionEnabled = YES;
    }
    
    return self;
}

- (void)presentInView:(UIView *)view {
    self.frame = view.bounds;
    
    [_container removeFromSuperview];
    [_grayBackgroundView removeFromSuperview];
    
    _grayBackgroundView = [self grayBackgroundView];
    [self addSubview:_grayBackgroundView];
    
    _container = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - BRKPUSHVIEW_CONTAINER_HEIGHT, self.bounds.size.width, BRKPUSHVIEW_CONTAINER_HEIGHT)];
    
    [_container setBackgroundColor:[UIColor whiteColor]];
    
    _toolbar = [self toolbar];
    [_container addSubview:_toolbar];
    
    UITextView* textView = [[UITextView alloc] initWithFrame:CGRectMake(10, _toolbar.bounds.size.height + 5, self.bounds.size.width - 20, BRKPUSHVIEW_CONTAINER_HEIGHT - BRKPUSHVIEW_TOOLBAR_HEIGHT - 5)];
    
    _text = self.text;
    
    textView.text = _text;
    
    
    [_container addSubview:textView];
    
    [self addSubview:_container];
    
    [view addSubview:self];
    
    
    CGRect oldFrame = _container.frame;
    CGRect newFrame = _container.frame;
    newFrame.origin.y += newFrame.size.height;
    _container.frame = newFrame;
    
    
    [UIView animateWithDuration:0.25 delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         _container.frame = oldFrame;
                         _grayBackgroundView.alpha = 1;
                     } completion:^(BOOL finished) {
                         
                     }];
}

- (void)presentInWindow {
    id appDelegate = [[UIApplication sharedApplication] delegate];
    if ([appDelegate respondsToSelector:@selector(window)]) {
        UIWindow *window = [appDelegate window];
        [self presentInView:window];
    } else {
        [NSException exceptionWithName:@"Can't find a window property on App Delegate, Instead use the presentInView method" reason:@"Your app delegate does not contain a window method"
                              userInfo:nil];
    }
}

- (void)onDone:(id)sender {
    [self dismissPicker];
}

- (void)ongrayBackgroundTap:(id)sender {
    [self onDone:sender];
}

- (void)dismissPicker {
    [UIView animateWithDuration:0.25 delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         CGRect newFrame = _container.frame;
                         newFrame.origin.y += _container.frame.size.height;
                         _container.frame = newFrame;
                         _grayBackgroundView.alpha = 0;
                     } completion:^(BOOL finished) {
                         [_container removeFromSuperview];
                         _container = nil;
                         
                         [_grayBackgroundView removeFromSuperview];
                         _grayBackgroundView = nil;
                         
                         [self removeFromSuperview];
                     }];
}

- (UIToolbar *)toolbar {
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, BRKPUSHVIEW_TOOLBAR_HEIGHT)];
    toolbar.barStyle = UIBarStyleDefault;
    
    toolbar.items = [NSArray arrayWithObjects:
                     [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                   target:nil
                                                                   action:nil],
                     [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                   target:self
                                                                   action:@selector(onDone:)],
                     nil];
    
    return toolbar;
}

- (UIView *)grayBackgroundView {
    UIView *grayBackgroundView = [[UIView alloc] initWithFrame:self.bounds];
    grayBackgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:BRKPUSHVIEW_GRAYBACKGROUND_OPACITY];
    grayBackgroundView.alpha = 0;
    
    UIGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ongrayBackgroundTap:)];
    [grayBackgroundView addGestureRecognizer:tapRecognizer];
    return grayBackgroundView;
}


@end
