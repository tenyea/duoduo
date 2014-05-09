//
//  LoginView.h
//  duoduo
//
//  Created by tenyea on 14-5-4.
//  Copyright (c) 2014年 zzw. All rights reserved.
//
@protocol LoginDelegate <NSObject>
-(void)loginSuccess:(NSDictionary *)dic;
@end
#import <UIKit/UIKit.h>
@interface LoginView : UIView<UITextFieldDelegate>{
    UILabel *hudLabel;
}
- (IBAction)btnForget:(id)sender;
- (IBAction)btnLogin:(id)sender;
- (IBAction)btnRegistered:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnRegistered;
@property (strong, nonatomic) IBOutlet UIButton *btnLogin;
@property (strong, nonatomic) IBOutlet UIButton *btnForget;

@property (strong, nonatomic) IBOutlet UIView *loginView;
@property (strong, nonatomic) IBOutlet UITextField *passwordTF;
@property (strong, nonatomic) IBOutlet UITextField *userNameTF;
@property (nonatomic , assign) id<LoginDelegate> loginDelegate;
@property (strong, nonatomic) IBOutlet UIView *loginViewLine;

@end
