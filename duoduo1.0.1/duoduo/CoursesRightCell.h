//
//  CoursesRightCell.h
//  duoduo
//
//  Created by tenyea on 14-4-12.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoursesRightCell : UITableViewCell

//上
@property (strong, nonatomic) IBOutlet UIImageView *TopImage;
@property (strong, nonatomic) IBOutlet UILabel *TopTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *TopDescLabel;
- (IBAction)TopAction:(id)sender;
//下
@property (strong, nonatomic) IBOutlet UILabel *BottomTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *BottonDescLabel;
@property (strong, nonatomic) IBOutlet UIImageView *BottonImage;
- (IBAction)BottomAction:(id)sender;
//右
@property (strong, nonatomic) IBOutlet UILabel *RightTitleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *RightImage;
- (IBAction)rightAction:(id)sender;


@end
