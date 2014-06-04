//
//  BuyCarCell.h
//  duoduo
//
//  Created by tenyea on 14-4-23.
//  Copyright (c) 2014年 zzw. All rights reserved.
//
@class BuyCarModel;
@protocol changeValueDelegate <NSObject>

//-(void)selectedStateChange:(BuyCarModel *)model index:(int)index totalPrices:(int)totalPrices count:(int)count;
//-(void)addCountChange:(BuyCarModel *)model index:(int)index totalPrices:(int)totalPrices count:(int)count;
//-(void)subCountChange:(BuyCarModel *)model index:(int)index totalPrices:(int)totalPrices count:(int)count;
-(void)valueChange:(BuyCarModel *)model index:(int)index totalPrices:(int)totalPrices count:(int)count;
@end

#import <UIKit/UIKit.h>
@class BuyCarModel;
@interface BuyCarCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *number;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UIButton *selectButton;
@property (strong, nonatomic) IBOutlet UILabel *countLabel;
@property (nonatomic ,retain) BuyCarModel *model ;

- (IBAction)selectedAction:(id)sender;
- (IBAction)valueChangeAction:(id)sender;


@property (nonatomic,assign) id<changeValueDelegate> changeDelegate;
@property (nonatomic, assign) int index ;
@end
