//
//  CategoryViewController.m
//  duoduo
//
//  Created by tenyea on 14-3-25.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "CategoryViewController.h"
#import "CategoryMainCell.h"
#import "OpenUDID.h"
#import "CourseModel.h"
#define Category_Height  ScreenHeight-49-20

#define params_categoryID @"course_type_id"
#define params_deviceID @"DeviceID"
@interface CategoryViewController (){
    BOOL isSecondShow;
}

@end

@implementation CategoryViewController

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
    colorArray = @[[UIColor colorWithRed:0.96 green:0.47 blue:0.15 alpha:1],[UIColor colorWithRed:0.85 green:0.32 blue:0.17 alpha:1],[UIColor colorWithRed:0.25 green:0.76 blue:0.42 alpha:1],[UIColor colorWithRed:0.22 green:0.78 blue:0.03 alpha:1],[UIColor colorWithRed:0.25 green:0.47 blue:0.78 alpha:1],[UIColor colorWithRed:0.29 green:0.52 blue:1 alpha:1],[UIColor colorWithRed:0.94 green:0.09 blue:0.2 alpha:1],[UIColor colorWithRed:0.96 green:0.46 blue:0.18 alpha:1]];
    mainTableView = [[UITableView alloc]init];
    mainTableView.frame = CGRectMake(0, 0, ScreenWidth+220, Category_Height);
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
//    填充数据
    mainArray = [[NSUserDefaults standardUserDefaults] objectForKey:kcategoryArray];
    [self.view addSubview:mainTableView];

    [self _initLeftView];
    [self _initRightView];
    [self _initNavigation];
}
//    左侧视图
-(void)_initLeftView{
    leftView = [[UIView alloc]init];
    leftView.frame = CGRectMake(0, 0, ScreenWidth-100, Category_Height);
    leftView.transform = CGAffineTransformTranslate(leftView.transform, -320+100, 0);
    leftView.backgroundColor = [UIColor whiteColor];
    //    添加手势
    [self.view addSubview:leftView];
    
    UISwipeGestureRecognizer *swipeLeftGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(dragTableView:)];
    swipeLeftGesture.direction=UISwipeGestureRecognizerDirectionLeft;//不设置黑夜是右
    [leftView addGestureRecognizer:swipeLeftGesture];
}
//    右侧视图
-(void)_initRightView{
    rightView = [[UIView alloc]init];
    rightView.frame = CGRectMake(ScreenWidth - 100, 0, 100, Category_Height);
    rightView.userInteractionEnabled = NO;
    rightView.backgroundColor = [UIColor clearColor];
    rightView.hidden = YES;
    [self.view addSubview:rightView];
    //    分割线
    UIImageView *lineImageView = [[UIImageView alloc]init];
    lineImageView.frame = CGRectMake(0 , 0, 10, Category_Height);
    lineImageView.image = [UIImage imageNamed:@"category_line.png"];
    [rightView addSubview:lineImageView];
    
    
    //    箭头
    arrowsImageView = [[UIView alloc]init];
    arrowsImageView.frame = CGRectMake(0 , 0 , 100 , 55);
    arrowsImageView.backgroundColor = COLOR(244, 141, 32);
    [rightView addSubview:arrowsImageView];
    UIImageView *arrows = [[UIImageView alloc]init];
    arrows.frame = CGRectMake(0, arrowsImageView.height/2-5, 10, 10);
    arrows.image = [UIImage imageNamed:@"category_arrows.png"];
    [arrowsImageView addSubview:arrows];
    
    UILabel *title = [[UILabel alloc]init];
    title.frame = CGRectMake(10, 5, 80, 45);
    title.font = [UIFont boldSystemFontOfSize:18];
    title.textAlignment = NSTextAlignmentCenter;
    title.tag = 100;
    title.textColor = [UIColor whiteColor];
    [arrowsImageView addSubview:title];
}
-(void)_initNavigation {
    //    添加右侧按钮
    searchButton = [[UIButton alloc]init];
    searchButton.backgroundColor = CLEARCOLOR;
    [searchButton setImage:[UIImage imageNamed:@"category_search.png"] forState:UIControlStateNormal];
    searchButton.frame = CGRectMake(ScreenWidth - 40 -10, 2, 40, 40);
    [searchButton addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:searchButton];
    //  搜索栏
    //设置textfield
    searchBar = [[UITextField alloc]initWithFrame:CGRectMake(5, 5, 260, 30)];
    searchBar.borderStyle = UITextBorderStyleRoundedRect;
    searchBar.placeholder = String_navi_home_searchBar;
    searchBar.delegate = self;
    searchBar.clearsOnBeginEditing = YES;
    searchBar.returnKeyType = UIReturnKeyDone;
    searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    //    [_searchBar addTarget:self action:@selector(filter:) forControlEvents:UIControlEventEditingChanged];
    searchBar.leftViewMode = UITextFieldViewModeAlways;
    searchBar.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search_textfield_background.png"]];
    searchBar.disabledBackground =[UIImage imageNamed:@"navigationbar_background.png"];
    [self.navigationController.navigationBar addSubview: searchBar];
}
//显示视图
-(void)showView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    修改userdefaults
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:kisshowSecondView];
    [[NSUserDefaults standardUserDefaults]synchronize];
//    左侧平移
    CATransition *animation = [CATransition animation];
    animation.duration = 0.1;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:@"easeInEaseOut"];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromLeft;
    [leftView.layer addAnimation:animation forKey:@"test"];
    leftView.transform = CGAffineTransformIdentity;
//    移动右侧
    [self moveRightView:NO didSelectRowAtIndexPath:indexPath];
