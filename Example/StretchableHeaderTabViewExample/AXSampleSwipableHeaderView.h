//
//  AXSampleHeaderView.h
//  StretchableHeaderTabViewExample
//

#import "JKStretchableHeaderView.h"

@interface AXSampleSwipableHeaderView : JKStretchableHeaderView <JKStretchableHeaderViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
