//
//  CollectionCell.m
//  duoduo
//
//  Created by tenyea on 14-4-28.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "CollectionCell.h"

@implementation CollectionCell

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

@end
