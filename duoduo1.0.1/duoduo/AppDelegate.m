//
//  AppDelegate.m
//  duoduo
//
//  Created by tenyea on 14-3-25.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "AppDelegate.h"
//#import "BaiduMobStat.h"
#import "MainViewController.h"
#import "MBProgressHUD.h"
//#define launchServlet @"Launch"
#import "FMDatabase.h"
#import "FileUrl.h"
//#import "OpenUDID.h"
@implementation AppDelegate
#pragma mark method 
/*
//初始化统计信息
//-(void)initbadiduMobStat{
//    BaiduMobStat* statTracker = [BaiduMobStat defaultStat];
//    statTracker.enableExceptionLog = YES; // 是否允许截获并发送崩溃信息，请设置YES或者NO
////    statTracker.channelId = @"";//设置您的app的发布渠道
//    statTracker.logStrategy = BaiduMobStatLogStrategyAppLaunch;//根据开发者设定的时间间隔接口发送 也可以使用启动时发送策略
//    statTracker.logSendInterval = 1;//设置日志发送时间间隔
//    statTracker.enableDebugOn = YES; //打开调试模式，发布时请去除此行代码或者设置为False即可。
//    //    statTracker.logSendInterval = 1; //为1时表示发送日志的时间间隔为1小时,只有 statTracker.logStrategy = BaiduMobStatLogStrategyAppLaunch这时才生效。
//    statTracker.logSendWifiOnly = NO; //是否仅在WIfi情况下发送日志数据
//    statTracker.sessionResumeInterval = 1;//设置应用进入后台再回到前台为同一次session的间隔时间[0~600s],超过600s则设为600s，默认为30s
//    NSString *version = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleShortVersionString"];
//    statTracker.shortAppVersion = version;
//    
////    statTracker.enableDebugOn = YES;//关闭调试,可以去除该代码或者设置为 NO。
//    [statTracker startWithAppId:BaiduMobStat_APPID];//设置您在mtj网站上添加的app的appkey
//}
*/
 - (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    [NSThread sleepForTimeInterval:3];
     
     //    获取版本号
     NSString *curversion = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
     NSString *oldVersion = [[NSUserDefaults standardUserDefaults] stringForKey:kbundleVersion];
     if ( ![curversion isEqualToString:oldVersion] ) {
         if ( oldVersion ==nil) {
             [self _initDB];
         }else{
             [self _updateDB];
         }
     }
     /*
      同步加载网路数据
//     NSString *baseURL = [BASE_URL stringByAppendingPathComponent:launchServlet];
//     NSString *url = [NSString stringWithFormat:@"%@?DeviceID=%@&&Version=%@",baseURL,[OpenUDID value],oldVersion];
//     NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:url]];
//     [request setTimeoutInterval:5];
//     [request setHTTPMethod:@"GET"];
//     NSHTTPURLResponse *response;
//     NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
//     if (returnData) {
//         NSDictionary *requestDic = [NSJSONSerialization JSONObjectWithData:returnData options:NSJSONReadingMutableContainers error:nil];
//     }
     */
    
    return YES;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    设置角标为0
    [application setApplicationIconBadgeNumber:0];
    // 注册通知（声音、标记、弹出窗口）
    if(!application.enabledRemoteNotificationTypes){
        NSLog(@"Initiating remoteNoticationssAreActive1");
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeBadge)];
    }
//    初始化统计信息
//    [self initbadiduMobStat];
//    推送通知
    if (launchOptions !=nil) {
#warning message
//        NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
//        NSString *alertString = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
        
    }

//    初始化
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.mainVC = [[MainViewController alloc]init];
    self.window.rootViewController = self.mainVC;
    NSString *oldVersion = [[NSUserDefaults standardUserDefaults] stringForKey:kbundleVersion];

    if (oldVersion == nil) {
        [self _addGuidePageView];
    }
    [self.window makeKeyAndVisible];
    
    //设置百度推送代理
    [BPush setupChannel:launchOptions];
    [BPush setDelegate:self];
//    隐藏二级子菜单
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kisshowSecondView];
    [[NSUserDefaults standardUserDefaults]synchronize];
        
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{

}


