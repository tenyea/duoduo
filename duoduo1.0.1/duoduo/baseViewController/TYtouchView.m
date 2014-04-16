//
//  TYtouchView.m
//  duoduo
//
//  Created by tenyea on 14-4-12.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "TYtouchView.h"

@implementation TYtouchView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //        允许触摸
        self.userInteractionEnabled = YES;
        //        添加手势
        UITapGestureRecognizer *tapGeture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tapGeture];
    }
    return self;
}


-(void)tapAction:(UITapGestureRecognizer *)tap{
    if (self.touchBlock) {
        _touchBlock();
    }
}
@end
