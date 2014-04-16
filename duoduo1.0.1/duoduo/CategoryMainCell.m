//
//  CategoryMainCell.m
//  duoduo
//
//  Created by tenyea on 14-4-15.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "CategoryMainCell.h"

@implementation CategoryMainCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initView];
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [self _initView];
}
-(void)_initView{
    self.title = [[UILabel alloc]init];
    _title.frame = CGRectMake(90, 7, 60, 11);
    _title.font = [UIFont boldSystemFontOfSize:11];
    [self.contentView addSubview:_title];
    
    self.Image = [[UIImageView alloc]init];
    _Image.frame = CGRectMake(12, 1, 52, 52);
    _Image.image = [UIImage imageNamed:@"home_48.png"];
    [self.contentView addSubview:_Image];
    
    self.desc =[[UILabel alloc]init];
    _desc.frame = CGRectMake(92, 21, 121, 33);
    _desc.font = [UIFont systemFontOfSize:10];
    _desc.numberOfLines = 3;
    _desc.text = @"111111111adsfasdf ads ";
    [self.contentView addSubview:_desc];
    
    self.hiddenTitle = [[UILabel alloc]init];
    _hiddenTitle.frame = CGRectMake(230, 5, 80, 45);
    _hiddenTitle.font = [UIFont boldSystemFontOfSize:18];
    _hiddenTitle.textAlignment = NSTextAlignmentCenter;
    _hiddenTitle.alpha = 0;
    [self.contentView addSubview:_hiddenTitle];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}


-(void)layoutSubviews{
    [super layoutSubviews];
    if ([[NSUserDefaults standardUserDefaults]boolForKey:kisshowSecondView]) {
        [UIView animateWithDuration:.4 animations:^{
//            if(self.selected){
//                _hiddenTitle.textColor = [UIColor redColor];
//            }else{
                _hiddenTitle.textColor = COLOR(109, 108, 106);
//            }
            _hiddenTitle.alpha = 1;
        }];
    }else{
        [UIView animateWithDuration:.4 animations:^{
            _hiddenTitle.alpha = 0;
        }];
    }

    
}
@end
