//
//  CoursesRightCell.m
//  duoduo
//
//  Created by tenyea on 14-4-12.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "CoursesRightCell.h"

@implementation CoursesRightCell

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

- (IBAction)rightAction:(id)sender {
    _po(@"1111");
}
- (IBAction)TopAction:(id)sender {
    _po(@"2222");
}
- (IBAction)BottomAction:(id)sender {
    _po(@"3333");
}
@end
