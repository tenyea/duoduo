//
//  MainViewController.m
//  duoduo
//
//  Created by tenyea on 14-3-25.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "SearchViewController.h"
#import "CategoryViewController.h"
#import "CarViewController.h"
#import "MyViewController.h"
#import "BaseNavViewController.h"
#import "TenyeaBaseViewController.h"
#import "AppDelegate.h"
#import "AFHTTPRequestOperationManager.h"
#import "FMDatabase.h"
#import "FileUrl.h"
@interface MainViewController ()
{
    int Badge_;
}
@end

@implementation MainViewController


-(void)viewDidLoad {
    
    [super viewDidLoad];
    //初始化子控制器
    [self _initController];
    //初始化tabbar
    [self _initTabbarView];
    [self refreshBadge:3  andCount:10];
    
//    1分钟同步一次数据
    [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(refreshDate) userInfo:nil repeats:YES];


}
-(void)refreshDate{
//    [self getDate:<#(NSString *)#> andParams:<#(NSDictionary *)#> andcachePolicy:<#(int)#> success:<#^(AFHTTPRequestOperation *operation, id responseObject)success#> failure:<#^(AFHTTPRequestOperation *operation, NSError *error)failure#>];
}
#pragma mark - 
#pragma mark init
//初始化子控制器
-(void)_initController{
    HomeViewController *home=[[HomeViewController alloc]init];
    SearchViewController *search=[[SearchViewController alloc]init];
    CategoryViewController *category=[[CategoryViewController alloc]init];
    CarViewController *car=[[CarViewController alloc]init];
    MyViewController *my=[[MyViewController alloc]init] ;
    
    NSArray *views=@[home,search,category,car,my];
    NSMutableArray *viewControllers=[NSMutableArray arrayWithCapacity:5];
    for (UIViewController *viewController in views) {
        BaseNavViewController *navViewController =[[BaseNavViewController alloc]initWithRootViewController:viewController];
        [viewControllers addObject:navViewController];
        navViewController.delegate = self;
    }
    self.viewControllers=viewControllers;
}
//初始化tabbar
-(void)_initTabbarView{
    [self.tabBar setHidden:YES];
    _tabbarView=[[UIView alloc]init];
    _tabbarView.frame=CGRectMake(0, ScreenHeight-49, ScreenWidth, 49);
    UIImageView *bgImageView = [[UIImageView alloc]init];
    [bgImageView setImage:[UIImage imageNamed:@"tabbar_bg.png"]];
    bgImageView.frame = CGRectMake(0, -2, ScreenWidth, 49+2);
    [_tabbarView addSubview:bgImageView];
    [self.view addSubview:_tabbarView];

    
//    添加滑动器
    _sliderView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tabbar_bg_selected.png"]];
    _sliderView.frame = CGRectMake(0, 0, 64, 49);
    [_tabbarView addSubview:_sliderView];
    NSArray *backgroud = @[@"tabbar_home.png",@"tabbar_search.png",@"tabbar_category.png",@"tabbar_car.png",@"tabbar_my.png"];
    for (int i=0; i<backgroud.count; i++) {
        NSString *backImage =backgroud[i];
        
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(64*i, 0, 64, 49);
        button.tag=100+i;
        [button setImage:[UIImage imageNamed:backImage] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(selectedTab:) forControlEvents:UIControlEventTouchUpInside];
        //设置高亮
        //        [button setShowsTouchWhenHighlighted:YES];
        [_tabbarView addSubview:button];
    }
    
    
}
#pragma mark -
#pragma mark 按钮事件
//tabbar选中事件
-(void)selectedTab:(UIButton *)button
{
    int site = button.tag - 100;
    [UIView animateWithDuration:0.2 animations:^{
            _sliderView.left = site * 64;
        }];
    self.selectedIndex = site;
}
//设置角标
-(void)refreshBadge:(int)item andCount:(int)count{
    
    //    新微薄未读数
    NSNumber *status =  [NSNumber numberWithInt:count];
    
    if (_badgeView == nil) {
        _badgeView = [[UIImageView alloc] init];
        UIImage *image =  [[UIImage imageNamed:@"main_badge.png"]stretchableImageWithLeftCapWidth:5.0 topCapHeight:.0];
        _badgeView.image= image;
        _badgeView.frame = CGRectMake(64 - 25 + item * 64, 5, 10, 10);
        [_tabbarView addSubview:_badgeView];
        UILabel *badgeLabel = [[UILabel alloc]initWithFrame:_badgeView.bounds];
        badgeLabel.textAlignment = NSTextAlignmentCenter;
        badgeLabel.backgroundColor = [UIColor clearColor];
        badgeLabel.font = [UIFont boldSystemFontOfSize:8.0f];
        badgeLabel.textColor = [UIColor whiteColor];
        badgeLabel.tag = 100;
        [_badgeView addSubview:badgeLabel];
    }
    
    int n = [status intValue];
    if (n > 0) {
        
        UILabel *badgeLabel = (UILabel *)[_badgeView viewWithTag:100];
        
        //        最大只显示99
        if (n > 99 ) {
            badgeLabel.text = @"99+";
            badgeLabel.width = 20;
            _badgeView.width = 20;
        }else if(n < 99 && n >9){
            badgeLabel.width = 15;
            _badgeView.width = 15;
            badgeLabel.text = [NSString stringWithFormat:@"%d",n ];
        }else{
            badgeLabel.width = 10;
            _badgeView.width = 10;
            badgeLabel.text = [NSString stringWithFormat:@"%d",n ];
        }
        
        _badgeView.hidden = NO;
    }
    else{
        _badgeView.hidden = YES;
    }
    Badge_ = n ;
}
-(int)getBadge{
    return Badge_;
}
//底部状态栏
-(void)showTabbar:(BOOL)show{
    [UIView animateWithDuration:0.35 animations:^{
        if (show) {
            _tabbarView.left = 0;
        }
        else{
            _tabbarView.left = -ScreenWidth;
        }
    }];
    //    隐藏tabbar时拉伸view的frame，否则会造成原来tabbar处空白
    [self _resizeView:show];
}
//调整tabbar位置
-(void)_resizeView:(BOOL)showTabbar
{
    for (UIView *subView in self.view.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UITransitionView")]) {
            if (showTabbar) {
                subView.height = ScreenHeight - 49 ;
            }
            else{
                subView.height = ScreenHeight ;
            }
        }
    }
}
#pragma mark 按钮事件

#pragma mark --- UINavigationControllerDelegate
- (void)navigationController:(BaseNavViewController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //    导航控制器子控制器的个数
    int count = navigationController.viewControllers.count;
    NSLog(@"[maincontroler]count = %d",count );
    if (count >= 2) {
        [self showTabbar:NO];
    }
    else{
        [self showTabbar:YES];
    }
}
-(void)navigationController:(BaseNavViewController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    int count = navigationController.viewControllers.count;
    if (count >= 2) {
        navigationController.swipeGesture.enabled = YES;
    }else{
        navigationController.swipeGesture.enabled = NO;
    }
}
#pragma mark getDate
-(void)getDate: (NSString *)url andParams:(NSDictionary *)param  andcachePolicy:(int)cachePolicyType success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    
    NSString *baseurl = [BASE_URL stringByAppendingPathComponent:url];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    switch (cachePolicyType) {
        case 0:
            manager.requestSerializer.cachePolicy = NSURLRequestReturnCacheDataDontLoad;
            
            break;
        case 1:
            manager.requestSerializer.cachePolicy = NSURLRequestReloadRevalidatingCacheData;
            break;
        default:
            break;
    }
    [manager GET:baseurl parameters:param success:success failure:failure ];
}


@end