//改变navigation
    [self changeNavigation:YES];
}
//移动右侧视图。 isAnimate代表右侧滑块是否移动。 yes 有动画移动
-(void)moveRightView:(BOOL)isAnimate didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    更改title
    CategoryMainCell *cell = (CategoryMainCell *)[mainTableView cellForRowAtIndexPath:indexPath];
    NSString *titleName = cell.title.text;
    self.title = titleName;
    CGPoint point =[cell.contentView convertPoint:CGPointZero fromView:leftView ];
//    刷新table
    [mainTableView reloadData];
//    滑块移动
    if (isAnimate)
    {
        [UIView animateWithDuration:.1 animations:^{
            arrowsImageView.top =  - point.y;
            UILabel *label = (UILabel *)VIEWWITHTAG(rightView, 100);
            label.text = titleName;
        }];

    }
    else
    {
        arrowsImageView.top =  - point.y;
        UILabel *label = (UILabel *)VIEWWITHTAG(rightView, 100);
        label.text = titleName;
        rightView.hidden = NO;
    }
    
    if ([leftView subviews]) {
        [CourseTableView removeFromSuperview];
    }
    CourseTableView = [[CategoryTableView alloc]init];
    CourseTableView.eventDelegate = self;
    [leftView addSubview:CourseTableView];
    NSString *categoryId = [mainArray[indexPath.row] objectForKey:@"categoryID"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:[OpenUDID value] forKey: params_deviceID];
    [params setValue:categoryId forKey:params_categoryID];
    [self getDate:URL_getCourseList andParams:params andcachePolicy:1 success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSArray *arr = [responseObject objectForKey:@"course" ];
        NSMutableArray *dataArr = [[NSMutableArray alloc]init];
        for (int i = 0 ; i < arr.count ; i++) {
            NSDictionary *dic = arr[i];
            CourseModel *model = [[CourseModel alloc]initWithDataDic:dic];
            [dataArr addObject:model];
        }
        CourseTableView.dataArray = dataArr;
        _pn(CourseTableView.dataArray.count);

        [CourseTableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
}
//隐藏左右视图 修改navigation
-(void)hiddenView{
//    修改userdefaults
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:kisshowSecondView];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [mainTableView reloadData];
//    设置标题
    self.title = @"";
//    隐藏右视图
    [UIView animateWithDuration:.1 animations:^{
        rightView.hidden = YES;
    }];
//    平移左视图
    CATransition *animation = [CATransition animation];
    animation.duration = 0.2;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:@"easeInEaseOut"];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    [leftView.layer addAnimation:animation forKey:@"test"];
    leftView.transform = CGAffineTransformTranslate(leftView.transform, -320+100, 0);
//    更改navigation
    [self changeNavigation:NO];
    
}
//isshowReturn  yes:显示返回按钮
-(void)changeNavigation:(BOOL)isShowReturn{
    if (!cancelButton) {
        cancelButton = [[UIButton alloc]init];
        cancelButton.backgroundColor = CLEARCOLOR;
        [cancelButton setImage:[UIImage imageNamed:@"category_back.png"] forState:UIControlStateNormal];
        cancelButton.frame = CGRectMake(0, 0, 40, 40);
        [cancelButton addTarget:self action:@selector(cencel) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:cancelButton];
        self.navigationItem.leftBarButtonItem = backItem;
        cancelButton.hidden = YES;
    }
    if (isShowReturn) {
        cancelButton.hidden = NO;
        searchButton.hidden = YES;
        searchBar.hidden = YES;
    }else{
        cancelButton.hidden = YES;
        searchButton.hidden = NO;
        searchBar.hidden = NO;
    }
    
}
#pragma mark Action 
-(void)cencel{
    [self hiddenView];
}
-(void)searchAction:(UIButton *)button{
    
}
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return mainArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"categoryMain";
    CategoryMainCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[CategoryMainCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
//    填充数据
    NSDictionary *dic = mainArray[indexPath.row];
    cell.title.text = [dic objectForKey:@"title"];
    cell.title.textColor = colorArray[indexPath.row %colorArray.count];
    cell.hiddenTitle.text = [dic objectForKey:@"title"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.desc.text = [dic objectForKey:@"desc"];
    cell.Image.image = [UIImage imageNamed:[dic objectForKey:@"img"]];
    UISwipeGestureRecognizer *swipeRightGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(dragTableView:)];
    [cell.contentView addGestureRecognizer:swipeRightGesture];

    
    return cell;
}
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isKindOfClass:[CategoryTableView class]]) {
        
    }else{
        if (![[NSUserDefaults standardUserDefaults]boolForKey:kisshowSecondView]) {
            [self showView:tableView didSelectRowAtIndexPath:indexPath];
        }else{
            [self moveRightView:YES didSelectRowAtIndexPath:indexPath];
        }
    }
    
}
#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _pf(scrollView.contentOffset.y);

    arrowsImageView.top +=(MainTableViewBegin -scrollView.contentOffset.y  );
    MainTableViewBegin = scrollView.contentOffset.y;

}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    MainTableViewBegin = scrollView.contentOffset.y;
}
#pragma mark UIPanGestureRecognizer
-(void)dragTableView:(UISwipeGestureRecognizer *)panGestureRecognizer{
    switch (panGestureRecognizer.direction) {
        case UISwipeGestureRecognizerDirectionLeft:
            [self hiddenView];
            break;
        case UISwipeGestureRecognizerDirectionRight:{
            CGPoint point =[panGestureRecognizer locationInView:mainTableView];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(point.y/55) inSection:0];
            [self showView:mainTableView didSelectRowAtIndexPath:indexPath];
        }
        default:
        break;
    }
    
}
@end
