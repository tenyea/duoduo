//
//  HomeTableView.m
//  duoduo
//
//  Created by tenyea on 14-4-12.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "HomeTableView.h"
#import "ShakeViewController.h"
#import "UIView+Additions.h"
#define XLCycleHeight 120
#define topViewHeight 85
#define allcoursesHeight 135
#define coursesHeight 185 //自定义 热门 优选
#define nearBabyHeight 140
#define shopsHeight 170
#define goodsHeight 105
#define columnHeight 295 //课程
#import "TYtouchView.h"
#import "TYImageView.h"
#import "CountDownView.h"
#import "NearBabyViewController.h"
#import "AllCoursesTabelViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "CoursesView.h"

#pragma mark title
#define home_table_allcourses @"时时课程"
#define home_table_nearBaby @"身边宝宝"
#define home_table_hotcourses @"热门课程"
#define home_table_bestcourses @"优选课程"
#define home_table_shops @"合作商家"
#define home_table_goods @"优选特供"
#define home_table_courses @"课程"
@implementation HomeTableView

-(id)initWithFrame:(CGRect)frame isMore:(BOOL)isMore refreshHeader:(BOOL)refreshHeader{
    if ([super initWithFrame:frame isMore:isMore refreshHeader:refreshHeader]) {
    }
    return self;
}
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary *custom  = [_dataDic objectForKey:@"custom"];
    int count = [[custom objectForKey:@"count"] intValue];
    
//    return  cellCount=(_dataDic.count +3 + count);//关注+身边宝宝+课程
    return cellCount = 9;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell ;
    int row = indexPath.row;
    if (row ==0) {//轮播图
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        [cell.contentView addSubview:[self _initxlcs]];
    }else if(row ==1){//    我的关注 摇一摇 健康体检 快乐学堂
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        [cell.contentView addSubview:[self _topView]];
    }else if(row ==2){//时时课程
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        [cell.contentView addSubview:[self _allcourses]];
    }else if(row ==3){//热门课程
        NSArray *arr =[[NSBundle mainBundle] loadNibNamed:@"coursesLeftCell" owner:self options:nil] ;
        cell = [arr lastObject];
        [cell.contentView addSubview: [self titleView:home_table_hotcourses]];
    }else if(cellCount ==row +5){//身边宝宝
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        [cell.contentView addSubview:[self _NearBaby]];
    }else if(cellCount ==row +4){//优选课程
        NSArray *arr =[[NSBundle mainBundle] loadNibNamed:@"CoursesRightCell" owner:self options:nil] ;
        cell = [arr lastObject];
        [cell.contentView addSubview: [self titleView:home_table_bestcourses]];
    }else if(cellCount ==row +3){//合作商家
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        [cell.contentView addSubview:[self _Shops]];
    }else if(cellCount ==row +2){//优选特供
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        [cell.contentView addSubview:[self _Goods]];
    }else if(cellCount ==row +1 ){//课程
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        [cell.contentView addSubview:[self _Courses]];
    }else{
        if (cellCount ==9) {
            
        }else{//自定义
            
        }
    }
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    int row = indexPath.row;
    if (row ==0) {//轮播图
        return XLCycleHeight;
    }else if(row ==1){//    我的关注 摇一摇 健康体检 快乐学堂
        return topViewHeight;
    }else if(row ==2){//时时课程
        return allcoursesHeight;
    }else if(row ==3){//热门课程
    }else if(cellCount ==row +5){//身边宝宝
        return nearBabyHeight;
    }else if(cellCount ==row +4){//优选课程
    }else if(cellCount ==row +3){//合作商家
        return shopsHeight;
    }else if(cellCount ==row +2){//优选特供
        return goodsHeight;
    }else if(cellCount ==row +1 ){//课程
        return columnHeight;
    }else{
        if (cellCount ==9) {
            
        }else{//自定义
            
        }
    }
    
    return coursesHeight;
}
#pragma mark UITableViewDelegate

#pragma  mark XLCycleScrollViewDatasource
- (NSInteger)numberOfPages
{
    return 4;
}

