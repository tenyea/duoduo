//
//  HomeViewController.m
//  duoduo
//
//  Created by tenyea on 14-3-25.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "HomeViewController.h"
#import "QRcodeViewController.h"
@interface HomeViewController ()
@property (nonatomic, strong) NSTimer *workTimer;
@property (nonatomic, strong) NSMutableArray *items;
@end

@implementation HomeViewController
@synthesize searchBar = searchBar;

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
    
//    初始化navigationbar
    [self _initNavigationBar];
    /*
//    初始化数据
    [self getDate:URL_home_main andParams:nil andcachePolicy:0 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        dataDic = responseObject;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        说明cache无数据
        [self getDate:URL_home_main andParams:nil andcachePolicy:1 success:^(AFHTTPRequestOperation *operation, id responseObject) {
            dataDic = responseObject;
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
    }];
     */
//    获取数据
    [self loadDate];
//    初始化view
    [self _initView];
}
-(void)viewWillDisappear:(BOOL)animated{
    logoImageView.hidden = YES;
    cameraButton.hidden = YES;
    [self.navigationController setNavigationBarHidden:YES];
    [super viewWillDisappear:animated];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    logoImageView.hidden = NO;
    cameraButton.hidden = NO;
}
#pragma mark -
#pragma mark init
-(void)_initNavigationBar{
//    添加logo
    UIImage *image = [UIImage imageNamed:@"nav_logo.png"];
    logoImageView = [[UIImageView alloc]initWithImage:image];
    logoImageView.frame = CGRectMake(10, 0, 60, 44);
    [self.navigationController.navigationBar addSubview:logoImageView];
//    添加右侧按钮
    cameraButton = [[UIButton alloc]init];
    cameraButton.backgroundColor = CLEARCOLOR;
    [cameraButton setImage:[UIImage imageNamed:@"navi_home_right_camera.png"] forState:UIControlStateNormal];
    cameraButton.frame = CGRectMake(ScreenWidth - 40 -10, 2, 40, 40);
    [cameraButton addTarget:self action:@selector(cameraAction:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:cameraButton];
//    self.navigationItem.rightBarButtonItem = backItem;
    [self.navigationController.navigationBar addSubview:cameraButton];
//  搜索栏
    //设置textfield
    searchBar = [[UITextField alloc]initWithFrame:CGRectMake(15, 5, 180, 30)];
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
    self.navigationItem.titleView = searchBar;
}
-(void)loadDate{
    [bgTabelView reloadData];
}
-(void)_initView{
//    背景图
    bgTabelView = [[HomeTableView alloc]initWithFrame:self.view.bounds isMore:NO refreshHeader:YES];
//        self.view = bgTabelView;
    bgTabelView.eventDelegate = self;
    [self.view addSubview: bgTabelView];
    bgTabelView.separatorStyle = UITableViewCellSeparatorStyleNone; //去除分割线
//    bgTabelView.

}

#pragma mark date

#pragma mark -
#pragma mark 按钮事件


//照相按钮
-(void)cameraAction:(UIButton *)button {
    QRcodeViewController *VC = [[QRcodeViewController alloc]init];
    [self presentViewController:VC animated:YES completion:nil];
}
//取消按钮
-(void)cancelAction:(UIButton *)button {
    [self cancelAnimate];
}
#pragma mark method
//取消按钮动画
-(void)cancelAnimate{
    [UIView animateWithDuration:.5 animations:^{
        cancelButton.transform = CGAffineTransformScale(cancelButton.transform, 0, 0);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.5 animations:^{
            cameraButton.transform = CGAffineTransformIdentity ;
        }];
    }];
    //    清空内容
    searchBar.text = nil;
    //    失去响应
    [searchBar resignFirstResponder];
}

#pragma mark - 
#pragma mark delegate
#pragma mark UITextFieldDelegate
//点击textfield事件
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//    修改右侧按钮
//    初始化取消按钮
    if (!cancelButton) {
        cancelButton = [[UIButton alloc]init];
        cancelButton.backgroundColor = CLEARCOLOR;
        [cancelButton setTitle:button_cancel forState:UIControlStateNormal];
        cancelButton.frame = cameraButton.frame;
        [cancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        cancelButton.transform = CGAffineTransformScale(cancelButton.transform, 0, 0);
        [self.navigationController.navigationBar addSubview:cancelButton];
    }
    [UIView animateWithDuration:.5 animations:^{
        cameraButton.transform = CGAffineTransformScale(cameraButton.transform, 0, 0) ;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.5 animations:^{
            cancelButton.transform = CGAffineTransformIdentity;

        }];
    }];
    return YES;
}
//将要结束
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    return YES;
}

#pragma mark TYScrollViewDelegate
-(void)refreshDate{
    [self performSelector:@selector(test) withObject:nil afterDelay:3];
}
-(void)test{
    [bgTabelView donerefreshData];
}

-(void)loadMoreDate{
    [self performSelector:@selector(test) withObject:nil afterDelay:1];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
