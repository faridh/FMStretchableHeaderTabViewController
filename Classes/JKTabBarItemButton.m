//
//  JKTabBarItemButton.m
//  Pods
//

#import "JKTabBarItemButton.h"

@interface JKTabBarItemButton() {
    CALayer *_leftSideSeparator;
    CALayer *_rightSideSeparator;
}

@end

@implementation JKTabBarItemButton

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code
      self.clipsToBounds = NO;
      
    [self setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    [self setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    
      _leftSideSeparator = [CALayer layer];
      _leftSideSeparator.backgroundColor = [UIColor clearColor].CGColor;
      _leftSideSeparator.cornerRadius = 5.0f;
      [self.layer addSublayer:_leftSideSeparator];

      _rightSideSeparator = [CALayer layer];
      _rightSideSeparator.backgroundColor = [UIColor clearColor].CGColor;
      _rightSideSeparator.cornerRadius = 5.0f;
      [self.layer addSublayer:_rightSideSeparator];
                                            
  }
  return self;
}

- (void)layoutSubviews
{
  [super layoutSubviews];
    
    _leftSideSeparator.frame = CGRectMake(0, 10, 1, self.bounds.size.height - 20);
    _rightSideSeparator.frame = CGRectMake(self.bounds.size.width - 1, 10, 1, self.bounds.size.height - 20);
}

- (void)sizeToFit
{
  [super sizeToFit];
  CGFloat padding = 16.0;
  [self setBounds:(CGRect){CGPointZero, CGRectGetWidth(self.frame) + padding, CGRectGetHeight(self.frame) + padding}];
}

- (void)setBadgeValue:(NSString *)badgeValue
{
  if ([_badgeValue isEqualToString:badgeValue] == NO) {
    _badgeValue = [badgeValue copy];
    
    // TODO: implement this.
  }
}

- (void) setSeparatorColor:(UIColor *)separatorColor
{
    if ([_separatorColor isEqual:separatorColor]) {
        return;
    }
    
    _separatorColor = separatorColor;
    _leftSideSeparator.backgroundColor = _separatorColor.CGColor;
    _rightSideSeparator.backgroundColor = _separatorColor.CGColor;
}

- (void) setShowsLeftSideSeparator:(BOOL)showsLeftSideSeparator
{
    _showsLeftSideSeparator = showsLeftSideSeparator;
    _leftSideSeparator.hidden = !showsLeftSideSeparator;
}

- (void) setShowsRightSideSeparator:(BOOL)showsRightSideSeparator
{
    _showsRightSideSeparator = showsRightSideSeparator;
    _rightSideSeparator.hidden = !showsRightSideSeparator;
}



@end
