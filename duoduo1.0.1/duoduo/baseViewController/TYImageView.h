//
//  TYImageView.h
//  duoduo
//
//  Created by tenyea on 14-3-28.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ImageBlock)(void);
@interface TYImageView : UIImageView

@property (nonatomic,copy)ImageBlock touchBlock;
@end