//注册token
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    [BPush registerDeviceToken: deviceToken];
    if ([[NSUserDefaults standardUserDefaults]objectForKey:BPushappid] ==nil||[[[NSUserDefaults standardUserDefaults]objectForKey:BPushappid]isEqualToString:@""]) {
        //绑定
        [BPush bindChannel];
    }
}

//后台激活后 移除推送信息
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    //    NSLog(@"Receive Notify: %@", [userInfo JSONString]);
    NSString *alertString = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    if (application.applicationState == UIApplicationStateActive) {
        NSString *newsId = [userInfo objectForKey:@"newsId"];
        if (newsId) {
            // Nothing to do if applicationState is Inactive, the iOS already displayed an alert view.
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"推送新闻:"
                                                                message:[NSString stringWithFormat:@"%@", alertString]
                                                               delegate:self
                                                      cancelButtonTitle:@"好的"
                                                      otherButtonTitles:@"查看",nil];
            
#warning <#message#>
            [alertView show];
        }else{
            // Nothing to do if applicationState is Inactive, the iOS already displayed an alert view.
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"推送新闻:"
                                                                message:[NSString stringWithFormat:@"%@", alertString]
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
            [alertView show];
            
        }
    }else if (application.applicationState == UIApplicationStateInactive){//进入激活状态  默认查看新闻
        NSString *newsId = [userInfo objectForKey:@"newsId"];
        if (newsId) {
#warning <#message#>
//            ColumnModel *model = [[ColumnModel alloc]init];
//            model.newsId = newsId;
//            model.title = alertString;
//            model.newsAbstract = [userInfo objectForKey:@"newsAbstract"];
//            model.type = [userInfo objectForKey:@"type"];
//            model.img = [userInfo objectForKey:@"img"];
//            model.isselected = NO;
//            _pushModel = model;
//            [[NSNotificationCenter defaultCenter]postNotificationName:kPushNewsNotification object:_pushModel];
        }
        
    }
    [application setApplicationIconBadgeNumber:0];
    [BPush handleNotification:userInfo];
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{

}


#pragma mark pushdelegate  回调函数
- (void) onMethod:(NSString*)method response:(NSDictionary*)data {
    NSLog(@"On method:%@", method);
    NSLog(@"data:%@", [data description]);
    NSDictionary* res = [[NSDictionary alloc] initWithDictionary:data];
    if ([BPushRequestMethod_Bind isEqualToString:method]) {//绑定
        NSString *appid = [res valueForKey:BPushRequestAppIdKey];
        NSString *userid = [res valueForKey:BPushRequestUserIdKey];
        NSString *channelid = [res valueForKey:BPushRequestChannelIdKey];
        int returnCode = [[res valueForKey:BPushRequestErrorCodeKey] intValue];
        if (returnCode == BPushErrorCode_Success) {
            NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
            [user setValue:appid forKey:BPushappid];
            [user setValue:userid forKey:BPushuserid];
            [user setValue:channelid forKey:BPushchannelid];
            //同步
            [user synchronize];
            
        }
    } else if ([BPushRequestMethod_Unbind isEqualToString:method]) {//解除绑定
        int returnCode = [[res valueForKey:BPushRequestErrorCodeKey] intValue];
        if (returnCode == BPushErrorCode_Success) {
            NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
            [user removeObjectForKey:BPushchannelid];
            [user removeObjectForKey:BPushuserid];
            [user removeObjectForKey:BPushappid];
            //同步
            [user synchronize];
        }
    }
    
}

//接收本地推送
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification*)notification{
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"iWeibo" message:notification.alertBody delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//    [alert show];
    // 图标上的数字减1
    application.applicationIconBadgeNumber -= 1;
    [application cancelLocalNotification:notification];

}
- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    //设置角标为0
    [application setApplicationIconBadgeNumber:0];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

