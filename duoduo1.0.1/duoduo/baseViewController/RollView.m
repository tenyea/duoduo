//
//  RollView.m
//  duoduo
//
//  Created by tenyea on 14-4-19.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "RollView.h"
#import "TYImageView.h"
@implementation RollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    self.frame = CGRectMake( 0, 13 , 280, 60);
    _index = 0;
    _contentArr = @[@"my_head_button",@"my_camera_button.png",@"my_course_search.png",@"my_course.png",@"my_message.png",@"my_share_course.png",@"my_ account_ manage.png",@"my_recommend_course.png"];
    [self _initView];

}

-(void)_initView{
    
    for (int i = 0 ; i < 7  ; i ++) {
        TYImageView *imageView = [[TYImageView alloc]initWithFrame: CGRectMake(-53 + i *56 , 5 , 50, 50)];
        if (i == 0 ||i == 6) {
            imageView.hidden = YES;
        }
        int index = _index + i;
        if (index > _contentArr.count-1) {
            index -= _contentArr.count;
        }
        imageView.touchBlock = ^(){
            switch (i) {
                case 1:
                    [self moveToRight:2];
                    break;
                case 2:
                    [self moveToRight:1];
                    break;
                case 4:
                    [self moveToLeft:1];
                    break;
                case 5:
                    [self moveToLeft:2];
                    break;
                default:
                    break;
            }
        };
        imageView.image = [UIImage imageNamed:_contentArr [index]];
        [self addSubview:imageView];
    }
    
//    添加左右拉手势
    UISwipeGestureRecognizer *swipeLeftGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(dragTableView:)];
    swipeLeftGesture.direction=UISwipeGestureRecognizerDirectionLeft;//不设置黑夜是右
    [self addGestureRecognizer:swipeLeftGesture];
    UISwipeGestureRecognizer *swipeLeftGesture1=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(dragTableView:)];
    [self addGestureRecognizer:swipeLeftGesture1];
    [self.eventDelegate PageExchange:_index+3];

}

-(void)dragTableView:(UISwipeGestureRecognizer *)swipeLeftGesture{
    //    indexView = thirdView;
    
    switch (swipeLeftGesture.direction) {
        case UISwipeGestureRecognizerDirectionLeft:{
            [self moveToLeft:1];
        }
            break;
        case UISwipeGestureRecognizerDirectionRight:{
            [self moveToRight:1];
        }
            break;
        default:
            break;
    }
}


-(void)moveToLeft:(int)offset{
//    _index ++;
    _index += offset;
    if (_index >= _contentArr.count) {
        _index -=_contentArr.count;
    }
    NSArray *viewArr = [self subviews];
    for ( int i = 0 ; i < viewArr.count ; i ++) {
        UIImageView *image = viewArr[i];
        image.left -=56*offset;
        if (i == viewArr.count -1 ) {
            image.hidden = NO;
        }
    }
    if (viewArr.count) {
        [viewArr makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    [self _initView];
}
-(void)moveToRight:(int)offset{
    _index -=offset ;
    if (_index< 0) {
        _index += _contentArr.count;
    }
    NSArray *viewArr = [self subviews];
    for ( int i = 0 ; i < viewArr.count ; i ++) {
        UIImageView *image = viewArr[i];
        image.left +=56*offset;
        if (i == 0 ) {
            image.hidden = NO;
        }
    }
    for (int i = 0 ; i < viewArr.count; i ++) {
        UIImageView *image = viewArr[i];
        [image removeFromSuperview];
    }
    [self _initView];
}
@end
