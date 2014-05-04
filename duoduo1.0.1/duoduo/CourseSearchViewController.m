//
//  CourseSearchViewController.m
//  duoduo
//
//  Created by tenyea on 14-4-19.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "CourseSearchViewController.h"
#import "TYButton.h"
#define params_userID @"userID"
#define params_date @"date"
#import "OneDayCell.h"

#define pushTime -60*60
#define pushTitle @"%@还有%d小时就要开始啦"
@interface CourseSearchViewController ()

@end

@implementation CourseSearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

-(void)viewWillDisappear:(BOOL)animated{
    
    UIImageView *image = (UIImageView *)VIEWWITHTAG([Calendar superview], 1300);
    image.hidden = YES;
    
    Calendar.viewImageView = nil;
    [Calendar removeFromSuperview];
    Calendar = nil;
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
//    获取userid
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults]objectForKey:kuserDIC];
    userID = [dic objectForKey:@"userMemberId"];
//    Calendar设置代理
    Calendar.calendarViewDelegate = self;
    
//    右侧按钮初始化
    TYButton *nextButton = [[TYButton alloc]initWithFrame: CGRectMake(40, 0, 40, 40)];
    nextButton.backgroundColor = CLEARCOLOR;
//    [nextButton setImage:[UIImage imageNamed:@"shake_exit1.png"] forState:UIControlStateNormal];
    [nextButton setTitle:@"上月" forState:UIControlStateNormal];
    nextButton.touchBlock = ^(TYButton *button ){
        [Calendar movePrevMonth];
    };
    UIBarButtonItem *nextItem = [[UIBarButtonItem alloc] initWithCustomView:nextButton];
    TYButton *prevButton = [[TYButton alloc]initWithFrame: CGRectMake(0, 0, 40, 40)];
    prevButton.backgroundColor = CLEARCOLOR;
//    [prevButton setImage:[UIImage imageNamed:@"shake_exit1.png"] forState:UIControlStateNormal];
    [prevButton setTitle:@"下月" forState:UIControlStateNormal];
    prevButton.touchBlock = ^(TYButton *button ){
        [Calendar  moveNextMonth];
    };
    UIBarButtonItem *prevItem = [[UIBarButtonItem alloc] initWithCustomView:prevButton];
    self.navigationItem.rightBarButtonItems = @[prevItem,nextItem];

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark CalendarViewDelegate

- (void) selectDateChanged:(CFGregorianDate) selectDate{
    
    NSString *key = [NSString stringWithFormat:@"%d",selectDate.day];

    //    存在数据
    oneDataArray = [allMonthDic objectForKey:key];
    [courseTbleView reloadData];

}
- (void) monthChanged:(CFGregorianDate) currentMonth viewLeftTop:(CGPoint)viewLeftTop height:(float)height{

}
- (void) beforeMonthChange:(TdCalendarView*) calendarView willto:(CFGregorianDate) currentMonth{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:userID forKey:params_userID];
    NSString *date;
    if (currentMonth.month >9) {
        date= [NSString stringWithFormat:@"%ld-%d",currentMonth.year,currentMonth.month];
    }else{
        date = [NSString stringWithFormat:@"%ld-0%d",currentMonth.year,currentMonth.month];
    }
    [params setValue:date forKey:params_date];
    if (!HUD) {
        [self showHudInBottom:nil];
    }
    [self getDate:URL_userClass andParams:params andcachePolicy:1 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        调用成功
        if ([[responseObject objectForKey:@"code"]intValue]==0 ) {
            [Calendar clearAllDayFlag];
            allMonthDic = [responseObject objectForKey:@"userclass"];
            NSArray *keys = [allMonthDic allKeys];
            for( int i = 0 ; i < keys.count ; i ++){
                [Calendar setDayFlag:[keys[i] intValue] flag:1];
            }
            [Calendar setNeedsDisplay];
        }
        [self removeHUD];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self removeHUD];
        _po([error localizedDescription]);

    }];

}
-(void)titleChanged:(NSString *)title{
//    防止标题飘逸
    [self performSelector:@selector(setTitle:) withObject:title afterDelay:.4];
}
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return oneDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"course";
    OneDayCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"OneDayCell" owner:self options:nil]lastObject];
    }
    NSDictionary *model = oneDataArray[indexPath.row];
//    标题
    UILabel *title = (UILabel *)VIEWWITHTAG(cell.contentView, 1000);
    title.text = [model objectForKey:@"className"];
