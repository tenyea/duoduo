//
//  TYTextField.m
//  duoduo
//
//  Created by tenyea on 14-4-25.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "TYTextField.h"
#import "FileUrl.h"
#import "FMDatabase.h"
#import "CourseModel.h"
@implementation TYTextField
-(id)initWithFrame:(CGRect)frame andclass:(Class) className{
    self = [self initWithFrame:frame];
    if (self) {
       _className = className;
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initView];
    }
    return self;
}

-(void)_initView{
    self.delegate = self;
    self.borderStyle = UITextBorderStyleRoundedRect;
    self.placeholder = @"请输入搜索内容";
    self.clearsOnBeginEditing = YES;
    self.returnKeyType = UIReturnKeyDone;
    self.autocorrectionType = UITextAutocorrectionTypeNo;
    [self addTarget:self action:@selector(filter:) forControlEvents:UIControlEventEditingChanged];
    self.leftViewMode = UITextFieldViewModeAlways;
//    _searchBar.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search_textfield_background.png"]];
//    _searchBar.disabledBackground =[UIImage imageNamed:@"navigationbar_background.png"];
    //搜索数据内容
    FMDatabase *db = [FileUrl getDB];
    if (![db open]) {
        NSLog(@"Could not open db.");
        return ;
    }
    //          表明 searchHistory
    //          字段（主键）  searchContent
    allHistoryArray = [[NSMutableArray alloc]init];
    FMResultSet *set = [db executeQuery:@"select searchContent from searchHistory" ];
    while (set.next) {
        NSString *content = [set stringForColumn:@"searchContent"];
        [allHistoryArray addObject:content];
    }
    [db close];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    //    查找当前页面
    UINavigationController *base =(UINavigationController *) self.viewController;
    NSArray *arr =  base.viewControllers ;
    for (UIViewController *vc in arr) {
        if ([vc class] == _className) {
            if (!self.resultTableView) {
                self.resultTableView = [[TYTableView alloc]initWithFrame:CGRectMake(0, 0, vc.view.width, vc.view.height -49) isMore:YES refreshHeader:NO];
                self.resultTableView.top +=50;
                self.resultTableView.height -=50;
                self.resultTableView.delegate = self ;
                self.resultTableView.dataSource = self ;
                //self.resultTableView.delaysContentTouches = NO;
                self.resultTableView.hidden = NO;
                self.resultTableView.tag = 500;
                _resultTableView.eventDelegate  =  self;
                [vc.view addSubview:self.resultTableView];
            }
            //            初始化背景视图
            if (!bgView) {
                bgView = [[UIView alloc]initWithFrame:self.resultTableView.frame];
                bgView.backgroundColor = [UIColor whiteColor];
                bgView.userInteractionEnabled = YES;
                bgView.hidden = YES;
                [vc.view addSubview:bgView];
                //添加点击背景视图页面消失的手势
                UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(disFocus:)];
                [bgView addGestureRecognizer:tapGesture];
            }
            
            //            添加查询结果视图
            
            
            //            初始化查询历史tableview
            if (!searchTableView) {
                searchTableView = [[UITableView alloc]initWithFrame:bgView.frame];
                searchTableView.delegate = self;
                searchTableView.dataSource = self;
                searchTableView.delaysContentTouches = NO;
                [vc.view addSubview: searchTableView];
                
                //清空按钮
                UIButton *clearButton = [[UIButton alloc]init];
                clearButton.frame = CGRectMake(0, 5, ScreenWidth, 44);
                [clearButton setTitle:@"清除历史记录" forState: UIControlStateNormal];
                [clearButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [clearButton addTarget:self action:@selector(clearHistory) forControlEvents:UIControlEventTouchUpInside];
                clearButton.backgroundColor = CLEARCOLOR;
                searchTableView.tableFooterView =clearButton;
                searchTableView.hidden = YES;
            }
            
            
        }
    }
}
-(BOOL)bgViewIsShow{
    return bgView.hidden;
}
#pragma mark Action
//隐藏视图
-(void)disFocus:(UITapGestureRecognizer *)UIGR{
    [self resignFirstResponder];
    bgView.hidden = YES;
    searchTableView.hidden = YES;
}

//清除历史
-(void)clearHistory{
//    清空数组
    searchHistoryArray = nil;
    searchHistoryArray = [[NSArray alloc]init];
    allHistoryArray = nil;
    allHistoryArray = [[NSMutableArray alloc]init];
//    清空数据
    FMDatabase *db = [FileUrl getDB];
    if (![db open]) {
        NSLog(@"Could not open db.");
        return ;
    }
    [db executeUpdate:@"delete from searchHistory"];
    [db close];
    //    刷新tableview
    searchTableView.height = 0;
    searchTableView.hidden = YES;
    [searchTableView reloadData];
}
//向数组和数据库中插入数据
-(void)insertDate:(NSString *)str{
    FMDatabase *db = [FileUrl getDB];
    if (![db open]) {
        NSLog(@"Could not open db.");
        return ;
    }
//    数据库插入成功。则向数组中插入一条
    if ([db executeUpdate:[NSString stringWithFormat:@"insert into searchHistory values('%@')",str]]) {
        [allHistoryArray addObject:str];
    }
    [db close];

}

