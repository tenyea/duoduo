//
//  CategoryViewController.m
//  duoduo
//
//  Created by tenyea on 14-3-25.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "CategoryViewController.h"
#import "CategoryMainCell.h"
#define Category_Height  ScreenHeight-49-20
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
    
    mainTableView = [[UITableView alloc]init];
    mainTableView.frame = CGRectMake(0, 0, ScreenWidth+220, Category_Height);
    mainTableView.delegate = self;
    mainTableView.dataSource = self;

    [self.view addSubview:mainTableView];
//    左侧视图
    leftView = [[UIView alloc]init];
    leftView.frame = CGRectMake(0, 0, ScreenWidth-100, Category_Height);
    leftView.transform = CGAffineTransformTranslate(leftView.transform, -320+100, 0);
    leftView.backgroundColor = [UIColor redColor];
//    添加手势
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragTableView:)];
    [leftView addGestureRecognizer:panGestureRecognizer];
    [self.view addSubview:leftView];
    
//    右侧视图
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
    lineImageView.hidden = YES;
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
    
    [self _initNavigation];
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
-(void)showView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:kisshowSecondView];
    [[NSUserDefaults standardUserDefaults]synchronize];
    

    CATransition *animation = [CATransition animation];
    animation.duration = 0.3;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:@"easeInEaseOut"];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromLeft;
    [leftView.layer addAnimation:animation forKey:@"test"];
    leftView.transform = CGAffineTransformIdentity;
    [self moveRightView:NO didSelectRowAtIndexPath:indexPath];

    
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
    cancelButton.hidden = NO;
    searchButton.hidden = YES;
    searchBar.hidden = YES;


}
-(void)moveRightView:(BOOL)isAnimate didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CategoryMainCell *cell = (CategoryMainCell *)[mainTableView cellForRowAtIndexPath:indexPath];
    NSString *titleName = cell.title.text;
    self.title = titleName;
    CGPoint point =[cell.contentView convertPoint:CGPointZero fromView:leftView ];
    [mainTableView reloadData];
    [mainTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    if (isAnimate) {
        [UIView animateWithDuration:.1 animations:^{
            arrowsImageView.top =  - point.y;
            UILabel *label = (UILabel *)VIEWWITHTAG(rightView, 100);
            label.text = titleName;
        }];

    }else{
        arrowsImageView.top =  - point.y;
        UILabel *label = (UILabel *)VIEWWITHTAG(rightView, 100);
        label.text = titleName;
        rightView.hidden = NO;
    }
    
}

-(void)hiddenView{
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:kisshowSecondView];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [mainTableView reloadData];
    self.title = @"";
    [UIView animateWithDuration:.1 animations:^{
        rightView.hidden = YES;
    }];
    CATransition *animation = [CATransition animation];
    animation.duration = 0.6;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:@"easeInEaseOut"];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    [leftView.layer addAnimation:animation forKey:@"test"];
    leftView.transform = CGAffineTransformTranslate(leftView.transform, -320+100, 0);
    
    cancelButton.hidden = YES;
    searchButton.hidden = NO;
    searchBar.hidden = NO;
}
#pragma mark Action 
-(void)cencel{
    [self hiddenView];
}
-(void)searchAction:(UIButton *)button{
    
}
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"categoryMain";
    CategoryMainCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
//        cell = [[[NSBundle mainBundle]loadNibNamed:@"CategoryMainCell" owner:self options:nil] lastObject];
        cell = [[CategoryMainCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.title.text = [NSString stringWithFormat:@"语言能力%d",indexPath.row];
    cell.hiddenTitle.text = [NSString stringWithFormat:@"语言能力"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
//    cell.selectedBackgroundView.backgroundColor = COLOR(244, 141, 32);
    return cell;
}
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (![[NSUserDefaults standardUserDefaults]boolForKey:kisshowSecondView]) {
        [self showView:tableView didSelectRowAtIndexPath:indexPath];
    }else{
        [self moveRightView:YES didSelectRowAtIndexPath:indexPath];
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
-(void)dragTableView:(UIPanGestureRecognizer *)panGestureRecognizer{
    _po(panGestureRecognizer);
    CGPoint point =[panGestureRecognizer translationInView:leftView];
    DLogPoint(point);
        switch (panGestureRecognizer.state) {
        case UIGestureRecognizerStateEnded:{
            
            
            }
                
            break;
        default:{
            float x = leftView.center.x +point.x;
            _pf(x);
            float y = leftView.frame.size.width/2 ;
            _pf(y);
            CGFloat newXCenter = MIN( x , y);
            [leftView setCenter:CGPointMake(newXCenter, leftView.center.y)];

        }

            break;
    }

}
@end
