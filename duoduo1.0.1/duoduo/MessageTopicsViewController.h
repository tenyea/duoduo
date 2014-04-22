//
//  MessageTopicsViewController.h
//  duoduo
//
//  Created by tenyea on 14-4-22.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "TenyeaBaseViewController.h"

@interface MessageTopicsViewController : TenyeaBaseViewController
@property (nonatomic , assign) int Template;
@property (nonatomic , retain) NSString *topicsId;
-(id) initWithTopicsId:(NSString *)topicsId template :(int )Template;
@end
