//
//  CategoryViewController.h
//  duoduo
//
//  Created by tenyea on 14-3-25.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "TenyeaBaseViewController.h"
#import "CategoryTableView.h"
@interface CategoryViewController : TenyeaBaseViewController <UITableViewDataSource,UITableViewDelegate,TYTableViewDelegate,UITextFieldDelegate>

{
    UITableView *mainTableView;
//    栏目视图数据集
    NSArray *mainArray ;
//    分类字体颜色
    NSArray *colorArray ;
    UIView *rightView;
    UIView *leftView;
    UIView *arrowsImageView;//箭头
    
    float MainTableViewBegin;//main起始位置
    
    UIButton *searchButton;
    UIButton *cancelButton;
    //搜索栏
    UITextField *searchBar;
    //课程列表
    CategoryTableView *CourseTableView;
}

@end
