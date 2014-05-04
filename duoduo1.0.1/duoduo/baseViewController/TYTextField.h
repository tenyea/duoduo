//
//  TYTextField.h
//  duoduo
//
//  Created by tenyea on 14-4-25.
//  Copyright (c) 2014年 zzw. All rights reserved.
//
@class TYTextField;
@protocol TYTextFieldDelegate <NSObject>
//查询内容
-(void)selectInSearchTableViewBy:(NSString *)content andTableView:(UITableView *)tableView;
//选中的结果
-(void)selectInResultTableVIew:(TYTextField *)textField andIndexPath:(NSIndexPath *)indexPath;
//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath andTextfield:(TYTextField *)textField;
//高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath andTextfield:(TYTextField *)textField;
//加载更多数据
-(void)loadMoreDate:(UITableView *)tableView;
@end
#import <UIKit/UIKit.h>
#import "TYTableView.h"
@interface TYTextField : UITextField <UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,TYTableViewDelegate>{
    //用于存放匹配后的数据
    NSArray *searchHistoryArray;
    //添加到当前controller上的view
    UIView *bgView;
    
    //查询内容匹配视图
    UITableView *searchTableView;
    //当前类名。用于查找当前view
    Class _className;
    //搜索数组。用于存放所有数据数据
    NSMutableArray *allHistoryArray;

    
}
-(BOOL)bgViewIsShow;
-(id)initWithFrame:(CGRect)frame andclass:(Class) className;
//搜索结果
@property (nonatomic,retain) TYTableView *resultTableView;
@property (nonatomic,assign) id<TYTextFieldDelegate> dateDelegate;
//返回的数据
@property (nonatomic,copy) NSArray *resultArray;
@end
