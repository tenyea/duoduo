//
//  CategoryViewController.h
//  duoduo
//
//  Created by tenyea on 14-3-25.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "TenyeaBaseViewController.h"

@interface CategoryViewController : TenyeaBaseViewController <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

{
    UITableView *mainTableView;
    UIView *rightView;
    UIView *leftView;
    UIView *arrowsImageView;//箭头
    
    float MainTableViewBegin;//main起始位置
    
    UIButton *searchButton;
    UIButton *cancelButton;
    //搜索栏
    UITextField *searchBar;
}

@end