- (UIView *)pageAtIndex:(NSInteger)index
{
    UIImageView *imgaeView =[[UIImageView alloc]init];
    imgaeView.image = [UIImage imageNamed:@"home_02.png"];
    imgaeView.frame = CGRectMake(0,0, 320, 120);
    return imgaeView;
    
}

#pragma mark XLCycleScrollViewDelegate
- (void)didClickPage:(XLCycleScrollView *)csView atIndex:(NSInteger)index
{
    //    [self.changeDelegate ImageViewDidSelected:index andData:_imageData];
}
-(void)PageExchange:(NSInteger)index{
    pageControl.currentPage = index;
}

#pragma method 
//轮播图
-(UIView *)_initxlcs{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, XLCycleHeight)];
    //  轮播图
    XLCycleScrollView *xlCycleScrollView = [[XLCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, XLCycleHeight)];
    xlCycleScrollView.delegate = self;
    xlCycleScrollView.datasource = self;
    [xlCycleScrollView.pageControl setHidden:YES];

    [view addSubview:xlCycleScrollView];
    //pagecontrol
    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(320 - 12*4-5, 100, 12*4, 15)];
    pageControl.backgroundColor = [UIColor clearColor];
    if (WXHLOSVersion()>=6.0) {
        pageControl.pageIndicatorTintColor = [UIColor grayColor];
        pageControl.currentPageIndicatorTintColor = COLOR(245, 0, 152);
    }
    
    pageControl.userInteractionEnabled = NO;
    pageControl.numberOfPages =4  ;
    pageControl.currentPage= 0;
    [xlCycleScrollView addSubview:pageControl];
    
    return view;
}
//我的关注 摇一摇 健康体检 快乐学堂
-(UIView *)_topView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, topViewHeight)];
    view.backgroundColor = CLEARCOLOR;
    
    NSArray *imageArray = @[@"home_top_focus.png",@"home_top_shake.png",@"home_top_medical.png",@"home_top_ school.png"];
    for (int i = 0 ; i<imageArray.count ; i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(10+75*i, 10, 70, 60)];
        [button setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        button.tag = 10 +i;
        [button addTarget:self action:@selector(topAction:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
    }
    return view;
}
//时时课程
-(UIView *)_allcourses{ //82x62
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, allcoursesHeight)];

    UIView *titleView = [self titleView:home_table_allcourses];
    [view addSubview:titleView];
    for (int i = 0 ; i < 3;  i ++) {
        TYtouchView *bgView = [[TYtouchView alloc] initWithFrame:CGRectMake(10 +105 *i , 25, 90, 115)];
        [view addSubview:bgView];
//        图片
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((90-82)/2, 4, 82, 62)];
        [imageView setImage:[UIImage imageNamed:@"home_18.png"]];
        //圆角
//        imageView.layer.cornerRadius = 10;
//        imageView.layer.masksToBounds = YES;
        [bgView addSubview:imageView];
//        标题
        UILabel *label  = [[UILabel alloc]initWithFrame:CGRectMake(4, 4+4+62, 82, 10)] ;
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"wow文字";
        label.textColor = home_cell_tile_textcolor;
        label.font = [UIFont boldSystemFontOfSize:12];
        [bgView addSubview:label];
