//
//  OneDayCell.m
//  duoduo
//
//  Created by tenyea on 14-4-24.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "OneDayCell.h"

@implementation OneDayCell

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

- (IBAction)messageAction:(id)sender {
}
@end
