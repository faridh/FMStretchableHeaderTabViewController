//
//  JKTabViewController.h
//  StretchableHeaderTabViewExample
//
//  Created by Joel Koroniak on 2014-06-20.
//  Copyright (c) 2014 Hiroki Akiyama. All rights reserved.
//

#import <UIKit/UIKit.h>

/** An abstract view controller designed to be subclassed and used as a tab within an instance of a JKStretchableHeaderTabViewController */
@interface JKTabViewController : UIViewController

/**
 Retrieve and identify the main scrollable component within a tab controller
 @return The scrollable component of the controller's views, which should be used to dictate the stretching/shrinking of the container tab view's header
 When this controller is contained within a JKStretchableHeaderTabViewController, the container calls this method to determine which scrollable component within the controller should dictate the stretching or shrinking of the container views' header.
 */
- (UIScrollView*) scrollableComponentView;

@end
