//
//  LoginViewController.h
//  duoduo
//
//  Created by pc on 14-4-17.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "TenyeaNoneNaviVC.h"
#import "AFNetworking.h"

@interface LoginViewController : TenyeaNoneNaviVC<UITextFieldDelegate>
{
    UILabel *hudLabel;
}

>>>>>>> FETCH_HEAD
- (IBAction)btnForget:(id)sender;
- (IBAction)btnLogin:(id)sender;
- (IBAction)btnRegistered:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnRegistered;
@property (strong, nonatomic) IBOutlet UIButton *btnLogin;
@property (strong, nonatomic) IBOutlet UIButton *btnForget;
@property (strong, nonatomic) IBOutlet UITextField *txtUser;

@property (strong, nonatomic) IBOutlet UIView *loginView;
@property (strong, nonatomic) IBOutlet UITextField *passwordTF;
@property (strong, nonatomic) IBOutlet UITextField *userNameTF;
@property (strong, nonatomic) IBOutlet UIView *loginBackgroundView;
@property (strong, nonatomic) IBOutlet UIView *loginViewLine;

@end
