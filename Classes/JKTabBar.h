//
//  JKTabBar.h
//  Pods
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
  JKTabBarStyleDefault = 0,
  JKTabBarStyleVariableWidthButton
} JKTabBarStyle;

@class JKTabBar;

@protocol JKTabBarDelegate <NSObject>
@optional
- (BOOL)tabBar:(JKTabBar *)tabBar shouldSelectItem:(UITabBarItem *)item;
- (void)tabBar:(JKTabBar *)tabBar didSelectItem:(UITabBarItem *)item;
@end

@interface JKTabBar : UIView
@property (copy, nonatomic) NSArray *items;
@property (assign, nonatomic) UITabBarItem *selectedItem;
@property (assign, nonatomic) id<JKTabBarDelegate> delegate;
@property (strong, nonatomic) UIFont *tabBarButtonFont;
@property (nonatomic, strong) UIColor *barItemButtonSeparatorColor;

// TODO: implement this style option.
//@property (nonatomic) JKTabBarStyle tabBarStyle;
@end
