//
//  FMStretchableHeaderView.h
//  Pods
//

#import <UIKit/UIKit.h>

@class FMStretchableHeaderView;

@protocol FMStretchableHeaderViewDelegate <NSObject>
- (NSArray *)interactiveSubviewsInStretchableHeaderView:(FMStretchableHeaderView *)stretchableHeaderView;
@end

@interface FMStretchableHeaderView : UIView
@property (nonatomic) id<FMStretchableHeaderViewDelegate> delegate;
@property (nonatomic) CGFloat minimumOfHeight;
@property (nonatomic) CGFloat maximumOfHeight;
@property (nonatomic) BOOL bounces;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@end
