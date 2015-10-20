//
//  AXSampleHeaderView.h
//  StretchableHeaderTabViewExample
//

#import "FMStretchableHeaderView.h"

@interface AXSampleSwipableHeaderView : FMStretchableHeaderView <FMStretchableHeaderViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
