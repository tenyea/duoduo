//
//  TYTableView.h
//  duoduo
//
//  Created by tenyea on 14-4-11.
//  Copyright (c) 2014年 zzw. All rights reserved.
//
@protocol TYTableViewDelegate <NSObject>
//可选事件
@optional
-(void)loadMoreDate;//加载更多数据
-(void)refreshDate;//刷新
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;//选中cell
@end
#import <UIKit/UIKit.h>

@interface TYTableView : UITableView <UITableViewDataSource,UITableViewDelegate >
{
    //  加载按钮
    UIButton *_moreButton;
}

@property (nonatomic ,retain) NSArray *dataArray ;//网络加载的数据
@property (nonatomic ,assign) BOOL isMore;//是否有加载功能
@property (nonatomic ,assign) BOOL refreshHeader;//是否有刷新功能
@property (nonatomic ,assign) id<TYTableViewDelegate> eventDelegate;
//  隐藏更多按钮
@property (nonatomic ,assign) BOOL hiddenMoreButton;//yes 隐藏 no 不隐藏
#pragma mark method
-(id)initWithFrame:(CGRect)frame isMore:(BOOL)isMore refreshHeader:(BOOL)refreshHeader;

-(void)donerefreshData;
@end
