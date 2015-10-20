//
//  FMStretchableHeaderTabViewController.h
//  Pods
//

#import <UIKit/UIKit.h>
#import "FMStretchableHeaderView.h"
#import "FMTabBar.h"
#import "FMTabViewController.h"

@class FMStretchableHeaderTabViewController;

@protocol FMStretchableHeaderTabViewControllerDelegate <NSObject>

@optional
- (void) stretchableHeaderTabViewController: (FMStretchableHeaderTabViewController*) stretchableHeaderTabViewController willShowTabController: (UIViewController*) tabController;

@end

@interface FMStretchableHeaderTabViewController : UIViewController <UIScrollViewDelegate, FMTabBarDelegate>
@property (nonatomic) NSUInteger selectedIndex;
@property (readwrite, nonatomic) FMTabViewController *selectedViewController;
@property (copy, nonatomic) NSArray *viewControllers;

@property (weak, nonatomic) IBOutlet FMStretchableHeaderView *headerView;
@property (readonly, nonatomic) FMTabBar *tabBar;
@property (weak, nonatomic) IBOutlet UIScrollView *containerView;
@property (nonatomic) BOOL shouldBounceHeaderView;

@property (nonatomic, assign) id <FMStretchableHeaderTabViewControllerDelegate> delegate;

- (void) selectTabViewControllerAtIndex: (NSInteger) index;

// Layout
- (void)layoutHeaderViewAndTabBar;
- (void)layoutViewControllers;
- (void)layoutSubViewControllerToSelectedViewController;
@end
