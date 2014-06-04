//
//  CarViewController.m
//  duoduo
//
//  Created by tenyea on 14-4-23.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "CarViewController.h"
#import "FMDatabase.h"
#define car_title @"购物车还是空的"
#import "Network.h"
#import "FileUrl.h"
#import "BuyCarModel.h"
#import "Reachability.h"
#import "CourseViewController.h"
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
        //kReachabilityChangedNotification 网络状态改变时触发的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeNetwork:) name:kReachabilityChangedNotification object:nil];
        self.reachability = [Reachability reachabilityForInternetConnection];
        //开始监听网络
        [self.reachability startNotifier];
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
////    判断当前网络环境
//    if (![Network isConnectionAvailable]) {
//        [self noneNetWork];
//        
//        return ;
//    }
//    else{
//        if (netLabel) {
//            netLabel.hidden = YES;
//        }
//    }
////    初始化数据
//    [self _initData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self _initBgView];
    [self _initBgTabelView];
    
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [rightButton addTarget:self action:@selector(deleteCar) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setImage:[UIImage imageNamed:@"car_delete.png"] forState:UIControlStateNormal];
    UIBarButtonItem *item  = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = item;
    [self _initData];
}
//加载数据
-(void)_initData{
    [self refreshLocalData];
    if(dataArr.count > 0 ){
        noneCarLabel.hidden = YES;
    }else{
        if (!noneCarLabel) {
            noneCarLabel = [[UILabel alloc]initWithFrame:self.view.bounds];
            noneCarLabel.textColor = [UIColor grayColor];
            noneCarLabel.textAlignment = NSTextAlignmentCenter;
            noneCarLabel.text = car_title;
            noneCarLabel.hidden = YES;
            [self.view insertSubview:noneCarLabel atIndex:NSIntegerMax - 10];
        }
        noneCarLabel.hidden = NO;
    }

}
//获取本地shoppingcar表数据
-(void)refreshLocalData{
    FMDatabase *db = [FileUrl getDB];
    if (![db open]) {
        return ;
    }
    NSString *date = [NSString stringWithFormat:@"%@",[NSDate date]];
    NSString *url = @"http://192.168.1.145:8090/head/small/2014-05-10/50x50-14-39-48-97.jpg";
    [db executeUpdate:@"insert into shoppingCar values(1,?,'今天天气真好','nsla1203',300,1,?)",url,date];
    [db executeUpdate:@"insert into shoppingCar values(2,?,'明天天气不错','sla1203',320,0,?)",url,date];
    [db executeUpdate:@"insert into shoppingCar values(3,?,'后天天气暴雨','ala1203',550,1,?)",url,date];
    [db executeUpdate:@"insert into shoppingCar values(4,?,'大后天世界末日','ls0123',600,1,?)",url,date];
    [db executeUpdate:@"insert into shoppingCar values(5,?,'今天天气真好','nsla1203',300,1,?)",url,date];
    [db executeUpdate:@"insert into shoppingCar values(6,?,'明天天气不错','sla1203',320,0,?)",url,date];
    [db executeUpdate:@"insert into shoppingCar values(7,?,'后天天气暴雨','ala1203',550,1,?)",url,date];
    [db executeUpdate:@"insert into shoppingCar values(8,?,'大后天世界末日','ls0123',600,1,?)",url,date];
    [db executeUpdate:@"insert into shoppingCar values(9,?,'今天天气真好','nsla1203',300,1,?)",url,date];
    [db executeUpdate:@"insert into shoppingCar values(10,?,'明天天气不错','sla1203',320,0,?)",url,date];
    [db executeUpdate:@"insert into shoppingCar values(11,?,'后天天气暴雨','ala1203',550,1,?)",url,date];
    [db executeUpdate:@"insert into shoppingCar values(12,?,'大后天世界末日','ls0123',600,1,?)",url,date];
    [db executeUpdate:@"insert into shoppingCar values(13,?,'今天天气真好','nsla1203',300,1,?)",url,date];
    [db executeUpdate:@"insert into shoppingCar values(14,?,'明天天气不错','sla1203',320,0,?)",url,date];
    [db executeUpdate:@"insert into shoppingCar values(15,?,'后天天气暴雨','ala1203',550,1,?)",url,date];
    [db executeUpdate:@"insert into shoppingCar values(16,?,'大后天世界末日','ls0123',600,1,?)",url,date];
    FMResultSet *set = [db executeQuery:@"select * from shoppingCar"];
//    (id INTEGER PRIMARY KEY,title TEXT,courseID TEXT,price Integer,isselected Integer,addDate TEXT)
    NSMutableArray *array = [[NSMutableArray alloc]init];
    while (set.next) {
        BuyCarModel *model = [[BuyCarModel alloc]init];
        model.ID = [NSNumber numberWithInt:[set intForColumn:@"id"]];
        model.imageURL = [set stringForColumn:@"imageURL"];
        model.title = [set stringForColumn:@"title"];
        model.courseId = [set stringForColumn:@"courseId"];
        model.price =[NSNumber numberWithInt: [set intForColumn:@"price"]];
        model.isselected=[NSNumber numberWithInt: [set intForColumn:@"isselected"]];
        model.addDate = [NSString stringWithFormat:@"date"];
        [array addObject:model];
    }
    dataArr = nil;
    dataArr = [[NSArray alloc]initWithArray:array];
}
-(void)_initBgView{
    bottomBgView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight - 49 - 20 - 44-60, 320, 60)];
    bottomBgView.backgroundColor = [UIColor grayColor];
    bottomBgView.alpha = .8;
    
