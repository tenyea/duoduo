//
//  BuyCarCell.m
//  duoduo
//
//  Created by tenyea on 14-4-23.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "BuyCarCell.h"

@implementation BuyCarCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
