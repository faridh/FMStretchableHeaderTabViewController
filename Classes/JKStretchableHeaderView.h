//
//  JKStretchableHeaderView.h
//  Pods
//

#import <UIKit/UIKit.h>

@class JKStretchableHeaderView;

@protocol JKStretchableHeaderViewDelegate <NSObject>
- (NSArray *)interactiveSubviewsInStretchableHeaderView:(JKStretchableHeaderView *)stretchableHeaderView;
@end

@interface JKStretchableHeaderView : UIView
@property (nonatomic) id<JKStretchableHeaderViewDelegate> delegate;
@property (nonatomic) CGFloat minimumOfHeight;
@property (nonatomic) CGFloat maximumOfHeight;
@property (nonatomic) BOOL bounces;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@end
