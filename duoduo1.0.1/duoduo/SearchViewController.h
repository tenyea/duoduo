//
//  SearchViewController.h
//  duoduo
//
//  Created by tenyea on 14-4-26.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "TenyeaBaseViewController.h"
#import "TYTextField.h"
@interface SearchViewController : TenyeaBaseViewController<TYTextFieldDelegate>

{
    TYTextField *searchBar;
    IBOutlet UIImageView *sliderView;
    int type;//0:价格升序 1：价格降序 2：人气降序 3：推荐度 4：相关度
    NSString *_content;
    IBOutlet UIImageView *asc;
    IBOutlet UIImageView *desc;
    
    BOOL isloading;
}

- (IBAction)orderAction:(UIButton *)sender;
@end
