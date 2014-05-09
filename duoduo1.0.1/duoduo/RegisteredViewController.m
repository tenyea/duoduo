//
//  RegisteredViewController.m
//  duoduo
//
//  Created by pc on 14-4-18.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "RegisteredViewController.h"
#define userNameRules @"用户名长度为4-10"
#define passwordRules @"密码长度为6-16"
#define passwordAgainRules @"确认密码不正确"
#define emailRules @"邮箱不符合规范"
#define phoneRules @"电话不符合规范"
#define parametersLost @"请输入完整信息"
#define wrongInformation @"用户名或密码错误"
#define usernamEexisting @"用户名已经注册"
#define emailEexisting @"邮箱已经注册"
@interface RegisteredViewController ()
{
    UIScrollView *scrollView;
    NSString *registeredMessage;
    
}
@end

@implementation RegisteredViewController
@synthesize btnRegistered;
@synthesize passwordTF,passwordAgainTF;
@synthesize userNameTF,emailTF,phoneTF;
@synthesize backgroundView;
@synthesize btnAgree;
@synthesize userNameLabel,passwordLabel,passwordAgainLabel,emailLabel,phoneLabel;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    userNameTF.delegate=self;
    passwordTF.delegate=self;
    passwordAgainTF.delegate=self;
    emailTF.delegate=self;
    phoneTF.delegate=self;
    userNameTF.clearButtonMode=UITextFieldViewModeWhileEditing;
    passwordTF.clearButtonMode=UITextFieldViewModeWhileEditing;
    passwordAgainTF.clearButtonMode=UITextFieldViewModeWhileEditing;
    emailTF.clearButtonMode=UITextFieldViewModeWhileEditing;
    phoneTF.clearButtonMode=UITextFieldViewModeWhileEditing;

    [userNameTF becomeFirstResponder];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

// 圆角按钮
    btnRegistered.layer.cornerRadius=5;
    self.title=@"注册";
// 密码，确认密码  密值输入
    passwordTF.secureTextEntry=YES;
    passwordAgainTF.secureTextEntry=YES;
// 背景滚动
    scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0,0,320,480);
    [self.view addSubview:scrollView];
    scrollView.backgroundColor=[UIColor whiteColor];
    [scrollView addSubview:backgroundView];
    scrollView.contentSize = CGSizeMake(backgroundView.width, backgroundView.height);
    // 去掉弹性
//    scrollView.bounces = NO;
    // 去掉横向进度条
//    scrollView.showsHorizontalScrollIndicator = NO;
    // 去掉纵向进度条
//    scrollView.showsVerticalScrollIndicator = NO;
    
    
// 控制器处理点击事件
    UIControl *control = [[UIControl alloc] init];
    control.frame = backgroundView.bounds;
    [control addTarget:self action:@selector(controlClick) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:control];
    [backgroundView sendSubviewToBack:control];
    [btnAgree setImage:[UIImage imageNamed:@"check_box.png"] forState:UIControlStateNormal];
    [btnAgree setImage:[UIImage imageNamed:@"check_box_select.png"] forState:UIControlStateSelected];
    btnRegistered.enabled = NO;
}
// 键盘下一步，返回操作
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField.tag==90001)
    {
        if(userNameTF.text.length<4||userNameTF.text.length>10)
        {
            registeredMessage=userNameRules;
            userNameLabel.text=userNameRules;
        }else
        {
            userNameLabel.text=nil;
        }
        [passwordTF becomeFirstResponder];
    }else if (textField.tag==90002)
    {
        if (passwordTF.text.length<6||passwordTF.text.length>16)
        {
            registeredMessage=passwordRules;
            passwordLabel.text=passwordRules;
        }else
        {
            passwordLabel.text=nil;
        }
        [scrollView setContentOffset:CGPointMake(0  , 50) animated:YES];
        [passwordAgainTF becomeFirstResponder];
    }else if (textField.tag==90003)
    {
        if (![passwordTF.text isEqualToString:passwordAgainTF.text])
        {
            registeredMessage =passwordAgainRules;
            NSLog(@"确认密码不正确");
            passwordAgainLabel.text=passwordAgainRules;
        }else
    {
        passwordAgainLabel.text=nil;
    }

        [scrollView setContentOffset:CGPointMake(0  , 100) animated:YES];
        [emailTF becomeFirstResponder];
    }else if(textField.tag==90004)
    {
        if(![self validateEmail:emailTF.text])
        {
            registeredMessage =emailRules;
            NSLog(@"邮箱不合法");
            emailLabel.text=emailRules;
        }else
        {
            emailLabel.text=nil;
        }
        [scrollView setContentOffset:CGPointMake(0  , 150) animated:YES];
        [phoneTF becomeFirstResponder];
    }else if(textField.tag==90005)
    {
        if (![self isMobileNumber:phoneTF.text]) {
            registeredMessage =phoneRules;
            NSLog(@"电话不合法");
            phoneLabel.text=phoneRules;
        }
        else
        {
            phoneLabel.text=nil;
        }
        [scrollView setContentOffset:CGPointMake(0  , 0) animated:YES];
        [phoneTF resignFirstResponder];
    }
        return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 邮箱格式判断
