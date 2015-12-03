//
//  FMTabViewController.m
//  StretchableHeaderTabViewExample
//
//  Created by Joel Koroniak on 2014-06-20.
//  Copyright (c) 2014 Hiroki Akiyama. All rights reserved.
//

#import "FMTabViewController.h"

@interface FMTabViewController ()

@end

@implementation FMTabViewController

- (UIScrollView*) scrollableComponentView
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

@end
