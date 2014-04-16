//
//  CoursesLeftCell.h
//  duoduo
//
//  Created by tenyea on 14-4-12.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface CoursesLeftCell : UITableViewCell


//left
@property (strong, nonatomic) IBOutlet UILabel *leftTitleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *leftImage;
- (IBAction)leftAction:(id)sender;

//top
@property (strong, nonatomic) IBOutlet UIImageView *topImage;
@property (strong, nonatomic) IBOutlet UILabel *topTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *topDescLabel;
- (IBAction)topAction:(id)sender;


//bottom
@property (strong, nonatomic) IBOutlet UILabel *bottomTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *bottomDescLabel;
@property (strong, nonatomic) IBOutlet UIImageView *bottomImage;
- (IBAction)bottomAction:(id)sender;



@end
