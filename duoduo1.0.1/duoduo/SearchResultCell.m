//
//  SearchResultCell.m
//  duoduo
//
//  Created by tenyea on 14-4-24.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "SearchResultCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation SearchResultCell

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
#warning <#message#>
//    self.imageView.clipsToBounds = YES;
//    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
//    [self.imageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
