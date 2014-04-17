//
//  LoginViewController.h
//  duoduo
//
//  Created by pc on 14-4-17.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "TenyeaBaseViewController.h"

@interface LoginViewController : TenyeaBaseViewController
- (IBAction)btnForget:(id)sender;
- (IBAction)btnLogin:(id)sender;
- (IBAction)btnRegistered:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnRegistered;
@property (strong, nonatomic) IBOutlet UIButton *btnLogin;
@property (strong, nonatomic) IBOutlet UIButton *btnForget;
@property (strong, nonatomic) IBOutlet UITextField *txtUser;

@property (strong, nonatomic) IBOutlet UIView *loginView;

@end
