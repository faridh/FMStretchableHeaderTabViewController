//
//  JKTabViewController.m
//  StretchableHeaderTabViewExample
//
//  Created by Joel Koroniak on 2014-06-20.
//  Copyright (c) 2014 Hiroki Akiyama. All rights reserved.
//

#import "JKTabViewController.h"

@interface JKTabViewController ()

@end

@implementation JKTabViewController

- (UIScrollView*) scrollableComponentView
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

@end
