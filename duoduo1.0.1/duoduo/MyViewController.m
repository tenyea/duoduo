//
//  MyViewController.m
//  duoduo
//
//  Created by tenyea on 14-4-18.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "MyViewController.h"
#import "TYButton.h"
#import "CourseSearchViewController.h"
#import "MyCourseViewController.h"
#import "MyMessageViewController.h"
#import "ShareCourseViewController.h"
#import "ManageViewController.h"
#import "FMDatabase.h"
#import "FileUrl.h"
#import "UIImageView+WebCache.h"
#import "CollectionViewController.h"
#import "SelectedViewController.h"
#import "SignInViewController.h"
#import "VoucherCenterViewController.h"
#import "LoginViewController.h"
#define tablecellHeigh 35
@interface MyViewController (){
    LoginViewController *loginVC;
}

@end

@implementation MyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"我的朵朵";

    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    dataDics = [[NSUserDefaults standardUserDefaults]objectForKey:kuserDIC];
    if (dataDics.count>0) {
        [self reloadData];
    }else{
        [self presentLoginVC];
    }
}
-(void)presentLoginVC{
    if (!loginVC) {
        loginVC = [[LoginViewController alloc]init];
//        loginVC
    }
//    [self.view presentViewController:loginVC animated:YES completion:nil];
    [self.view  addSubview: loginVC.view];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIScrollView *bgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, -1, ScreenWidth, ScreenHeight - 20-44-49+1)];
    bgScrollView.showsHorizontalScrollIndicator = NO;
    bgScrollView.showsVerticalScrollIndicator = NO;
//    bgScrollView.backgroundColor = [UIColor redColor];
    bgScrollView.contentSize = CGSizeMake(ScreenWidth, 500);
    [self.view  addSubview:bgScrollView];
//头部视图
    [bgScrollView addSubview:self.topView];
    UIImage *image = [UIImage imageNamed:@"my_table_bg.png"];
//    课程查询
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(20, _topView.height + 15, 280, tablecellHeigh+2)];
    imageView1.image = [image stretchableImageWithLeftCapWidth:4 topCapHeight:4];
    [bgScrollView addSubview:imageView1];
    UITableView *table1 = [[UITableView alloc]initWithFrame:CGRectMake(28, _topView.height + 15+1, 280-4*8, tablecellHeigh-1) style:UITableViewStylePlain];
    table1.tag = 15;
    table1.delegate = self;
    table1.dataSource = self;
    table1.showsHorizontalScrollIndicator = NO;
    table1.showsVerticalScrollIndicator = NO;
    table1.bounces = NO;
    [bgScrollView addSubview:table1];
//    我的信息
    UIImageView *imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(20, imageView1.bottom + 15, 280, tablecellHeigh*4+2)];
    imageView2.image = [image stretchableImageWithLeftCapWidth:4 topCapHeight:4];
    [bgScrollView addSubview:imageView2];
    UITableView *table2 = [[UITableView alloc]initWithFrame:CGRectMake(28, imageView1.bottom + 15+1, 280-4*8, tablecellHeigh*4-1) style:UITableViewStylePlain];
    table2.tag = 20;
    table2.dataSource = self;
    table2.delegate = self;
    table2.showsVerticalScrollIndicator = NO;
    table2.showsHorizontalScrollIndicator = NO;
    table2.bounces = NO;
    [bgScrollView addSubview:table2];
    
   
//    推荐课程
    self.recommendView.frame = CGRectMake(20, imageView2.bottom + 15, 280, 110);
    [bgScrollView addSubview:self.recommendView];
    
//    
    UIImageView *imageView3= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 280, 110)];
    imageView3.image = [image stretchableImageWithLeftCapWidth:4 topCapHeight:4];
    [_recommendView insertSubview:imageView3 atIndex:0];
    
