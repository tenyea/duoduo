//
//  TenyeaBaseViewController.m
//  duoduo
//
//  Created by tenyea on 14-3-25.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "TenyeaBaseViewController.h"
#import "AFHTTPRequestOperationManager.h"
//#import "BaiduMobStat.h"
@interface TenyeaBaseViewController ()

@end

@implementation TenyeaBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NSArray *viewControllers = self.navigationController.viewControllers;
    if (self.isCancelButton) {
        //        UIBarButtonItem *cancelItem=[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cencel)];
        //        self.navigationItem.leftBarButtonItem=[cancelItem autorelease];
        UIButton *button = [[UIButton alloc]init];
        button.backgroundColor = BackgroundColor;
        [button setImage:[UIImage imageNamed:@"navagiton_back.png"] forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, 40, 40);
        //        button.showsTouchWhenHighlighted = YES;
        [button addTarget:self action:@selector(cencel) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationItem.leftBarButtonItem = backItem;
    }else{
        if (viewControllers.count > 1 ) {
            UIButton *button = [[UIButton alloc]init];
            button.backgroundColor = BackgroundColor;
            //        [button setTitle:@"返回" forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"navagiton_back.png"] forState:UIControlStateNormal];
            button.frame = CGRectMake(0, 0, 40, 40);
            //        button.showsTouchWhenHighlighted = YES;
            [button addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
            self.navigationItem.leftBarButtonItem = backItem;
        }
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(void)viewWillAppear:(BOOL)animated{
//    NSString *cName  = [NSString stringWithFormat:@"%@",self.tabBarItem.title ,nil];
//    [[BaiduMobStat defaultStat] pageviewStartWithName:cName];
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
//    NSString *cName  = [NSString stringWithFormat:@"%@",self.tabBarItem.title ,nil];
//    [[BaiduMobStat defaultStat] pageviewEndWithName:cName];
    [super viewWillDisappear:animated];
}
-(AppDelegate *)appDelegate{
    AppDelegate *appDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    return  appDelegate;
}
#pragma mark -
#pragma mark ----按钮事件
-(void)cencel{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -
#pragma mark Data
//访问网络获取数据
//cachePolicyType 0:只读本地数据 。NSURLRequestReturnCacheDataDontLoad 只使用cache数据，如果不存在cache，请求失败;用于没有建立网络连接离线模式;
//                1:本地于与网络比较。NSURLRequestReloadRevalidatingCacheData验证本地数据与远程数据是否相同，如果不同则下载远程数据，否则使用本地数据。
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
#pragma mark -
#pragma mark UI
-(void)setTitle:(NSString *)title{
    [super setTitle:title];
    UILabel *titlelabel=[[UILabel alloc]initWithFrame:CGRectZero];
    titlelabel.font=[UIFont boldSystemFontOfSize:18.0f];
    titlelabel.backgroundColor= CLEARCOLOR;
    titlelabel.text=title;
    titlelabel.textColor=TextColor;
    [titlelabel sizeToFit];
    self.navigationItem.titleView = titlelabel;
}
-(void)showHUDwithLabel :(NSString *)title{
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:HUD];
	
//	HUD.delegate = self;
    if (title) {
        HUD.labelText = title;
    }else {
        HUD.labelText = button_loading;
    }
    [HUD show:YES];
	
}
//隐藏移除加载框
-(void)removeHUD{
    [HUD hide:YES];
    [HUD removeFromSuperview];
}
#pragma mark -
#pragma mark Delegate

@end