#pragma mark DB
-(void)_updateDB{
    
}
-(void)_initDB {
    //    栏目
    NSMutableArray *categoryArr = [[NSMutableArray alloc]init];
    NSArray *name = @[@"语言能力",@"数理逻辑",@"肢体运动",@"艺术特色",@"观察认识",@"行为习惯",@"性格心理",@"想象记忆"];
    NSArray *desc = @[@"父子对话：最好的沟通怎么做？",
                      @"生活小习惯 提升高超数学智能",
                      @"趣味中跳动宝宝的手脚协调能力",
                      @"培养钢琴小天才 先让他玩起来",
                      @"宝宝左右脑开发 聪明翻两倍",
                      @"孩子注意力不集中 该如何应对",
                      @"明智的家长 善于发现孩子的亮点",
                      @"生活小改变 创意激发SO EASY"];
    for (int i = 0 ; i < name.count ; i ++) {
        NSDictionary *dic = @{@"title": name[i],@"desc":desc[i],@"categoryID":[NSNumber numberWithInteger:i],@"img":[NSString stringWithFormat:@"category%d.png",i]};
        [categoryArr addObject:dic];
    }
    [[NSUserDefaults standardUserDefaults]setObject:categoryArr forKey:kcategoryArray];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    
    //初始化数据库
    FMDatabase *db = [FileUrl getDB];
    if (![db open]) {
        NSLog(@"Could not open db.");
        return ;
    }
    
    
    //    推送通知表
    //    id , 标题（string）,内容（string）,时间, 是否阅读(0:未读 1:已读)，类别（0：普通课程 1：课程专题），模板编号 ，专题或者课程编号
    [db executeUpdate:@"CREATE TABLE pushNotificationHistory (id INTEGER PRIMARY KEY, title TEXT,content TEXT, pushTime TEXT, isread INTEGER,category INTEGER,template INTEGER,courseId TEXT)"];
    
    //    搜索历史表
    [db executeUpdate:@"CREATE TABLE searchHistory (searchContent TEXT PRIMARY KEY)"];
    
    //    购物车
    //    id,图片地址，课程标题，课程编号，价格，是否选中,添加时间
    [db executeUpdate:@"CREATE TABLE shoppingCar (id INTEGER PRIMARY KEY,imageURL TEXT,title TEXT,courseID TEXT,price Integer,isselected Integer,addDate TEXT)"];
    
    //    数据库关闭
    [db close];
}


//增加引导图
-(void)_addGuidePageView{
    //引导页图片名
    NSArray *imageNameArray = @[@"Default.png",@"Default.png",@"Default.png",@"Default.png"];
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
    [self.window.rootViewController.view addSubview:_scrollView];
    
    //增加pageview
    _pageControl = [[UIPageControl alloc]init];
    _pageControl.frame = CGRectMake((ScreenWidth-100)/2, ScreenHeight -70, 100, 30);
    _pageControl.tag = 100;
    if (WXHLOSVersion()>=6.0) {
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        _pageControl.currentPageIndicatorTintColor = BackgroundColor;
    }
    _pageControl.currentPage = 0 ;
    _pageControl.numberOfPages = imageNameArray.count;
    _pageControl.backgroundColor = [UIColor clearColor];
    [_pageControl addTarget:self action:@selector(pageindex:) forControlEvents:UIControlEventValueChanged];
    [self.window.rootViewController.view addSubview:_pageControl];
}
#pragma mark Action
- (void)enter{
    [UIView animateWithDuration:.5 animations:^{
        _scrollView.alpha = 0 ;
        _pageControl.alpha = 0 ;
    } completion:^(BOOL finished) {
        if (finished) {
            [_scrollView  removeFromSuperview];
            [_pageControl removeFromSuperview];
            _scrollView = nil;
            _pageControl = nil;
        }
    }];
}
//pagecontrol 事件
- (void)pageindex:(UIPageControl *)pagecontrol{
    CGRect frame = CGRectMake(pagecontrol.currentPage* ScreenWidth, 0, ScreenWidth, ScreenHeight);
    [_scrollView scrollRectToVisible:frame animated:YES];
}
#pragma mark scrolldelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int pageindex = _scrollView.contentOffset.x / 320 ;
    _pageControl.currentPage = pageindex;
}
@end