//    退出登录
    TYButton *button = [[TYButton alloc]initWithFrame:CGRectMake(20, _recommendView.bottom +15 , 280, 40)];
    button.touchBlock = ^(TYButton *button){
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:kuserDIC];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self presentLoginVC];
    };
    [button setImage:[UIImage imageNamed:@"my_logout_button.png"] forState:UIControlStateNormal];
    [bgScrollView addSubview:button];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((280-100)/2, (40-20)/2, 100, 20)];
    label.text = button_logout;
    label.font = [UIFont boldSystemFontOfSize:13];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [button addSubview:label];
//    内容数据
    section1Arr = @[@"课程查询"];
    section2Arr = @[@"我的课程",@"我的消息",@"分享课程",@"账户管理"];

    image1Arr = @[@"my_course_search.png"];
    image2Arr =@[@"my_course.png",@"my_message.png",@"my_share_course.png",@"my_ account_ manage.png"];

//navigationButton
    TYButton *naviButton = [[TYButton alloc]initWithFrame:CGRectMake(0, 0, 40, 20)];
    naviButton.touchBlock = ^(TYButton *button ){
        
    };
    [naviButton setImage:[UIImage imageNamed:@"my_setting_button.png"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:naviButton];
    

    roolView.eventDelegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return tablecellHeigh;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (tableView.tag) {
        case 15:
            [self.navigationController pushViewController:[[CourseSearchViewController alloc] init] animated:YES];
            
            break;
        case 20:
        {
            switch (indexPath.row) {
                case 0:
                    [self.navigationController pushViewController:[[MyCourseViewController alloc] init] animated:YES];
                    break;
                case 1:
                    [self.navigationController pushViewController:[[MyMessageViewController alloc] init] animated:YES];
                    break;
                case 2:
                    [self.navigationController pushViewController:[[ShareCourseViewController alloc] init] animated:YES];
                    break;
                case 3:
                    [self.navigationController pushViewController:[[ManageViewController alloc] init] animated:YES];
                    break;
                default:
                    break;
            }
        }
            
            break;
        default:
            break;
    }
}
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (tableView.tag) {
        case 15:
            return section1Arr.count;
            break;
        case 20:
            return section2Arr.count;
            break;
        default:
            break;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *myIdentifier = @"myIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
        UIImageView *imageView =  [[UIImageView alloc]init];
        imageView.frame = CGRectMake(10 , (tablecellHeigh-15)/2, 15,15);
        imageView.tag = 100;
        [cell.contentView addSubview:imageView];
        UILabel *label =  [[UILabel alloc]init];
        label.frame = CGRectMake(imageView.right + 15, imageView.top, 80, 15);
        label.tag = 150;
        label.textColor = [UIColor colorWithRed:0.34 green:0.34 blue:0.34 alpha:1];
        label.font = [UIFont systemFontOfSize:14];
        [cell.contentView addSubview:label];
        if (indexPath.row == 1) {//我的消息
            UILabel *left = [[UILabel alloc]initWithFrame:CGRectMake(label.right+2, label.top, 3, label.height)];
            left.tag = 300;
            left.textColor = [UIColor blackColor];
            left.font = label.font;
            [cell.contentView addSubview:left];
            
            UILabel *center = [[UILabel alloc]initWithFrame:CGRectMake(left.right+2, label.top, 8, label.height)];
            center.tag = 310;
            center.textColor = [UIColor redColor];
            center.font = label.font;
            [cell.contentView addSubview:center];
            
            UILabel *right = [[UILabel alloc]initWithFrame:CGRectMake(center.right+2, label.top, 3, label.height)];
            right.tag = 320;
            right.textColor = [UIColor blackColor];
            right.font = label.font;
            [cell.contentView addSubview:right];
        }
    }
    

    UIImageView *imageView = (UIImageView *)VIEWWITHTAG(cell.contentView, 100);
    UILabel *label = (UILabel *)VIEWWITHTAG(cell.contentView, 150);
    int index = indexPath.row;
    switch (tableView.tag) {
        case 15:
            imageView.image = [UIImage imageNamed:image1Arr[index]];
            label.text = section1Arr[index];
            break;
        case 20:
            imageView.image = [UIImage imageNamed:image2Arr[index]];
            label.text = section2Arr[index];
            break;
        default:
            break;
    }
    
    if (indexPath.row==1) {
        //初始化数据库
        FMDatabase *db = [FileUrl getDB];
        if (![db open]) {
            NSLog(@"Could not open db.");
            
        }else {
            [label sizeToFit];
            UILabel *left = (UILabel *)VIEWWITHTAG(cell.contentView, 300);
            UILabel *right = (UILabel *)VIEWWITHTAG(cell.contentView, 320);
            UILabel *center = (UILabel *)VIEWWITHTAG(cell.contentView, 310);
            //            查询数据库
            FMResultSet *set = [db executeQuery:@"select count(1) n from pushNotificationHistory where isread = 0" ];
            int count = [set intForColumn:@"n"] ;
            if (count == 0 ) {
                left.hidden = YES;
                center.hidden = YES;
                right.hidden = YES;
            }else{
                left.left = label.right + 3;
                left.text = @"(";
                right.text = @")";
                center.textColor  =[UIColor redColor];
                center.text = [NSString stringWithFormat:@"%d",count];
                [center sizeToFit];
                center.left = left.right + 2;
                right.left = center.right + 2;

            }
            
            
        }
        
        
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark scrolldelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int pageindex = scrollView.contentOffset.x / 320 ;
    UIPageControl *pageControl = (UIPageControl *) [self.view viewWithTag:100];
    pageControl.currentPage = pageindex;
}
#pragma mark rollviewdelegate
-(void)PageExchange:(NSInteger)index{
    
}

