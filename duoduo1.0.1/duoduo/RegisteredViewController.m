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
#define agreeBtnRules @"请同意用户协议"
#define parametersLost @"请输入完整信息"
#define wrongInformation @"用户名或密码错误"
#define usernamEexisting @"用户名已经注册"
#define emailEexisting @"邮箱已经注册"
@interface RegisteredViewController ()
{
    UIScrollView *scrollView;
    BOOL isZoom;
    NSString *registeredMessage;
    
}
@end

@implementation RegisteredViewController
@synthesize btnRegistered;
@synthesize passwordTF,passwordAgainTF;
@synthesize userNameTF,emailTF,phoneTF;
@synthesize backgroundView;
@synthesize btnAgree;
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
    [userNameTF becomeFirstResponder];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
// 导航条 返回按钮
    UIBarButtonItem *editBBI = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"shake_exit1.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(bbiClick)];
    self.navigationItem.leftBarButtonItem = editBBI;
    editBBI.tintColor=[UIColor whiteColor];
// 同意按钮状态值
    isZoom=NO;
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

}
// 键盘下一步，返回操作
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField.tag==90001)
    {
        [passwordTF becomeFirstResponder];
    }else if (textField.tag==90002)
    {
        [scrollView setContentOffset:CGPointMake(0  , 50) animated:YES];
        [passwordAgainTF becomeFirstResponder];
    }else if (textField.tag==90003)
    {
        [scrollView setContentOffset:CGPointMake(0  , 100) animated:YES];
        [emailTF becomeFirstResponder];
    }else if(textField.tag==90004)
    {   [scrollView setContentOffset:CGPointMake(0  , 150) animated:YES];
        [phoneTF becomeFirstResponder];
    }else if(textField.tag==90005)
    {
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
    NSString *userMemberId = [result objectForKey:String_userMemberId];
    NSString *userName = [result objectForKey:String_userName];
    NSString *scores = [result objectForKey:String_scores];
    NSString *head = [result objectForKey:String_head];
    NSString *coin = [result objectForKey:String_coin];
    NSString *collectCourseId =[result objectForKey:String_collectCourseId];
    NSString *selectCourseId = [result objectForKey:String_selectCourseId];
    NSString *signTotal = [result objectForKey:String_signTotal];
    NSString *memberTypeId = [result objectForKey:String_memberTypeId];
    NSLog(@"userMemberId = %@",userMemberId);
    NSLog(@"userName = %@",userName);
    NSLog(@"scores = %@",scores);
    NSLog(@"head = %@",head);
    NSLog(@"coin = %@",coin);
    NSLog(@"collectCourseId = %@",collectCourseId);
    NSLog(@"selectCourseId = %@",selectCourseId);
    NSLog(@"signTotal = %@",signTotal);
    NSLog(@"memberTypeId = %@",memberTypeId);
    
    //存入 NSUserDefaults
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *userDIC= [[NSMutableDictionary alloc]init];
    [userDIC setObject:userMemberId forKey:String_userMemberId];
    [userDIC setObject:passwordTF.text forKey:@"password"];
    [userDIC setObject:userName forKey:String_userName];
    [userDIC setObject:scores forKey:String_scores];
    [userDIC setObject:head forKey:String_head];
    [userDIC setObject:coin forKey:String_coin];
    [userDIC setObject:collectCourseId forKey:String_collectCourseId];
    [userDIC setObject:selectCourseId forKey:String_selectCourseId];
    [userDIC setObject:signTotal forKey:String_signTotal];
    [userDIC setObject:memberTypeId forKey:String_memberTypeId];
    [userDefaults setObject:userName forKey:String_userName];
    [userDefaults setObject:userDIC forKey:kuserDIC];
    [userDefaults synchronize];
}
// 注册成功取消HUD,跳转界面
-(void)timerFiredSuccess:(NSTimer *)timer{
    [self removeHUD];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
// 注册失败取消HUD
-(void)timerFiredFailure:(NSTimer *)timer{
    
    [self removeHUD];
}
// 点击空白处  收起键盘

#pragma mark btnAction
// 注册按钮点击事件
- (IBAction)registeredAction:(id)sender {
    NSTimer *connectionTimer;
    if(userNameTF.text.length<4||userNameTF.text.length>10)
    {

        registeredMessage=userNameRules;
        [self showHUDinView:registeredMessage];
        connectionTimer=[NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(timerFiredFailure:) userInfo:nil repeats:NO];
    }
    else if (passwordTF.text.length<6||passwordTF.text.length>16)
    {
        registeredMessage=passwordRules;
        [self showHUDinView:registeredMessage];
        connectionTimer=[NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(timerFiredFailure:) userInfo:nil repeats:NO];
    }
   else if (![passwordTF.text isEqualToString:passwordAgainTF.text])
    {
        registeredMessage =passwordAgainRules;
        [self showHUDinView:registeredMessage];
        
        connectionTimer=[NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(timerFiredFailure:) userInfo:nil repeats:NO];
        NSLog(@"确认密码不正确");
    }
    else if(![self validateEmail:emailTF.text])
    {
        registeredMessage =emailRules;
        [self showHUDinView:registeredMessage];
        
        connectionTimer=[NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(timerFiredFailure:) userInfo:nil repeats:NO];
        NSLog(@"邮箱不合法");
    }
    else if (![self isMobileNumber:phoneTF.text]) {
        registeredMessage =phoneRules;
        [self showHUDinView:registeredMessage];
        connectionTimer=[NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(timerFiredFailure:) userInfo:nil repeats:NO];
        NSLog(@"电话不合法");
    }
    else if(!isZoom)
    {
        registeredMessage =agreeBtnRules;
        [self showHUDinView:registeredMessage];
    
        connectionTimer=[NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(timerFiredFailure:) userInfo:nil repeats:NO];
        NSLog(@"请同意用户协议");
    }
    else
    {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setValue:userNameTF.text forKey:@"username"];
        [dic setValue:passwordTF.text forKey:@"password"];
        [dic setValue:emailTF.text forKey:@"email"];
        [dic setValue:phoneTF.text forKey:@"phone"];
        [self getDate:URL_RegisterServlet andParams:dic andcachePolicy:1 success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSString *code = [responseObject objectForKey:@"code"];
            NSLog(@"code = %@",code);
            [self showResult:responseObject];
            int a = [code intValue];
            if(a==0)
            {
                [self showHUDinView:@"注册成功"];
                //Timer的使用：
                NSTimer *connectionTimer;  //timer对象
                //实例化timer
                connectionTimer=[NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(timerFiredSuccess:) userInfo:nil repeats:NO];
            }else if(a==1001)
            {
                registeredMessage =parametersLost;
                NSLog(@"请输入完整信息");
                [self showHUDinView:registeredMessage];
                NSTimer *connectionTimer;  //timer对象
                connectionTimer=[NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(timerFiredFailure:) userInfo:nil repeats:NO];
            }else if(a==1002)
            {
                registeredMessage =wrongInformation;
                NSLog(@"用户名或密码错误");
                [self showHUDinView:registeredMessage];
                NSTimer *connectionTimer;  //timer对象
                connectionTimer=[NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(timerFiredFailure:) userInfo:nil repeats:NO];
            }else if(a==1003)
            {
                registeredMessage =usernamEexisting;
                NSLog(@"用户名已经注册");
                [self showHUDinView:registeredMessage];
                NSTimer *connectionTimer;  //timer对象
                connectionTimer=[NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(timerFiredFailure:) userInfo:nil repeats:NO];
            }else if(a==1004)
            {
                registeredMessage =emailEexisting;
                NSLog(@"邮箱已经注册");
                [self showHUDinView:registeredMessage];
                NSTimer *connectionTimer;  //timer对象
                connectionTimer=[NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(timerFiredFailure:) userInfo:nil repeats:NO];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [error localizedFailureReason];
            _po([error localizedDescription]);
        }];
    }
    
    
}

// 返回按钮  点击事件
-(void)bbiClick
{
    [self.navigationController popViewControllerAnimated:YES];
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
    if(isZoom)
    {
       [btnAgree setImage:[UIImage imageNamed:@"check_box.png"] forState:UIControlStateNormal];
        isZoom=!isZoom;
    
    }else
    {
       [btnAgree setImage:[UIImage imageNamed:@"check_box_select.png"] forState:UIControlStateNormal];
        isZoom=!isZoom;
    }
}
@end
