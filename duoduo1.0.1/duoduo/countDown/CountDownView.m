//
//  countDownView.m
//  countdownTest
//
//  Created by tenyea on 14-4-12.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "CountDownView.h"

@implementation CountDownView

- (id)initWithFrame:(CGRect)frame withEndDate:(NSString *)endDate
{
    self = [super initWithFrame:frame];
    if (self) {
        _endDate = endDate;
//        NSLog(@"%@",timeString);
        [self _initView];
        [self intervalSinceNow];
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(intervalSinceNow) userInfo:nil repeats:YES];
    }
    return self;
}
-(void)_initView{
    HHLabel = [[UILabel alloc]init];
    mmlabel = [[UILabel alloc]init];
    ssLaebl  = [[UILabel alloc]init];
    NSArray *labelArr = @[HHLabel,mmlabel,ssLaebl];
    self.backgroundColor = [UIColor whiteColor];
    float site_width = (self.frame.size.width-30)/3;
    for (int i = 0 ; i < 3 ; i ++) {
        UIImageView *bgimageView = [[UIImageView alloc]initWithFrame:CGRectMake(5+i *(site_width+10) , 5, site_width, self.frame.size.height -10)];
        [bgimageView setImage:[UIImage imageNamed: @"home_countDown_bg.png"]];
        [self addSubview:bgimageView];
        
//        添加laebl
        UILabel *label = labelArr[i] ;
        label.frame =CGRectMake(0, 0, bgimageView.frame.size.width, bgimageView.frame.size.height);
        label.font = [UIFont boldSystemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
//        label.text = @"12";
        [bgimageView addSubview:label];
//        冒号
        if (i >0) {
            UILabel *colonLabel = [[UILabel alloc]initWithFrame:CGRectMake(5+i *(site_width+10)-8, self.frame.size.height/2-12, 6, 10)];
            colonLabel.backgroundColor = [UIColor clearColor];
            colonLabel.font = [UIFont boldSystemFontOfSize:18];
            colonLabel.text = @":";
            colonLabel.textAlignment = NSTextAlignmentCenter;
            colonLabel.textColor = COLOR(162, 129, 184);
            [colonLabel sizeToFit];
            [self addSubview:colonLabel];
        }
    }
}


-(NSDate *)StringTODate :(NSString *)strDate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:strDate];
    return date;
}

- (void)intervalSinceNow
{
    NSDate *endD = [self StringTODate:_endDate];
    NSTimeInterval timeInterval = [endD timeIntervalSinceNow];
    
    if (timeInterval<0) {
        HHLabel.text = @"00";
        mmlabel.text = @"00";
        ssLaebl.text = @"00";
        return;
    }
    NSInteger time = (NSInteger)timeInterval;

    NSInteger hour = time/3600;
    NSInteger minute = (time%3600)/60;
    NSInteger second = (time%3600)%60;
    
    if (hour > 0) {
        if (hour> 99) {
            HHLabel.text = @"99";
            mmlabel.text = @"00";
            ssLaebl.text = @"00";
            return;
        }else{
            HHLabel.text = [NSString stringWithFormat:@"%d%d",hour/10, hour%10];
            mmlabel.text = [NSString stringWithFormat:@"%d%d",minute/10, minute%10];
            ssLaebl.text = [NSString stringWithFormat:@"%d%d",second/10, second %10];
            return;
        }
    } else {
        
        HHLabel.text = @"00";
        mmlabel.text = [NSString stringWithFormat:@"%d%d",minute/10, minute%10];
        ssLaebl.text = [NSString stringWithFormat:@"%d%d",second/10, second %10];
        return;
    }
    
}


@end
