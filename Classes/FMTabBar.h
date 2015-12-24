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
@property (nonatomic, strong) NSArray *buttons;
@property (assign, nonatomic) UITabBarItem *selectedItem;
@property (assign, nonatomic) id<FMTabBarDelegate> delegate;

@property (strong, nonatomic) UIFont *tabBarButtonFont;

@property (nonatomic, strong) UIColor *barItemButtonSeparatorColor;
@property (nonatomic, strong) UIColor *buttonMainColor;
@property (nonatomic, strong) UIColor *buttonSecondaryColor;
@property (nonatomic, strong) UIColor *indicatorColor;
@property (nonatomic, strong) UIColor *bottomLayerColor;

// TODO: implement this style option.
//@property (nonatomic) FMTabBarStyle tabBarStyle;

@end