- (BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:candidate];
}
// 电话格式判断
- (BOOL)isMobileNumber:(NSString *)mobileNum
{
    NSString *MOBILE=@"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString *CM=@"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    NSString *CU=@"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString *CT=@"^1((33|53|8[09])[0-9]|349)\\d{7}$";
   // NSString *PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSPredicate *regextestmobile =[NSPredicate predicateWithFormat:@"SELF MATCHES%@",MOBILE];

    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",CM];
    
    
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",CU];
    
    
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",CT];
 
    if(([regextestmobile evaluateWithObject:mobileNum]==YES)||
         ([regextestcm evaluateWithObject:mobileNum]==YES)||([regextestct evaluateWithObject:mobileNum]==YES)||([regextestcu evaluateWithObject:mobileNum]==YES))
    {
        return
        YES;
    }
    else
    {
        return
        NO;
    }
}
// 解析数据存储在 NSUserDefaults
-(void)showResult:(NSDictionary *)resultobject
{
    //解析数据
    NSDictionary *result =[resultobject objectForKey:@"user"];
    NSString *coin = [result objectForKey:kuserDIC_coin];
    NSString *collectCourseId =[result objectForKey:kuserDIC_collectCourseId];
    NSString *collectCourseTotal = [result objectForKey:kuserDIC_collectCourseTotal];
    NSString *head = [result objectForKey:kuserDIC_head];
    NSString *memberTypeId = [result objectForKey:kuserDIC_memberTypeId];
    NSString *scores = [result objectForKey:kuserDIC_scores];
    NSString *selectCourseId = [result objectForKey:kuserDIC_selectCourseId];
    NSString *selectCourseTotal = [result objectForKey:kuserDIC_selectCourseTotal];
    NSString *userMemberId = [result objectForKey:kuserDIC_userMemberId];
    NSString *userName = [result objectForKey:kuserDIC_userName];
    NSString *signTotal = [result objectForKey:kuserDIC_signTotal];
    
    //存入 NSUserDefaults
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *userDIC= [[NSMutableDictionary alloc]init];
    [userDIC setObject:userMemberId forKey:kuserDIC_userMemberId];
    //    [userDIC setObject:passwordTF.text forKey:@"password"];
    [userDIC setObject:userName forKey:kuserDIC_userName];
    [userDIC setObject:scores forKey:kuserDIC_scores];
    [userDIC setObject:head forKey:kuserDIC_head];
    [userDIC setObject:coin forKey:kuserDIC_coin];
    [userDIC setObject:collectCourseId forKey:kuserDIC_collectCourseId];
    [userDIC setObject:selectCourseId forKey:kuserDIC_selectCourseId];
    [userDIC setObject:signTotal forKey:kuserDIC_signTotal];
    [userDIC setObject:memberTypeId forKey:kuserDIC_memberTypeId];
    [userDIC setObject:collectCourseTotal forKey:kuserDIC_collectCourseTotal];
    [userDIC setObject:selectCourseTotal forKey:kuserDIC_selectCourseTotal];
    [userDefaults setObject:userName forKey:kuserDIC_userName];
    [userDefaults setObject:userDIC forKey:kuserDIC];
    [userDefaults synchronize];
}
// 注册成功取消HUD,跳转界面
-(void)timerFiredSuccess:(NSTimer *)timer{
    [self removeHUD];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    registeredMessage = nil;
    userNameLabel.text=nil;
    passwordLabel.text=nil;
    passwordAgainLabel.text=nil;
    emailLabel.text=nil;
    phoneLabel.text=nil;
    if(textField.tag==90002)
    {
        if(userNameTF.text.length<4||userNameTF.text.length>10)
        {
            registeredMessage=userNameRules;
            userNameLabel.text=userNameRules;
        }else
        {
            userNameLabel.text=nil;
        }
        [passwordTF becomeFirstResponder];
    }else if (textField.tag==90003)
    {
        if (passwordTF.text.length<6||passwordTF.text.length>16)
        {
            registeredMessage=passwordRules;
            passwordLabel.text=passwordRules;
        }else
        {
            passwordLabel.text=nil;
        }
        [scrollView setContentOffset:CGPointMake(0  , 50) animated:YES];
        [passwordAgainTF becomeFirstResponder];
    }else if (textField.tag==90004)
    {
        if (![passwordTF.text isEqualToString:passwordAgainTF.text])
        {
            registeredMessage =passwordAgainRules;
            NSLog(@"确认密码不正确");
            passwordAgainLabel.text=passwordAgainRules;
        }else
        {
            passwordAgainLabel.text=nil;
        }
        
        [scrollView setContentOffset:CGPointMake(0  , 100) animated:YES];
        [emailTF becomeFirstResponder];
    }else if(textField.tag==90005)
    {
        if(![self validateEmail:emailTF.text])
        {
            registeredMessage =emailRules;
            NSLog(@"邮箱不合法");
            emailLabel.text=emailRules;
        }else
        {
            emailLabel.text=nil;
        }
        [scrollView setContentOffset:CGPointMake(0  , 150) animated:YES];
        [phoneTF becomeFirstResponder];
    }
}


