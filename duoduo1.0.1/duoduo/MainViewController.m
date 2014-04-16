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
@interface MainViewController (){
    NSUserDefaults *userDefaults;
}

@end

@implementation MainViewController


-(void)viewDidLoad {
    
    [super viewDidLoad];
//    读取当前userdefaults信息
    userDefaults = [NSUserDefaults standardUserDefaults];
    //初始化首页大图
    [self _initHomePage];
    
    
    


}
#pragma mark - 
#pragma mark init
//初始化首页大图
-(void)_initHomePage{
//    初始化启动图
    homeView = [[UIImageView alloc]init];
    UIImage *homeImage = [UIImage imageNamed:@"home_initVIew.png"];
    [homeView setImage:homeImage];
    homeView.frame = CGRectMake(0, 0, ScreenWidth,ScreenHeight);
    [self.view addSubview:homeView];
//    隐藏状态栏
    [self setStateBarHidden:YES];
//  设置五秒后隐藏启动图
    [self performSelector:@selector(_hiddenHomePage) withObject:nil afterDelay:1];
//  访问网络
    
    

}
//隐藏启动图
-(void)_hiddenHomePage{
    //        移除homeveiw
    [homeView removeFromSuperview];
    
    
//    获取版本号
    NSString *curversion = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    NSString *oldVersion = [userDefaults stringForKey:kbundleVersion];
//    如果版本号跟userdefaults中不一致，则显示引导图
    if (![oldVersion isEqualToString:curversion]) {
//        引导图
//        [self _addGuidePageView];
        //        第一次进入。 直接初始化  出引导图
        if (oldVersion == nil) {
            
            [self _initDB];
        }
        else{//更新内容
            [self _updateDB];
        }


    }
    //状态栏显示
    [self setStateBarHidden:NO];
    //初始化子控制器
    [self _initController];
    //初始化tabbar
    [self _initTabbarView];
    [self refreshBadge:0  andCount:8];
}


-(void)_initDB {
    
}
-(void)_updateDB{
    
}
//增加引导图
-(void)_addGuidePageView{
    //引导页图片名
    NSArray *imageNameArray = @[@"home_initVIew.png",@"home_initVIew.png",@"home_initVIew.png",@"home_initVIew.png"];
    //引导页
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    _scrollView.contentSize = CGSizeMake(320 *imageNameArray.count , ScreenHeight);
    _scrollView.pagingEnabled = YES;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.bounces = NO;
    _scrollView.delegate = self;
    
    //增加引导页图片
    for (int i = 0 ; i < imageNameArray.count  ; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(i*320 , 0, ScreenWidth, ScreenHeight);
        [imageView setImage:[UIImage imageNamed:imageNameArray[i]]];
        [_scrollView addSubview:imageView];
    }
    //进入主界面按钮
    UIButton *button = [[UIButton alloc]init];
    button.titleLabel.numberOfLines = 2;
    button.backgroundColor = CLEARCOLOR;
    button.titleLabel.backgroundColor = CLEARCOLOR;
    [button setTitle:@"进入\n东北新闻网" forState:UIControlStateNormal];
    [button setTitleColor:BackgroundColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(enter) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(320*imageNameArray.count -150, ScreenHeight-180, 100, 50);
    [_scrollView addSubview:button];
    [self.view addSubview:_scrollView];
    
    //增加pageview
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    pageControl.frame = CGRectMake((ScreenWidth-100)/2, ScreenHeight -70, 100, 30);
    pageControl.tag = 100;
    if (WXHLOSVersion()>=6.0) {
        pageControl.pageIndicatorTintColor = [UIColor grayColor];
        pageControl.currentPageIndicatorTintColor = BackgroundColor;
    }
    pageControl.currentPage = 0 ;
    pageControl.numberOfPages = imageNameArray.count;
    pageControl.backgroundColor = [UIColor clearColor];
    [pageControl addTarget:self action:@selector(pageindex:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:pageControl];
}
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
}
//-(void)showBadge:(BOOL)show{
//    
//    _badgeView.hidden = !show;
//    
//}
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
- (void)enter{
    UIPageControl *pageControl = (UIPageControl *)[self.view viewWithTag:100] ;
    [UIView animateWithDuration:0.5 animations:^{
        _scrollView.alpha = 0 ;
        pageControl.alpha = 0 ;
    } completion:^(BOOL finished) {
        //隐藏状态
        [self setStateBarHidden:NO];
        //        [_userDefaults setBool:YES forKey:kisNotFirstLogin];
        NSString *curversion = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
        
//        [_userDefaults setObject:curversion forKey:kbundleVersion];
//        [_userDefaults synchronize];
//        [pageControl removeFromSuperview];
//        [self _initViewController];
        
    }];
}
//pagecontrol 事件
- (void)pageindex:(UIPageControl *)pagecontrol{
    CGRect frame = CGRectMake(pagecontrol.currentPage* ScreenWidth, 0, ScreenWidth, ScreenHeight);
    [_scrollView scrollRectToVisible:frame animated:YES];
}
#pragma mark --- UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
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

#pragma mark -
#pragma mark 适配ios7
static UIStatusBarStyle statusBarStyle = UIStatusBarStyleDefault;
static bool isBarHidden = NO;
static   TenyeaBaseViewController* viewControllerv = nil;
+ (UIStatusBarStyle)statusBarStyle
{
    return statusBarStyle;
}
+ (BOOL)statusBarHidden
{
    return isBarHidden;
}

-(void)setStateBarHidden :(BOOL) statusBarHidden{
    if (WXHLOSVersion()>=7.0) {
        [self setStatusBarStyle:UIStatusBarStyleLightContent];
        [self setStatusBarHidden:statusBarHidden];
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];

        
    }else{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
        [[UIApplication sharedApplication] setStatusBarHidden:statusBarHidden];
    }
}
-(BOOL)prefersStatusBarHidden{
    return isBarHidden;
}
- (void)setStatusBarHidden:(BOOL)isHidden
{
    if (WXHLOSVersion()>=7.0) {
        isBarHidden = isHidden;
//        [viewControllerv setNeedsStatusBarAppearanceUpdate];
    }
}
- (void)setStatusBarStyle:(UIStatusBarStyle)style
{
    if (WXHLOSVersion()>=7.0) {
        statusBarStyle = style;
//        [viewControllerv setNeedsStatusBarAppearanceUpdate];
    }
}
@end
