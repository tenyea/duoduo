//
//  SearchResultCell.h
//  duoduo
//
//  Created by tenyea on 14-4-24.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYLabel.h"
@class CourseModel;
@interface SearchResultCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *rightImageView;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet TYLabel *currentPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *discountLabel;
@property (strong, nonatomic) CourseModel *model;
@end
