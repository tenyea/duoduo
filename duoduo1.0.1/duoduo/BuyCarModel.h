//
//  BuyCarModel.h
//  duoduo
//
//  Created by tenyea on 14-5-10.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "BaseModel.h"

@interface BuyCarModel : BaseModel

//(id INTEGER PRIMARY KEY,title TEXT,courseID TEXT,price Integer,isselected Integer,addDate TEXT)
@property (nonatomic,retain) NSNumber *ID;
@property (nonatomic,retain) NSString *title;
@property (nonatomic,retain) NSString *courseId;
@property (nonatomic,retain) NSNumber *price;
@property (nonatomic,copy) NSNumber *isselected;
@property (nonatomic,retain) NSString *addDate;
@property (nonatomic,retain) NSString *imageURL;
@property (nonatomic,copy) NSNumber *count;
@end
