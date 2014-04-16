//
//  CategoryMainCell.h
//  duoduo
//
//  Created by tenyea on 14-4-15.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryMainCell : UITableViewCell{
}

@property (strong, nonatomic)  UILabel *desc;
@property (strong, nonatomic)  UILabel *title;
@property (strong, nonatomic)  UIImageView *Image;
@property (nonatomic,strong) UIColor *titleColor;

@property (nonatomic,strong) UILabel *hiddenTitle;
@end
