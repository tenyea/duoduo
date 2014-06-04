//
//  BuyCarCell.m
//  duoduo
//
//  Created by tenyea on 14-4-23.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "BuyCarCell.h"
#import "UIImageView+WebCache.h"
#import "BuyCarModel.h"
#import "AFHTTPRequestOperationManager.h"
#import "TenyeaBaseViewController.h"
#define selectedServlet @"selected"
#define changeValueServlet @""
#define params_count @""
#define params_totalPrices @""
#define params_modelcount @""

#define request_params_userId @""
#define request_params_Device @""
#define request_params_CourseId @""
#define request_params_operation @""
#import "OpenUDID.h"
@implementation BuyCarCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [self.selectButton setImage:[UIImage imageNamed:@"car_select_cell.png"] forState:UIControlStateSelected];
    [self.selectButton setImage:[UIImage imageNamed:@"car_deselect_cell.png"] forState:UIControlStateNormal];
}



 - (IBAction)valueChangeAction:(UIButton *)sender {
//     值为0时， 不能减少
     if (sender.tag == 100 &&[_model.count intValue] == 0) {
         return;
     }
     
     TenyeaBaseViewController *VC = (TenyeaBaseViewController *)self.viewController;
     [VC showHUDwithLabel:nil inView:self.viewController.view];
//     参数
     NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
     [params setValue:[OpenUDID value] forKey:request_params_Device];
     [params setValue:[[[NSUserDefaults standardUserDefaults] objectForKey:kuserDIC] objectForKey:kuserDIC_userMemberId]forKey:request_params_userId];
     if (sender.tag == 100) {//减少
         [params setValue:[NSNumber numberWithInt:0] forKey:request_params_operation];
     }else {//增加
         [params setValue:[NSNumber numberWithInt:1] forKey:request_params_operation];
     }
     [params setValue:_model.courseId forKey:request_params_CourseId];
     
     [self getDate:changeValueServlet andParams:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
         if ([[responseObject objectForKey:@"code"] intValue ] == 0) {
             
         }
         int total = [[responseObject objectForKey:params_totalPrices] intValue];
         int count = [[responseObject objectForKey:params_count] intValue];
         BuyCarModel *model = _model;
         model.count = [responseObject objectForKey:params_modelcount];
         self.model = model;
         if ([self.changeDelegate respondsToSelector:@selector(valueChange:index:totalPrices:count:)]){
             [self.changeDelegate valueChange:model index:_index totalPrices:total count:count];
         }
         [VC removeHUD];
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         [VC removeHUD];
         [VC showHUDinView:[error localizedDescription ]];
         [VC performSelector:@selector(removeHUD) withObject:nil afterDelay:1];
     }];
}
- (IBAction)selectedAction:(id)sender {
    _selectButton.enabled = NO;
    TenyeaBaseViewController *VC = (TenyeaBaseViewController *)self.viewController;
    [VC showHUDwithLabel:nil inView:self.viewController.view];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:[OpenUDID value] forKey:request_params_Device];
    [params setValue:[[[NSUserDefaults standardUserDefaults] objectForKey:kuserDIC] objectForKey:kuserDIC_userMemberId]forKey:request_params_userId];
    [params setValue:_model.courseId forKey:request_params_CourseId];
    [self getDate:selectedServlet andParams:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([[responseObject objectForKey:@"code"] intValue ] == 0) {
            int total = [[responseObject objectForKey:params_totalPrices] intValue];
            int count = [[responseObject objectForKey:params_count] intValue];
            BuyCarModel *model = _model;
            if ([_model.isselected intValue]==0) {
                model.isselected = [NSNumber numberWithInt:1];
            }else{
                model.isselected = [NSNumber numberWithInt:0];
            }
            self.model = model;
            if ([self.changeDelegate respondsToSelector:@selector(valueChange:index:totalPrices:count:)]){
                [self.changeDelegate valueChange:model index:_index totalPrices:total count:count];
            }
        }
        _selectButton.enabled = YES;
        [VC removeHUD];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _selectButton.enabled = YES;
        [VC removeHUD];
        [VC showHUDinView:[error localizedDescription ]];
        [VC performSelector:@selector(removeHUD) withObject:nil afterDelay:1];
    }];
    
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.imageView setImageWithURL:[NSURL URLWithString:_model.imageURL] placeholderImage:LogoImage_60x50];
    [self.title setText:_model.title];
    self.number.text = _model.courseId;
    self.priceLabel.text = [NSString stringWithFormat:@"%@",_model.price];
    if ([_model.isselected intValue]==1) {
        self.selectButton.selected = YES;
    }else{
        self.selectButton.selected = NO;
    }
    self.countLabel.text = [NSString stringWithFormat:@"%@",_model.count];
    [self setNeedsDisplay];
    
}


-(void)getDate: (NSString *)url andParams:(NSDictionary *)param  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    
    NSString *baseurl = [BASE_URL stringByAppendingPathComponent:url];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = duoduo_timeout;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
        [manager GET:baseurl parameters:param success:success failure:failure ];
}


@end
