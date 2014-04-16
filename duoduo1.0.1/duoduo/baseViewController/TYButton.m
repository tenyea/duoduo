//
//  TYButton.m
//  duoduo
//
//  Created by tenyea on 14-3-28.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "TYButton.h"

@implementation TYButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTarget:self action:@selector(touchesEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


-(void)touchesEvent:(UIButton *)button{
    if (self.touchBlock) {
        _touchBlock(self);
    }
}

@end
