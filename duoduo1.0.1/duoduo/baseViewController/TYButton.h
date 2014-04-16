//
//  TYButton.h
//  duoduo
//
//  Created by tenyea on 14-3-28.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TYButton;
typedef void(^TouchBlock)(TYButton *);
@interface TYButton : UIButton
@property (nonatomic,copy)TouchBlock touchBlock;

@end
