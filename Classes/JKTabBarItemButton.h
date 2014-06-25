//
//  JKTabBarItemButton.h
//  Pods
//

#import <UIKit/UIKit.h>

@interface JKTabBarItemButton : UIButton
@property (copy, nonatomic) NSString *badgeValue;
@property (nonatomic, copy) UIColor *separatorColor;
@property (nonatomic, assign) BOOL showsRightSideSeparator;
@property (nonatomic, assign) BOOL showsLeftSideSeparator;
@end
