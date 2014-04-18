//
//  CourseModel.h
//  duoduo
//
//  Created by tenyea on 14-4-17.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "BaseModel.h"

@interface CourseModel : BaseModel

@property (nonatomic,retain)NSString *course_id	;//	课程（主键id）
@property (nonatomic,retain)NSString *courseName;	//String	课程名称
@property (nonatomic,retain)NSString *course_images;//	String	课程图片
@property (nonatomic,retain)NSString *course_price;//	Float	课程售价（打折后）
@property (nonatomic,retain)NSString *course_price_discount;//	Float	课程折扣
@property (nonatomic,retain)NSString *course_sell_price	;//Float	课程原价
@property (nonatomic,retain)NSString *Description;//	String	课程描述
@end
