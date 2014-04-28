//
//  MyCoursesCell.h
//  duoduo
//
//  Created by tenyea on 14-4-21.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCoursesCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *describeLabel;
- (IBAction)shareBtnAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *courseImage;

@end
