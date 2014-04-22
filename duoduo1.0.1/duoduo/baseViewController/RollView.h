//
//  RollView.h
//  duoduo
//
//  Created by tenyea on 14-4-19.
//  Copyright (c) 2014年 zzw. All rights reserved.
//
@protocol RollViewDelegate <NSObject>

- (void)PageExchange:(NSInteger)index;


@end


#import <UIKit/UIKit.h>

@interface RollView : UIScrollView{
    int _index;
    int _leftIndex;
    int _rightIndex;
}
//内容数组
@property (nonatomic,retain) NSArray *contentArr;
@property (nonatomic,assign) id<RollViewDelegate> eventDelegate;

@end
