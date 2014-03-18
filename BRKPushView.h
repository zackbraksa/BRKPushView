//
//  BRKPushView.h
//  PushView
//
//  Created by zakaria on 3/18/14.
//  Copyright (c) 2014 Zakaria Braksa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BRKPushView : UIView

@property (nonatomic, retain) NSString *text;

- (id)initWithText:(NSString *)text;
- (void)presentInView:(UIView *)view;
- (void)presentInWindow;

@end
