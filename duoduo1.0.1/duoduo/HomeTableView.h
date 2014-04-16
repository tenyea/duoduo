//
//  HomeTableView.h
//  duoduo
//
//  Created by tenyea on 14-4-12.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "TYTableView.h"
#import "XLCycleScrollView.h"

@interface HomeTableView : TYTableView <XLCycleScrollViewDatasource,XLCycleScrollViewDelegate>{
    int cellCount ;//cell个数
    //轮播图
    UIPageControl *pageControl;
}

@property (nonatomic ,retain) NSDictionary *dataDic;//首页数据
@end