//    选中按钮
    UIButton *selectButton = [[UIButton alloc]initWithFrame:CGRectMake(5, 10, 40, 40)];
    [selectButton setImage:[UIImage imageNamed:@"car_deselect_bg.png"] forState:UIControlStateNormal];
    [selectButton setImage:[UIImage imageNamed:@"car_select_bg.png"] forState:UIControlStateSelected];
    [selectButton addTarget:self action:@selector(selectedAllAction:) forControlEvents:UIControlEventTouchUpInside];
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
    bgTableView = [[TYTableView alloc]initWithFrame:CGRectMake(0,  0, ScreenWidth, ScreenHeight - 64 -49 - 60) isMore:NO refreshHeader:YES];
    bgTableView.delegate = self;
    bgTableView.dataSource = self;
    [self.view addSubview:bgTableView];
//    [bgTableView setEditing:YES animated:NO];
//    [bgTableView setEditing:YES];
}

#pragma mark Action
//删除购物车
-(void)deleteCar{
    
}
//支付
-(void)payAction:(UIButton *)button{
    
}
//选中
-(void)selectedAllAction:(UIButton *)button{
    button.selected = !button.selected;
    for ( int i = 0 ; i < dataArr.count ; i ++ ) {
        BuyCarModel *model = dataArr[i];
        NSMutableArray *array = [NSMutableArray arrayWithArray:dataArr];
        [array removeObjectAtIndex:i];
        model.isselected = [NSNumber numberWithInt:button.selected ];
        [array insertObject:model atIndex:i];
        dataArr = nil;
        dataArr = array;
        array = nil;
        model = nil;
    }
    [bgTableView reloadData];
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
    int index = indexPath.row;
    cell.index = index;
    cell.model = [dataArr objectAtIndex:index];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 77;
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
//    BuyCarCell *cell = (BuyCarCell *)[tableView cellForRowAtIndexPath:indexPath];
//    cell.selectButton.selected = !cell.selectButton.selected;
//    cell.Selected = YES;
    BuyCarModel *model = [dataArr objectAtIndex:indexPath.row];
    CourseViewController *VC = [[CourseViewController alloc]initWithCourseID:model.courseId];
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark changeValueDelegate

-(void)valueChange:(BuyCarModel *)model index:(int)index totalPrices:(int)totalPrices count:(int)count{
//    刷新全局数据
    NSMutableArray *newArray = [[NSMutableArray alloc]initWithArray:dataArr];
    [newArray removeObjectAtIndex:index];
    [newArray insertObject:model atIndex:index];
    dataArr = newArray;
    newArray = nil;
//    刷新单个cell
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [bgTableView reloadRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationNone];
//    刷新个数和总价
    NSString *countStr = [[NSString alloc]init];
    if (count>99) {
        countStr = @"结算(99)";
    }else if(count == 0 ){
        countStr = @"结算";
    }else{
        countStr = [NSString stringWithFormat:@"结算(%d)",count];
    }
    payLabel.text = [NSString stringWithFormat:@"结算%@",countStr];
    priceLabel.text = [NSString stringWithFormat:@"%d",totalPrices];
}

#pragma mark network
//网络状态改变的时候调用
- (void)changeNetwork:(NSNotification *)notification {
    NetworkStatus status = self.reachability.currentReachabilityStatus;
    [self checkNetWork:status];
}
- (void)checkNetWork:(NetworkStatus)status {
    if (status == NotReachable) {
        NSLog(@"没有网络");
        [self noneNetWork];
        return;
    }
    else if(status == ReachableViaWWAN) {
        NSLog(@"3G/2G");
    }
    else if(status == ReachableViaWiFi) {
        NSLog(@"WIFI");
    }
    if (netLabel) {
        netLabel.hidden = YES;
    }
    [self _initData];
}
//无网络环境下页面
-(void)noneNetWork{
    if (!netLabel) {
        netLabel = [[UILabel alloc]initWithFrame:self.view.bounds];
        netLabel.text = @"请检查你的手机网络设置";
        netLabel.numberOfLines = 2;
        netLabel.textAlignment = NSTextAlignmentCenter;
        netLabel.textColor = [UIColor grayColor];
        netLabel.backgroundColor = [UIColor whiteColor];
        netLabel.hidden = YES;
        [self.view insertSubview:netLabel atIndex:NSIntegerMax];
    }
    netLabel.hidden = NO;
}
@end