#pragma mark 校验
-(void)filter:(UITextField *)textField{
    //    长度为0时，重新计算高度和内容
    if ([textField.text length] == 0) {
        searchHistoryArray = allHistoryArray;
        [searchTableView reloadData];
        searchTableView.height = allHistoryArray.count*44 + 44;
        return;
    }
    //    匹配规则
    NSString *regex = [NSString stringWithFormat:@"SELF LIKE[c]'*%@*'", textField.text];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:regex];
    //    筛选结果
    searchHistoryArray = [allHistoryArray filteredArrayUsingPredicate:predicate] ;
    //    计算高度
    if (searchHistoryArray.count *44>bgView.height) {
    }else{
        searchTableView.height = searchHistoryArray.count *44 +44;
    }
    if (searchHistoryArray.count==0) {
        searchTableView.height = 0;
        [searchTableView.tableFooterView setHidden:YES ];
    }else{
        [searchTableView.tableFooterView setHidden:NO ];
    }
    //刷新
    [searchTableView reloadData];
    
    
}
#pragma mark UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self resignFirstResponder];

    //    未输入则不查询，也不添加到查询记录中
    if (textField.text ==nil||[textField.text isEqualToString:@""]) {
        return NO;
    }
    [self.dateDelegate selectInSearchTableViewBy:textField.text andTableView:self.resultTableView];
    [self insertDate:textField.text];
    bgView .hidden = YES;
    searchTableView.hidden = YES;
    return YES;
}
//点击textfield事件
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//    设置输入内容为空
    textField.text = nil;
//    重新加载数据
    searchHistoryArray = allHistoryArray;
    bgView.hidden = NO;
    //            根据内容计算是否隐藏tableview
    if (searchHistoryArray.count>0) {
        searchTableView.hidden = NO;
        searchTableView.tableFooterView.hidden = NO;
        [searchTableView reloadData];
    }
    //            根据内容计算高度
    if(searchHistoryArray.count *44 +44 >bgView.height){
        searchTableView.height = bgView.height;
    }else{
        searchTableView.height = searchHistoryArray.count *44 +44;
    }
    return YES;
}
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    结果
    if (tableView.tag == 500) {
        if (self.resultArray.count > 0) {
            self.resultTableView.hidden = NO;
        }
        return _resultArray.count;
    }else{//检车匹配
        return searchHistoryArray.count;
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    结果
    if (tableView.tag == 500) {
        return [self.dateDelegate tableView:tableView cellForRowAtIndexPath:indexPath andTextfield:self];
    }else{//检车匹配
        static NSString *searchIdentifier = @"searchIdentifier" ;
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:searchIdentifier];
        if (cell==nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:searchIdentifier];
        }
        cell.textLabel.text = searchHistoryArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}
#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    结果
    if (tableView.tag == 500) {
        if ([self.dateDelegate respondsToSelector:@selector(selectInResultTableVIew:andIndexPath:)]) {
            [self.dateDelegate selectInResultTableVIew:self andIndexPath:indexPath];
        }
    }else{//检车匹配
        NSString *text = searchHistoryArray[indexPath.row];
        [self.dateDelegate selectInSearchTableViewBy:text andTableView:self.resultTableView];
//        数据库和数组中插入一条
        [self insertDate:text];
//        隐藏查询列表
        bgView.hidden = YES;
        searchTableView.hidden = YES;
        //textfield失去响应
        [self resignFirstResponder];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    结果
    if (tableView.tag == 500) {
        return [self.dateDelegate tableView:tableView heightForRowAtIndexPath:indexPath andTextfield:self];
    }else{//检车匹配
        return 44;
    }
}
#pragma mark TYTableViewDelegate
-(void)loadMoreDate:(UITableView *)tableView{
    if ([self.dateDelegate respondsToSelector:@selector(loadMoreDate:)]) {
        [self.dateDelegate loadMoreDate:tableView];
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView.tag ==500) {
        if (scrollView.contentOffset.y < 0) {
            return;
        }
        if (scrollView.contentOffset.y+(scrollView.frame.size.height) > scrollView.contentSize.height +60 ) {
            if([self.dateDelegate respondsToSelector:@selector(loadMoreDate:)]){
                [self.dateDelegate loadMoreDate:_resultTableView];
                UIButton *button = (UIButton *)VIEWWITHTAG(scrollView, 3000);
                [button setTitle:button_loading forState:UIControlStateNormal];
                button.enabled = NO;
                UIActivityIndicatorView *activityView=(UIActivityIndicatorView *)[button viewWithTag:1000];
                [activityView startAnimating];
            }
        }
    }
}
@end
