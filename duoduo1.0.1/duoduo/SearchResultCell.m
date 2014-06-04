//
//  SearchResultCell.m
//  duoduo
//
//  Created by tenyea on 14-4-24.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "SearchResultCell.h"
#import <QuartzCore/QuartzCore.h>
#import "CourseModel.h"
#import "UIImageView+WebCache.h"
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
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    NSURL *url = [NSURL URLWithString:self.model.course_images];
    [self.rightImageView setImageWithURL:url placeholderImage:LogoImage_60x50];
    self.titleLabel.text = self.model.courseName;
    self.contentLabel.text = self.model.Description;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",self.model.course_price];
    if ([self.model.course_price intValue]  == [self.model.course_sell_price intValue]) {
        self.currentPriceLabel.hidden = YES;
        self.discountLabel.hidden = YES;
    }else{
        self.currentPriceLabel.hidden = NO;
        self.discountLabel.hidden = NO;
        self.currentPriceLabel.text = [NSString stringWithFormat:@"￥%@",self.model.course_sell_price];
        self.discountLabel.text = [NSString stringWithFormat:@"%d折",[self.model.course_price_discount intValue]];
    }
}
@end
