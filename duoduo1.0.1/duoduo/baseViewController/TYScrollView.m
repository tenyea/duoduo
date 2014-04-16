//
//  TYScrollView.m
//  duoduo
//
//  Created by tenyea on 14-4-9.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "TYScrollView.h"
#import "UIScrollView+BalloonPullToRefresh.h"
@implementation TYScrollView

-(id)initWithFrame:(CGRect)frame isMore:(BOOL)isMore refreshHeader:(BOOL)refreshHeader{
    
    if ([self initWithFrame:frame]) {
        self.refreshHeader = refreshHeader;
        [self _initView];
        self.isMore = isMore;
    }
    return self;
}

-(void)_initView{
//    支持滑动最顶端
    self.scrollsToTop = YES;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    _moreButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _moreButton.backgroundColor=[UIColor clearColor];
    _moreButton.frame=CGRectMake(0, 0, ScreenWidth, 40);
    _moreButton.titleLabel.font=[UIFont systemFontOfSize:16.0f];
    [_moreButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_moreButton setTitle:button_loadMoreData forState:UIControlStateNormal];
    [_moreButton addTarget:self action:@selector(loadMoredata) forControlEvents:UIControlEventTouchUpInside];

    
    //风火轮视图
    UIActivityIndicatorView *activityView=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityView.backgroundColor = [UIColor redColor];
    activityView.tag=1000;
    activityView.frame=CGRectMake(100, 10, 20, 20);
    [activityView stopAnimating];
    [_moreButton addSubview:activityView];
    
    [self addSubview:_moreButton];
    
    self.delegate = self;
}
-(void)setIsMore:(BOOL)isMore{
    _isMore = isMore;
    if (_isMore) {
        [self addSubview:_moreButton];
    }else{
        if ([_moreButton superclass]) {
            [_moreButton removeFromSuperview];
        }
    }
}
-(void)setRefreshHeader:(BOOL)refreshHeader{
    _refreshHeader = refreshHeader;
    if (_refreshHeader) {
        __typeof (&*self) __weak weakSelf = self;
        [self addPullToRefreshWithActionHandler:^ {
            int64_t delayInSeconds = 1.0;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [weakSelf refreshTriggered];
            });
        }];
        self.pullToRefreshController.waitingAnimation = BalloonPullToRefreshWaitAnimationFade;
    }
}

-(void)setHiddenMoreButton:(BOOL)hiddenMoreButton{
    _hiddenMoreButton = hiddenMoreButton;
    //隐藏
    if (_hiddenMoreButton) {
        [_moreButton setTitle:button_loadEnd forState:UIControlStateNormal];
        _moreButton.enabled = NO;
    }else{//显示button
        [_moreButton setTitle:button_loadMoreData forState:UIControlStateNormal];
        _moreButton.enabled = YES;
    }
}
- (void)refreshTriggered {
    if ([self.eventDelegate respondsToSelector:@selector(refreshDate)]) {
        [self.eventDelegate refreshDate];
        if (_isMore) {
            self.hiddenMoreButton = NO;
        }
    }
}
//加载完成
-(void)donerefreshData{
    [self.pullToRefreshController didFinishRefresh];
    if (_isMore) {
        [self _stopLoadMore];
    }
}

//加载更多数据
-(void)loadMoredata{
    if([self.eventDelegate respondsToSelector:@selector(loadMoreDate)]){
        [self.eventDelegate loadMoreDate];
        [self _startLoadMore];
    }
}
//风火轮转
-(void)_startLoadMore{
    [_moreButton setTitle:button_loading forState:UIControlStateNormal];
    _moreButton.enabled = NO;
    UIActivityIndicatorView *activityView=(UIActivityIndicatorView *)[_moreButton viewWithTag:1000];
    [activityView startAnimating];
}
-(void)setContentSize:(CGSize)contentSize{
    if (_isMore) {
        _moreButton.top = contentSize.height;
    }
    [super setContentSize:contentSize];
}
-(void)_stopLoadMore{
    _moreButton.hidden = NO;
    [_moreButton setTitle:button_loadMoreData forState:UIControlStateNormal];
    _moreButton.enabled=YES;
    UIActivityIndicatorView *activityView=(UIActivityIndicatorView *)[_moreButton viewWithTag:1000];
    [activityView stopAnimating];
}

#pragma  mark UIScrollViewDelegate
//拖拽时停止调用
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView.contentOffset.y < 0) {
        return;
    }
    if (scrollView.contentOffset.y+(scrollView.frame.size.height) > scrollView.contentSize.height +60 ) {
        if([self.eventDelegate respondsToSelector:@selector(loadMoreDate)]){
            [self.eventDelegate loadMoreDate];
            [self _startLoadMore];
        }
    }
}

@end
