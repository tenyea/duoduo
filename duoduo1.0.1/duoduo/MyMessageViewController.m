//
//  MyMessageViewController.m
//  duoduo
//
//  Created by tenyea on 14-4-22.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "MyMessageViewController.h"
#import "MyMessageCell.h"
#import "FMDatabase.h"
#import "FileUrl.h"
#define ktitle @"title"
#define kcontent @"content"
#define kisread @"isread"
#define kpushTime @"pushTime"
#define kpushId @"kpushId"
#define kcategory @"kcategory"
#define ktemplate @"ktemplate"
#define kcourseId @"kcourseId"
#define String_myMessage_none @"暂时无消息"

#import "CourseViewController.h"
#import "MessageTopicsViewController.h"
@interface MyMessageViewController ()

@end

@implementation MyMessageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"我的消息";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    bgtableView.separatorStyle = UITableViewCellSeparatorStyleNone;//去除分割线
    [self _initData];
    [bgtableView reloadData];
    if (dataArr.count ==0) {
        bgtableView.hidden = YES;
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(0, 0, 200, 50);
        label.center = self.view.center;
        label.textAlignment = NSTextAlignmentCenter;
        label.text = String_myMessage_none;
        [self.view addSubview: label];
    }

}
-(void)_initData{
    //初始化数据库
    FMDatabase *db = [FileUrl getDB];
    if (![db open]) {
        NSLog(@"Could not open db.");
        return ;
    }
    NSDate *nowDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:nowDate];
    NSUInteger numberOfDaysInMonth = range.length;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-01 00:00:00"];
    
    NSString *beginTime = [formatter stringFromDate:nowDate];
    [formatter setDateFormat:[NSString stringWithFormat:@"yyyy-MM-%2d 23:59:59",numberOfDaysInMonth]];
    NSString *endTime = [formatter stringFromDate:nowDate];

    NSString *sql = [NSString stringWithFormat:@"select * from pushNotificationHistory where pushTime between '%@' and '%@'" ,beginTime ,endTime ];
    FMResultSet *rs = [db executeQuery:sql];
    NSMutableArray *pushHistory = [[NSMutableArray alloc]init];
    while (rs.next) {
        NSString *pushId = [rs stringForColumn:@"id"];

        NSString *title = [rs stringForColumn:@"title"];
        NSString *content = [rs stringForColumn:@"content"];
        NSString *pushTime = [[rs stringForColumn:@"pushTime"] substringToIndex:10];
        NSString *isread = [NSString stringWithFormat:@"%d",[rs intForColumn:@"isread"]];//是否阅读(0:未读 1:已读)
        int category = [rs intForColumn:@"category"];//0 普通 1专题
        int template = [rs intForColumn:@"template"];//选择模板 默认为0
        NSString *courseId = [rs stringForColumn:@"courseId"];//专题或普通课程编号
        NSDictionary *dic = [NSDictionary dictionaryWithObjects:@[pushId,title,content,pushTime,isread,[NSNumber numberWithInt:category],[NSNumber numberWithInt:template],courseId] forKeys:@[kpushId,ktitle,kcontent,kpushTime,kisread,kcategory,ktemplate,kcourseId]];
        [pushHistory addObject:dic];
    }

    [db close];
    dataArr = [NSArray arrayWithArray:pushHistory];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [dataArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *strIdentifier = @"myMessage";
    MyMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:strIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MyMessageCell" owner:self options:nil] lastObject];
    }
    NSDictionary *model = dataArr[indexPath.row];
    cell.pushTime.text = [model objectForKey:kpushTime];
    cell.title.text = [model objectForKey: ktitle];
    cell.content.text = [model objectForKey:kcontent];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    是否已读   是否阅读(0:未读 1:已读)
    if ([[model objectForKey:kisread] intValue]) {
        cell.title.textColor = COLOR(107, 107, 107);
        cell.content.textColor = COLOR(150, 150, 150);
    }else{
        cell.title.textColor = [UIColor redColor];
        cell.content.textColor = [UIColor redColor];
    }
    return cell;
}
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *model = dataArr[indexPath.row];
    NSString *pushId = [model objectForKey:kpushId];
    FMDatabase *db = [FileUrl getDB];
    if (![db open]) {
        NSLog(@"Could not open db.");
        return ;
    }
    [db executeUpdate:@"update pushNotificationHistory set isread = 1 where id  = ?",pushId];
    [db close];
    dataArr = nil;
    [self _initData];
    [tableView reloadData];
    if ([model objectForKey:kcategory]) {//0普通 1专题
        MessageTopicsViewController *VC = [[MessageTopicsViewController alloc]initWithTopicsId:[model objectForKey:kcourseId] template:[[model objectForKey:ktemplate] intValue]];
        [self.navigationController pushViewController:VC animated:YES];
        
    }else{
        CourseViewController *VC = [[CourseViewController alloc]initWithCourseID:[model objectForKey:kcourseId]];
        [self.navigationController pushViewController:VC animated:YES];
    }
}

@end
