//
//  CarViewController.m
//  duoduo
//
//  Created by tenyea on 14-4-23.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "CarViewController.h"
#define car_title @"购物车还是空的"
#import "BuyCarCell.h"
#import "Network.h"
@interface CarViewController ()
{
    NSTimer *timer;
}
@end

@implementation CarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"购物车";
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    判断当前网络环境
    if (![Network isConnectionAvailable]) {
        [self noneNetWork];
        
        return ;
    }
    else{
        if (netLabel) {
            netLabel.hidden = YES;
        }
    }
//    初始化数据
    [self _initData];
}
-(void)setViewHidden:(BOOL)hidden{
    if (noneCarLabel) {
        noneCarLabel.hidden = !hidden;
    }
    bottomBgView.hidden = hidden;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self _initBgView];
    [self _initBgTabelView];
}
//加载数据
-(void)_initData{
    if(dataArr.count > 0 ){
        [self setViewHidden:NO];
    }else{
        if (!noneCarLabel) {
            noneCarLabel = [[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth - 200)/2, (ScreenHeight - 20)/2-100, 200, 20)];
            noneCarLabel.textColor = [UIColor grayColor];
            noneCarLabel.textAlignment = NSTextAlignmentCenter;
            noneCarLabel.text = car_title;
            noneCarLabel.hidden = YES;
            [self.view addSubview:noneCarLabel];
        }
        [self setViewHidden:YES];
    }

}
-(void)_initBgView{
//    if (WXHLOSVersion()>= 7.0) {
//        bottomBgView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight - 49 - 20 - 44-62, 320, 60)];
//    }else{
        bottomBgView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight - 49 - 20 - 44-60, 320, 60)];
//    }
    bottomBgView.backgroundColor = [UIColor grayColor];
    bottomBgView.alpha = .8;
    
//    选中按钮
    UIButton *selectButton = [[UIButton alloc]initWithFrame:CGRectMake(5, 10, 40, 40)];
    [selectButton setImage:[UIImage imageNamed:@"car_deselect_bg.png"] forState:UIControlStateNormal];
    [selectButton setImage:[UIImage imageNamed:@"car_select_bg.png"] forState:UIControlStateSelected];
    [selectButton addTarget:self action:@selector(selectedAction:) forControlEvents:UIControlEventTouchUpInside];
    [bottomBgView addSubview:selectButton];
    
    
//    总计
    UILabel *totle = [[UILabel alloc]initWithFrame:CGRectMake(selectButton.right + 5, 10, 50, 40)];
    totle.text = @"总计:￥";
    totle.font = [UIFont boldSystemFontOfSize:15];
    totle.textColor = [UIColor whiteColor];
    [bottomBgView addSubview:totle];
    
//    价格
    priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(totle.right, 10, 80, 40)];
    priceLabel.text = @"0.00";
    priceLabel.textColor = [UIColor whiteColor];
    [bottomBgView addSubview:priceLabel];
    
//    结算按钮
    UIButton *payButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - 70 - 10, (60- 25)/2, 70, 25)];
    [payButton setImage:[UIImage imageNamed:@"my_logout_button1.png"] forState:UIControlStateNormal];
    [payButton addTarget:self action:@selector(payAction:) forControlEvents:UIControlEventTouchUpInside];
    [bottomBgView addSubview:payButton];
    
    payLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, 70, 15)];
    payLabel.textAlignment = NSTextAlignmentCenter;
    payLabel.font = [UIFont systemFontOfSize:13];
    payLabel.text = @"结算(99)";
    payLabel.textColor = [UIColor whiteColor];
    [payButton addSubview:payLabel];
    
    [self.view addSubview:bottomBgView];
}
-(void)_initBgTabelView{
//    if (WXHLOSVersion() >=7.0) {
//        bgTableView = [[TYTableView alloc]initWithFrame:CGRectMake(0,  0, ScreenWidth, ScreenHeight - 66 -49 - 60) isMore:NO refreshHeader:YES];
//    }else{
        bgTableView = [[TYTableView alloc]initWithFrame:CGRectMake(0,  0, ScreenWidth, ScreenHeight - 64 -49 - 60) isMore:NO refreshHeader:YES];
//    }
    bgTableView.delegate = self;
    bgTableView.dataSource = self;
    [self.view addSubview:bgTableView];
}
-(void)noneNetWork{
    if (!netLabel) {
        netLabel = [[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth - 200)/2, (ScreenHeight - 20)/2-100, 200,80)];
        netLabel.text = @"请检查你的手机网络设置\n下拉重新加载";
        netLabel.numberOfLines = 2;
        netLabel.textAlignment = NSTextAlignmentCenter;
        netLabel.textColor = [UIColor grayColor];
        netLabel.hidden = YES;
        [self.view addSubview:netLabel];
    }
    netLabel.hidden = NO;
    bottomBgView.hidden = YES;
    if (noneCarLabel) {
        noneCarLabel.hidden = YES;
    }
    timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(isContentNetWork) userInfo:nil repeats:YES];
}
//定时检查网络环境
-(void)isContentNetWork{
//    有网络
    if ([Network isConnectionAvailable]) {
//        隐藏 并停止定时器
        netLabel.hidden = YES;
        [timer invalidate];
        [self _initData];
    }
}
#pragma mark Action
//支付
-(void)payAction:(UIButton *)button{
    
}
//选中
-(void)selectedAction:(UIButton *)button{
    button.selected = !button.selected;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *buycarIdentifier = @"buycarcell";
    BuyCarCell *cell = [tableView dequeueReusableCellWithIdentifier:buycarIdentifier];
    if ( cell== nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"BuyCarCell" owner:self options:nil] lastObject];
    }
    cell.backgroundColor = [UIColor redColor];
    return cell;
}
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
#pragma mark TYTableViewDelegate

-(void)refreshDate:(UITableView *)tableView{//刷新
//    判断网络情况
//    有网络 =》加载数据
    if ([Network isConnectionAvailable]) {
        [self _initData];
    }
//    无网络 =》提示
    else{
        [self noneNetWork];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{//选中cell
    
}
@end
