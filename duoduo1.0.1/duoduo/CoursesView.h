//
//  CoursesView.h
//  duoduo
//
//  Created by tenyea on 14-4-14.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoursesView : UIView

- (IBAction)TouchAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *button;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UILabel *descLable;
@property (strong, nonatomic) IBOutlet UIImageView *ImageView;
@property (strong, nonatomic) IBOutlet UIView *bgView;

@end