//        倒计时
        CountDownView *countDownView = [[CountDownView alloc]initWithFrame:CGRectMake(4, 82, 82, 30) withEndDate:@"2014-04-14 15:52:58"];
        [bgView addSubview:countDownView];
        bgView.touchBlock = ^(void){
            AllCoursesTabelViewController *VC = [[AllCoursesTabelViewController alloc]init];
            [self.viewController.navigationController pushViewController:VC animated:YES];
        };
        
        
    }
    return view;
}
//身边宝宝
-(UIView *)_NearBaby{//300x110
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, nearBabyHeight)];

    UIView *titleView = [self titleView:home_table_nearBaby];
    [view addSubview:titleView];
    
    TYImageView *bgview = [[TYImageView alloc]initWithFrame:CGRectMake(10, 25, 300, 110)];
    [bgview setImage:[UIImage imageNamed:@"home_nearBaby.png"]];
    bgview.touchBlock = ^(void){
        NearBabyViewController *VC = [[NearBabyViewController alloc]init];
        [self.viewController.navigationController pushViewController:VC animated:YES];
    };
    [view addSubview:bgview];
    return view;
}
//合作商家
-(UIView *)_Shops{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, shopsHeight)];
    UIView *titleView = [self titleView:home_table_shops];
    [view addSubview:titleView];
    TYImageView *bgview = [[TYImageView alloc]initWithFrame:CGRectMake(10, 25, 300, 130)];
    [bgview setImage:[UIImage imageNamed:@"home_42.png"]];
    bgview.touchBlock = ^(void){
        NearBabyViewController *VC = [[NearBabyViewController alloc]init];
        [self.viewController.navigationController pushViewController:VC animated:YES];
    };
    [view addSubview:bgview];
    return view;
}
//优选特供
-(UIView *)_Goods{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, goodsHeight)];
    UIView *titleView = [self titleView:home_table_goods];
    [view addSubview:titleView];
//    滚动条
    UIScrollView *scBgView = [[UIScrollView alloc]init];
    scBgView.frame = CGRectMake(0, 25, 320, 80);
    scBgView.contentSize = CGSizeMake(70*10+10, 80);
    scBgView.showsHorizontalScrollIndicator = NO;
    scBgView.showsVerticalScrollIndicator = NO;
    
    for (int i = 0; i < 10;  i ++) {
        UIButton *button = [[UIButton alloc]init];
        button.frame = CGRectMake(10+ 70 * i , 20, 60, 48);
        button.tag = 100 + i;
        //        圆角
        button.layer.cornerRadius = 10;
        button.layer.masksToBounds = YES;
        [button setImage:[UIImage imageNamed:@"home_46.png"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(goodsAction:) forControlEvents:UIControlEventTouchUpInside];
        [scBgView addSubview:button];
    }
    [view addSubview:scBgView];
    return view;
}
//课程
-(UIView *)_Courses{//160*50
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, columnHeight)];
    UIView *titleView = [self titleView:home_table_courses];
    [view addSubview:titleView];
//  颜色数组
    NSArray *array = @[home_cell_tile_textcolor,COLOR(65, 196, 109),COLOR(102, 151, 213),COLOR(240, 66, 73)];
    int y = 25 ;
    for (int i = 0 ; i < 8 ; i ++) {
        
           
        CoursesView *bgview = [[[NSBundle mainBundle]loadNibNamed:@"CoursesView" owner:self options:nil] lastObject];
        bgview.frame =CGRectMake((i%2) * 160, y, 160, 50);
        bgview.titleLabel.textColor = array[i/2];
        if (i % 2) {
            y +=50;
        }
        [view addSubview:bgview];
    }
    return view;
}


-(UIView *)titleView :(NSString *)title{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 25)];
    //    分割线
    UIImageView *imageView1 = [[UIImageView alloc]init];
    imageView1.image = [UIImage imageNamed:@"home_split_line.png"];
    imageView1.frame = CGRectMake(0, 1, 320, 1);
    [bgView addSubview:imageView1];
//    标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 3, 100, 18)];
    titleLabel.text = title;
    titleLabel.textColor = home_title_textcolor;
    titleLabel.font = [UIFont systemFontOfSize:17];
    [bgView addSubview:titleLabel];
//    分割线
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"home_split_line.png"];
    imageView.frame = CGRectMake(0, 23, 320, 1);
    [bgView addSubview:imageView];
    return bgView;
}
#pragma mark Action
-(void)goodsAction:(UIButton *)button {
    _pn(button.tag-100);
}
-(void)topAction:(UIButton *)button{
    ShakeViewController *shake = [[ShakeViewController alloc]initWithNibName:@"ShakeViewController" bundle:nil];
    switch (button.tag) {
        case 10:
            break;
        case 11:
            [self.viewController.navigationController pushViewController:shake animated:YES];
            break;
        case 12:
            break;
        case 13:
            break;
        default:
            break;
    }
}
@end
