//
//  CoursesView.m
//  duoduo
//
//  Created by tenyea on 14-4-14.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "CoursesView.h"

@implementation CoursesView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    //        圆角
    _button.layer.cornerRadius = 10;
    _button.layer.masksToBounds = YES;
    _bgView.layer.cornerRadius = 10;
    _bgView.layer.masksToBounds = YES;
}

- (IBAction)TouchAction:(id)sender {
    [self.viewController.navigationController pushViewController:[[UIViewController alloc]init] animated:YES];
}
@end
