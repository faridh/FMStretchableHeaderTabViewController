//
//  FMTabBar.h
//  Pods
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
  FMTabBarStyleDefault = 0,
  FMTabBarStyleVariableWidthButton
} FMTabBarStyle;

@class FMTabBar;

@protocol FMTabBarDelegate <NSObject>
@optional
- (BOOL)tabBar:(FMTabBar *)tabBar shouldSelectItem:(UITabBarItem *)item;
- (void)tabBar:(FMTabBar *)tabBar didSelectItem:(UITabBarItem *)item;
@end

@interface FMTabBar : UIView
@property (copy, nonatomic) NSArray *items;
@property (assign, nonatomic) UITabBarItem *selectedItem;
@property (assign, nonatomic) id<FMTabBarDelegate> delegate;
@property (strong, nonatomic) UIFont *tabBarButtonFont;
@property (nonatomic, strong) UIColor *barItemButtonSeparatorColor;

// TODO: implement this style option.
//@property (nonatomic) FMTabBarStyle tabBarStyle;
@end
