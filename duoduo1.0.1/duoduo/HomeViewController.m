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
{
    UIView *_searchBGView;
}
@synthesize searchBar = searchBar;
@synthesize tableView,resultTableView;
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
    tableView.alpha=0;
    resultTableView.alpha=0;
   
    _searchBGView.alpha=0;
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
    self.resultTableView = [[UITableView alloc]init];
    self.resultTableView.delegate = self;
    self.resultTableView.dataSource = self;
    self.resultTableView.delaysContentTouches = NO;
    //    _resultTableView.backgroundColor = [UIColor redColor];
    resultTableView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-20-44);
    [self.view addSubview:self.resultTableView];
    
    
    _searchBGView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _searchBGView.backgroundColor = [UIColor colorWithRed:247 green:247 blue:247 alpha:1];
    _searchBGView.userInteractionEnabled = YES;
    [self.view addSubview:_searchBGView];
    
    
 //   [self _initSearchBar];
    
    tableView = [[UITableView alloc]init];
    tableView.tag = 1304;
    //    int tableheigh = 200;
    tableView.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    tableView.delaysContentTouches = NO;
    [self.view addSubview:tableView];
  //  tableView.height = _searchData.count *44;
  //  UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(disFocus:)];
  //  [_searchBGView addGestureRecognizer:tapGesture];
    
    //清空按钮
    UIButton *clearButton = [[UIButton alloc]init];
    clearButton.frame = CGRectMake(0, 5, ScreenWidth, 44);
    [clearButton setTitle:@"清除历史记录" forState: UIControlStateNormal];
    [clearButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
 //   [clearButton addTarget:self action:@selector(clearHistory) forControlEvents:UIControlEventTouchUpInside];
    clearButton.backgroundColor = CLEARCOLOR;
    tableView.tableFooterView = clearButton;

    textField.text = nil;
    //    刷新数据
  //  self.searchData = _searchHistoryData;
 //   [self.tableView reloadData];
    //    [self.tableView setHidden:NO];
    //    如果数据大于0 则显示foot按钮
//    if (_searchHistoryData.count >0) {
//        [_tableView.tableFooterView setHidden:NO ];
//    }else{
//        [_tableView.tableFooterView setHidden:YES ];
//    }
     [tableView.tableFooterView setHidden:YES ];
    [_searchBGView setHidden:NO];
    [tableView setHidden:NO];
//    if (_searchData.count *44>ScreenHeight) {
//        _tableView.height = ScreenHeight;
//    }else{
//        _tableView.height = _searchData.count *44 +44;
//    }
    [UIView animateWithDuration:0.2 animations:^{
        _searchBGView.alpha = 1;
        tableView.alpha =1;
    } completion:^(BOOL finished) {
        
    }];
    

    
    
    return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (tableView.tag ==1304) {
//        return [_searchData count];
//        
//    }else{
//        return [_resultData count];
//    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 320, 44)];
        label.tag = 101;
        [cell.contentView addSubview:label];
    }
    
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:101];
//    if (tableView.tag == 1304) {
//        
//        label.text = _searchData[indexPath.row];
//    }else{
//        ColumnModel *model = _resultData[indexPath.row];
//        label.text = model.title;
//    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if ([self getConnectionAlert]) {
//        if (tableView.tag == 1304) {
//            //textfield失去响应
//            [_searchBar resignFirstResponder];
//            NSString *text = _searchData[indexPath.row];
//            //    访问数据
//            DataService *service = [[DataService alloc]init];
//            NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
//            [params setValue:text forKey:@"content"];
//            service.eventDelegate = self ;
//            [service requestWithURL:URL_Search andparams:params isJoint:YES andhttpMethod:@"GET"];
//            [self showHUD:INFO_Searching isDim:YES];
//            //    隐藏查询表
//            [self.tableView setHidden:YES];
//            [self bgViewhidden];
//        }else{
//            ColumnModel *model =_resultData[indexPath.row];
//            [self pushNewswithColumn:model];
//            [tableView deselectRowAtIndexPath:indexPath animated:YES];
//            
//        }
//        
//    }
//}

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