#pragma mark btnAction
// 注册按钮点击事件
- (IBAction)registeredAction:(id)sender {
    registeredMessage = nil;
    userNameLabel.text=nil;
    passwordLabel.text=nil;
    passwordAgainLabel.text=nil;
    emailLabel.text=nil;
    phoneLabel.text=nil;
   
    if (![self isMobileNumber:phoneTF.text]) {
        registeredMessage =phoneRules;
        NSLog(@"电话不合法");
        phoneLabel.text=phoneRules;
    }
    else
    {
        phoneLabel.text=nil;
    }
    
    if (!registeredMessage) {
       
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setValue:userNameTF.text forKey:@"username"];
        [dic setValue:passwordTF.text forKey:@"password"];
        [dic setValue:emailTF.text forKey:@"email"];
        [dic setValue:phoneTF.text forKey:@"phone"];
        [self getDate:URL_RegisterServlet andParams:dic andcachePolicy:1 success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSString *code = [responseObject objectForKey:@"code"];
            NSLog(@"code = %@",code);
            
            int a = [code intValue];
            if(a==0)
            {
                [self showResult:responseObject];
                [self showHudInBottom:@"注册成功"];
                [self performSelector:@selector(timerFiredSuccess:) withObject:nil afterDelay:1.5];
                return ;
            }else if(a==1001)
            {
                registeredMessage =parametersLost;
                NSLog(@"请输入完整信息");
                
            }else if(a==1002)
            {
                registeredMessage =wrongInformation;
                NSLog(@"用户名或密码错误");
            }else if(a==1003)
            {
                registeredMessage =usernamEexisting;
                NSLog(@"用户名已经注册");
                userNameLabel.text=usernamEexisting;
            }else if(a==1004)
            {
                registeredMessage =emailEexisting;
                NSLog(@"邮箱已经注册");
                emailLabel.text=emailEexisting;
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [error localizedFailureReason];
            _po([error localizedDescription]);
        }];
    }
}

- (void)controlClick
{
    NSArray *subViews = [backgroundView subviews];
    for(UIView *view in subViews)
    {
        if([view isKindOfClass:[UITextField class]])
        {
            [view resignFirstResponder];
        }
    }
}
// 同意用户协议按钮
- (IBAction)btnAgreeAction:(id)sender {
    btnAgree.selected = !btnAgree.selected;
    btnRegistered.enabled =btnAgree.selected;
}
@end
