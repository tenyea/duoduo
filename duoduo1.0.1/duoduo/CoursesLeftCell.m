//
//  CoursesLeftCell.m
//  duoduo
//
//  Created by tenyea on 14-4-12.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "CoursesLeftCell.h"
@implementation CoursesLeftCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)layoutSubviews{
    [super layoutSubviews];

}
- (IBAction)leftAction:(id)sender {
    NSLog(@"1232");
}
- (IBAction)bottomAction:(id)sender {
    NSLog(@"444");
}
- (IBAction)topAction:(id)sender {
    NSLog(@"555");

}
@end