#pragma mark Action
- (IBAction)headAction:(UIButton *)sender {
    switch (sender.tag) {
        case 1500:
            
            break;
        case 1600:
            [self.navigationController pushViewController:[[SelectedViewController alloc]init] animated:YES];
            break;
        case 1700:
            [self.navigationController pushViewController:[[CollectionViewController alloc]init] animated:YES];
            break;
        case 1800:
            [self.navigationController pushViewController:[[VoucherCenterViewController alloc]init] animated:YES];
            break;
        case 1900:
            [self.navigationController pushViewController:[[SignInViewController alloc]init] animated:YES];
            break;
        default:
            break;
    }
}
//刷新数据
-(void)reloadData{
    [headButton.imageView setImageWithURL:[NSURL URLWithString:[dataDics objectForKey:kuserDIC_head]] placeholderImage:[UIImage imageNamed:@"my_head_button.png"]];
    userNameLabel.text = [dataDics objectForKey:kuserDIC_userName];
    NSString *memberType ;
    switch ([[dataDics objectForKey:kuserDIC_memberTypeId] intValue]) {
        case 0:
            memberType = @"普通会员";
            break;
        case 1:
            memberType = @"银牌会员";
            break;
        case 2:
            memberType = @"金牌会员";
            break;
        case 3:
            memberType = @"砖石会员";
            break;
        default:
            break;
    }
    memberTypeLabel.text = memberType;
    scoresLabel.text = [NSString stringWithFormat:@"%d",[[dataDics objectForKey:kuserDIC_scores] intValue]];
    selectedCourseTotalLabel.text = [NSString stringWithFormat:@"%d",[[dataDics objectForKey:kuserDIC_selectCourseTotal] intValue]];
    collectCourseTotalLabel.text = [NSString stringWithFormat:@"%d",[[dataDics objectForKey:kuserDIC_collectCourseTotal] intValue]];
    coinLabel.text = [NSString stringWithFormat:@"%d",[[dataDics objectForKey:kuserDIC_coin] intValue]];
    signTotalLabel.text = [NSString stringWithFormat:@"%d",[[dataDics objectForKey:kuserDIC_signTotal] intValue]];
}
@end
