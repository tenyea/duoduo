//
//  RegisteredViewController.h
//  duoduo
//
//  Created by pc on 14-4-18.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "TenyeaBaseViewController.h"

@interface RegisteredViewController : TenyeaBaseViewController<UITextFieldDelegate,UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIButton *btnRegistered;
- (IBAction)registeredAction:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *passwordTF;
@property (strong, nonatomic) IBOutlet UITextField *passwordAgainTF;
@property (strong, nonatomic) IBOutlet UITextField *userNameTF;
@property (strong, nonatomic) IBOutlet UITextField *emailTF;
@property (strong, nonatomic) IBOutlet UITextField *phoneTF;
@property (strong, nonatomic) IBOutlet UIView *backgroundView;
@property (strong, nonatomic) IBOutlet UIButton *btnAgree;
- (IBAction)btnAgreeAction:(id)sender;

@end
