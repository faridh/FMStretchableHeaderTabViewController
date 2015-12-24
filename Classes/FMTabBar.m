//
//  FMTabBar.m
//  Pods
//

#import "FMTabBar.h"
#import "FMTabBarItemButton.h"

#define MIN_TAB_BUTTON_WIDTH 140

@interface FMTabBar ()
@property (readonly, nonatomic) UIScrollView *containerView;
@property (readonly, nonatomic) UIToolbar *toolbar;
@property (copy, nonatomic) NSArray *tabBarItemButtons;
@end

@implementation FMTabBar {
  NSArray *_items;
  CALayer *_bottomSeparator;
  CALayer *_indicatorLayer;
  FMTabBarStyle _tabBarStyle;
}

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    _tabBarButtonFont = [UIFont systemFontOfSize:14.0];
    
    _toolbar = [[UIToolbar alloc] init];
    _toolbar.userInteractionEnabled = NO;
      _toolbar.translucent = NO;
      _toolbar.barTintColor = [UIColor colorWithWhite:1.0f alpha:0.0f];
      for (__strong UIView *tempView in _toolbar.subviews) {
          tempView.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.0f];
          
      }
    [self addSubview:_toolbar];
    
    _containerView = [[UIScrollView alloc] init];
    _containerView.bounces = NO;
    _containerView.showsHorizontalScrollIndicator = NO;
    _containerView.decelerationRate = UIScrollViewDecelerationRateFast;
      _containerView.scrollEnabled = NO;
      //_containerView.contentInset = UIEdgeInsetsMake(0, 50, 0, [UIScreen mainScreen].bounds.size.width - 150);
    [self addSubview:_containerView];
    
    _bottomSeparator = [CALayer layer];
    [_bottomSeparator setBackgroundColor:[[UIColor orangeColor] CGColor]];
    [self.layer addSublayer:_bottomSeparator];

    _indicatorLayer = [CALayer layer];
    [_containerView.layer addSublayer:_indicatorLayer];
  }
  return self;
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  [_toolbar setFrame:self.bounds];
  [_containerView setFrame:self.bounds];
    _containerView.tintColor = [UIColor clearColor];
    _containerView.backgroundColor = [UIColor clearColor];
   
  if (_tabBarItemButtons.count > 0) {
    CGSize buttonSize = (CGSize){MAX( MIN_TAB_BUTTON_WIDTH, CGRectGetWidth(self.bounds)/ _tabBarItemButtons.count), CGRectGetHeight(self.bounds)};
    switch (_tabBarStyle) {
      case FMTabBarStyleDefault: {
        [_tabBarItemButtons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
          [button setFrame:(CGRect){buttonSize.width * idx, 0.0, buttonSize}];
            [(FMTabBarItemButton*)button setSeparatorColor:self.barItemButtonSeparatorColor];
            [(FMTabBarItemButton*)button setShowsRightSideSeparator:NO];
            if (idx == 0) {
                [(FMTabBarItemButton*)button setShowsLeftSideSeparator:NO];
            }
        }];
        [_containerView setContentSize:CGSizeMake(buttonSize.width * _tabBarItemButtons.count, buttonSize.height)];
        break;
      }
      case FMTabBarStyleVariableWidthButton: {
        __block CGFloat x = 8.0;
        [_tabBarItemButtons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
          [button sizeToFit];
          CGFloat buttonWidth = CGRectGetWidth(button.bounds);
          [button setFrame:(CGRect){x, 0.0, buttonWidth, buttonSize.height}];
          x += buttonWidth;
            [(FMTabBarItemButton*)button setSeparatorColor:self.barItemButtonSeparatorColor];
            [(FMTabBarItemButton*)button setShowsRightSideSeparator:NO];
            if (idx == 0) {
                [(FMTabBarItemButton*)button setShowsLeftSideSeparator:NO];
            }
        }];
        [_containerView setContentSize:(CGSize){x, 0.0}];
        break;
      }
    }
    [self layoutIndicatorLayerWithButton:[_tabBarItemButtons objectAtIndex:[_items indexOfObject:_selectedItem]]];
  }
}

- (void)sizeToFit
{
  [super sizeToFit];
  [self setBounds:(CGRect){
    CGPointZero,
    CGRectGetWidth([[UIApplication sharedApplication] statusBarFrame]),
    44.0
  }];
}

#pragma mark - Property

