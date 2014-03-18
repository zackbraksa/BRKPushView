BRKPushView
=================

## BRKPushView

A custom view component containing a customizable `UITextView` that gets pushed up from the bottom of the screen with a slow and nice animation. 

## Usage



Add the dependency to your `Podfile`:

```ruby
platform :ios
...
pod 'BRKPushView'
...
```

Run `pod install` to install the dependencies.

Next, import the header file wherever you want to use `BRKPushView `:

```objc
#import <BRKPushView/BRKPushView.h> 
```

Finally, present the picker when necessary (say on a button touch handler):

```objc
BRKPushView *viewToPush = [[BRKPushView alloc] initWithText:@"Say Hello to PushView!"];

[viewToPush presentInView:self.view];
```

## Demo

//TODO : Add GIF of demo here. 


## License

Usage is provided under the [MIT License](http://http://opensource.org/licenses/mit-license.php).  See LICENSE for the full details.