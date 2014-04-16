//
//  countDownView.h
//  countdownTest
//
//  Created by tenyea on 14-4-12.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountDownView : UIView
{
    UILabel *HHLabel;
    UILabel *mmlabel;
    UILabel *ssLaebl;
    NSString *_endDate;
}

- (id)initWithFrame:(CGRect)frame withEndDate:(NSString *)endDate;
@end