- (void)setItems:(NSArray *)items
{
  if ([_items isEqualToArray:items] == NO) {
    _items = [items copy];
    
    // TODO
    NSMutableArray *buttons = [NSMutableArray array];
    [items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
      if ([obj isKindOfClass:[UITabBarItem class]]) {
          UITabBarItem *item = obj;
          FMTabBarItemButton *button = [[FMTabBarItemButton alloc] init];
          [button.titleLabel setFont:_tabBarButtonFont];
          [button setImage:item.image forState:UIControlStateNormal];
          [button setTitle:item.title forState:UIControlStateNormal];
          [button setSelectedImage:item.selectedImage];
          [button setImage:item.image];
          [button setBadgeValue:item.badgeValue];
          [button addTarget:self action:@selector(touchesButton:) forControlEvents:UIControlEventTouchDown];
          [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
          [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
          [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
          [button setTitleShadowColor:[UIColor colorWithWhite:0.0f alpha:0.0f]
                             forState:UIControlStateNormal];
          button.titleLabel.shadowColor = [UIColor colorWithWhite:0.0f alpha:0.0f];
          button.titleLabel.shadowOffset = CGSizeMake(-1, 1);
          button.backgroundColor = [UIColor clearColor];
          [_containerView addSubview:button];
          [buttons addObject:button];
      } else if ([obj isKindOfClass:[FMTabBarItemButton class]]) {
          FMTabBarItemButton *button = (FMTabBarItemButton*)obj;
          [button addTarget:self action:@selector(touchesButton:) forControlEvents:UIControlEventTouchDown];
          [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
          [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
          [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
          [button setTitleShadowColor:[UIColor colorWithWhite:0.0f alpha:0.0f]
                             forState:UIControlStateNormal];
          button.titleLabel.shadowColor = [UIColor colorWithWhite:0.0f alpha:0.0f];
          button.titleLabel.shadowOffset = CGSizeMake(-1, 1);
          button.backgroundColor = [UIColor clearColor];
          [_containerView addSubview:button];
          [buttons addObject:button];
      }
    }];
    [_indicatorLayer setBackgroundColor:[UIColor whiteColor].CGColor];
    [_bottomSeparator setBackgroundColor:[UIColor whiteColor].CGColor];
    [self setNeedsLayout];
    self.tabBarItemButtons = [buttons copy];
    
      if (_selectedItem) {
          [self setSelectedItem:[items objectAtIndex:[_items indexOfObject:_selectedItem]]];
      } else {
          [self setSelectedItem:[items firstObject]];
      }
    
  }
}

- (void)setSelectedItem:(UITabBarItem *)selectedItem
{
  if (_selectedItem != selectedItem) {
    
    NSUInteger beforeIndex = [_items indexOfObject:_selectedItem];
    NSUInteger afterIndex = [_items indexOfObject:selectedItem];
    if (beforeIndex != NSNotFound) {
      [_tabBarItemButtons[beforeIndex] setSelected:NO];
    }
    if (afterIndex != NSNotFound) {
      FMTabBarItemButton *button = _tabBarItemButtons[afterIndex];
      _selectedItem = selectedItem;
      [button setSelected:YES];
      
      [self layoutIndicatorLayerWithButton:button];
        CGPoint newContentOffset = CGPointMake(button.frame.origin.x - 50, button.frame.origin.y);
        
        if (newContentOffset.x < 0) {
            newContentOffset.x = 0;
        } else if (newContentOffset.x > (_containerView.contentSize.width - _containerView.frame.size.width)) {
            newContentOffset.x = _containerView.contentSize.width - _containerView.frame.size.width;
        }
        
        [_containerView setContentOffset:newContentOffset animated:YES];
    }
  }
}

- (void)layoutIndicatorLayerWithButton:(UIButton *)button
{
  [CATransaction begin];
  [CATransaction setDisableActions:YES];
  CGFloat width = CGRectGetWidth(self.bounds);
  CGFloat height = CGRectGetHeight(self.bounds);
  [_bottomSeparator setFrame:(CGRect){
    0.0, height - 2.0,
    width, 2.0
  }];
  [_indicatorLayer setFrame:(CGRect){
    CGRectGetMinX(button.frame) + 10.0, height - 5.0f,
    CGRectGetWidth(button.frame) - 20.0, 2.0f
  }];
  [CATransaction commit];
}

- (void)setTabBarStyle:(FMTabBarStyle)tabBarStyle
{
  if (_tabBarStyle != tabBarStyle) {
    _tabBarStyle = tabBarStyle;
    [self setNeedsLayout];
  }
}

- (void) setBarItemButtonSeparatorColor:(UIColor *)barItemButtonSeparatorColor
{
    if ([_barItemButtonSeparatorColor isEqual:barItemButtonSeparatorColor]) {
        return;
    }
    
    _barItemButtonSeparatorColor = barItemButtonSeparatorColor;
    [self setNeedsLayout];
}

#pragma mark - Action

- (void)touchesButton:(UIButton *)sender
{
  NSUInteger index = [_tabBarItemButtons indexOfObject:sender];
  if (index != NSNotFound) {
    UITabBarItem *selectedItem = _items[index];
    
    BOOL shouldSelectItem = YES;
    if ([_delegate respondsToSelector:@selector(tabBar:shouldSelectItem:)]) {
      shouldSelectItem = [_delegate tabBar:self shouldSelectItem:selectedItem];
    }
    if (shouldSelectItem) {
      [sender setHighlighted:YES];
      [self setSelectedItem:selectedItem];
      if ([_delegate respondsToSelector:@selector(tabBar:didSelectItem:)]) {
        [_delegate tabBar:self didSelectItem:selectedItem];
      }
    }
  }
}

@end