//    开始时间
    UILabel *begin = (UILabel *)VIEWWITHTAG(cell.contentView, 2000);
    begin.text = [[model objectForKey:@"appBeginTime"] substringToIndex:5];
//    结束时间
    UILabel *end = (UILabel *)VIEWWITHTAG(cell.contentView, 3000);
    end.text = [[model objectForKey:@"appOverTime"] substringToIndex:5];
    cell.button.tag = indexPath.row;
    
    [cell.button addTarget:self action:@selector(noticAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.button setTitle:@"取消订阅" forState:UIControlStateSelected];
    [cell.button setTitle:@"订阅通知" forState:UIControlStateNormal];

//    判断订阅
    NSString *key = [NSString stringWithFormat:@"%@_%@_%@",[model objectForKey:@"classNo"],[model objectForKey:@"classTimeId"],[model objectForKey:@"appBeginTime"]];
    
    // 获得 UIApplication
    UIApplication *app = [UIApplication sharedApplication];
    //获取本地推送数组
    NSArray *localArray = [app scheduledLocalNotifications];
    //声明本地通知对象
    UILocalNotification *localNotification;
    if (localArray) {
        for (UILocalNotification *noti in localArray) {
            NSDictionary *dict = noti.userInfo;
            if (dict) {
                NSString *inKey = [dict objectForKey:@"key"];
                if ([inKey isEqualToString:key]) {
                    if (localNotification){
                        localNotification = nil;
                    }
                    localNotification = noti;
                    break;
                }
            }
        }
        //判断是否找到已经存在的相同key的推送
        if (localNotification) {
            cell.button.selected = YES;
        }
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
#pragma mark Action 
-(void)noticAction:(UIButton *)button{
    NSDictionary *model = oneDataArray[button.tag];
    NSString *key = [NSString stringWithFormat:@"%@_%@_%@",[model objectForKey:@"classNo"],[model objectForKey:@"classTimeId"],[model objectForKey:@"appBeginTime"]];
    if (button.selected) {
        [self unbindLocalNotification:key];
    }else{
        NSString *pushDate = [NSString stringWithFormat:@"%@ %@",[model objectForKey:@"date"],[model objectForKey:@"appBeginTime"]];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [formatter dateFromString:pushDate];
        [self pushLocalNotification:[date dateByAddingTimeInterval:pushTime] key:key title:[model objectForKey:@"className"]];
    }
    button.selected = !button.selected;
}
#pragma mark UITableViewDelegate

#pragma mark 本地推送
-(void)pushLocalNotification:(NSDate *)data key:(NSString *)key title:(NSString *)title{
    // 创建一个本地推送
    UILocalNotification *notification = [[UILocalNotification alloc] init] ;
    if (notification != nil) {
        // 设置推送时间
        notification.fireDate = data;
        // 设置时区
        notification.timeZone = [NSTimeZone localTimeZone];
        // 设置重复间隔
        notification.repeatInterval = 0;// 0 means don't repeat
        // 推送声音
        notification.soundName = UILocalNotificationDefaultSoundName;
        // 推送内容
        notification.alertBody = [NSString stringWithFormat:pushTitle,title,-pushTime/60*60];
        
        //显示在icon上的红色圈中的数子
        notification.applicationIconBadgeNumber += 1;
        //设置userinfo 方便在之后需要撤销的时候使用
        NSDictionary *info = [NSDictionary dictionaryWithObject:key forKey:@"key"];
        notification.userInfo = info;
        //添加推送到UIApplication
        UIApplication *app = [UIApplication sharedApplication];
        [app scheduleLocalNotification:notification]; 
        
    }
}
//解除本地推送
-(void)unbindLocalNotification :(NSString *)key {
    // 获得 UIApplication
    UIApplication *app = [UIApplication sharedApplication];
    //获取本地推送数组
    NSArray *localArray = [app scheduledLocalNotifications];
    //声明本地通知对象
    UILocalNotification *localNotification;
    if (localArray) {
        for (UILocalNotification *noti in localArray) {
            NSDictionary *dict = noti.userInfo;
            if (dict) {
                NSString *inKey = [dict objectForKey:@"key"];
                if ([inKey isEqualToString:key]) {
                    if (localNotification){
                        localNotification = nil;
                    }
                    localNotification = noti;
                    break;
                }
            }
        }
        //判断是否找到已经存在的相同key的推送
        if (!localNotification) {
            //不存在初始化
            localNotification = [[UILocalNotification alloc] init];
        }
        if (localNotification) {
            //不推送 取消推送
            [app cancelLocalNotification:localNotification];
            return;
        }
    }
}

@end
