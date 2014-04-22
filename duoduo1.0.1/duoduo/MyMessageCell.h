//
//  MyMessageCell.h
//  duoduo
//
//  Created by tenyea on 14-4-21.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyMessageCell : UITableViewCell{
    

}
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *content;
@property (strong, nonatomic) IBOutlet UILabel *pushTime;

@end
