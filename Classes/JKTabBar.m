//
//  JKTabBar.m
//  Pods
//

#import "JKTabBar.h"
#import "JKTabBarItemButton.h"

#define MIN_TAB_BUTTON_WIDTH 100

@interface JKTabBar ()
@property (readonly, nonatomic) UIScrollView *containerView;
@property (readonly, nonatomic) UIToolbar *toolbar;
@property (copy, nonatomic) NSArray *tabBarItemButtons;
@end

@implementation JKTabBar {
  NSArray *_items;
  CALayer *_bottomSeparator;
  CALayer *_indicatorLayer;
  JKTabBarStyle _tabBarStyle;
}

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    _tabBarButtonFont = [UIFont systemFontOfSize:14.0];
    
    _toolbar = [[UIToolbar alloc] init];
    _toolbar.userInteractionEnabled = NO;
    [self addSubview:_toolbar];
    
    _containerView = [[UIScrollView alloc] init];
    _containerView.bounces = NO;
    _containerView.showsHorizontalScrollIndicator = NO;
    _containerView.decelerationRate = UIScrollViewDecelerationRateFast;
      _containerView.scrollEnabled = NO;
      _containerView.contentInset = UIEdgeInsetsMake(0, 50, 0, [UIScreen mainScreen].bounds.size.width - 150);
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
   
  if (_tabBarItemButtons.count > 0) {
    CGSize buttonSize = (CGSize){MAX( MIN_TAB_BUTTON_WIDTH, CGRectGetWidth(self.bounds)/ _tabBarItemButtons.count), CGRectGetHeight(self.bounds)};
    switch (_tabBarStyle) {
      case JKTabBarStyleDefault: {
        [_tabBarItemButtons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
          [button setFrame:(CGRect){buttonSize.width * idx, 0.0, buttonSize}];
        }];
        [_containerView setContentSize:CGSizeMake(buttonSize.width * _tabBarItemButtons.count, buttonSize.height)];
        break;
      }
      case JKTabBarStyleVariableWidthButton: {
        __block CGFloat x = 8.0;
        [_tabBarItemButtons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
          [button sizeToFit];
          CGFloat buttonWidth = CGRectGetWidth(button.bounds);
          [button setFrame:(CGRect){x, 0.0, buttonWidth, buttonSize.height}];
          x += buttonWidth;
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
        JKTabBarItemButton *button = [[JKTabBarItemButton alloc] init];
        [button.titleLabel setFont:_tabBarButtonFont];
        [button setImage:item.image forState:UIControlStateNormal];
        [button setTitle:item.title forState:UIControlStateNormal];
        [button setBadgeValue:item.badgeValue];
        [button addTarget:self action:@selector(touchesButton:) forControlEvents:UIControlEventTouchDown];
        [button setTitleColor:self.tintColor forState:UIControlStateSelected];
        [button setTitleColor:self.tintColor forState:UIControlStateHighlighted];
        [_containerView addSubview:button];
        [buttons addObject:button];
      }
    }];
    [_indicatorLayer setBackgroundColor:[self.tintColor CGColor]];
    [_bottomSeparator setBackgroundColor:[self.tintColor CGColor]];
    [self setNeedsLayout];
    self.tabBarItemButtons = [buttons copy];
    
    [self setSelectedItem:[items firstObject]];
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
      JKTabBarItemButton *button = _tabBarItemButtons[afterIndex];
      _selectedItem = selectedItem;
      [button setSelected:YES];
      
      [self layoutIndicatorLayerWithButton:button];
        [_containerView setContentOffset:CGPointMake(button.frame.origin.x - 50, button.frame.origin.y) animated:YES];
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
    0.0, height - 1.0,
    width, 1.0
  }];
  [_indicatorLayer setFrame:(CGRect){
    CGRectGetMinX(button.frame), height - 2.0,
    CGRectGetWidth(button.frame), 2.0
  }];
  [CATransaction commit];
}

- (void)setTabBarStyle:(JKTabBarStyle)tabBarStyle
{
  if (_tabBarStyle != tabBarStyle) {
    _tabBarStyle = tabBarStyle;
    [self setNeedsLayout];
  }
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
