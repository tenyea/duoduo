//
//  MyCourseViewController.m
//  duoduo
//
//  Created by tenyea on 14-4-19.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "MyCourseViewController.h"
#import "MyCoursesCell.h"
#import "UIImageView+WebCache.h"
@interface MyCourseViewController ()

@end

@implementation MyCourseViewController
{
    NSString *userMemberId;
    NSMutableArray *myCourseArray;
    NSDictionary *dic;
    UIImage *image;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"我的课程";
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userDic = [userDefaults dictionaryForKey:kuserDIC];
    userMemberId=[userDic objectForKey:String_userMemberId] ;
    
    NSMutableDictionary *userDIC=[[NSMutableDictionary alloc]init];
    [userDIC setValue:userMemberId forKey:@"userMemberId"];
    
    [self getDate:URL_myCourse andParams:userDIC andcachePolicy:1 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *code =[responseObject objectForKey:@"code"];
        NSLog(@"%@",code);
       
        int a = [code intValue];
        if(a==0)
        {
            myCourseArray=[responseObject objectForKey:@"myCourse"];
            
        }
        else if (a==1001)
        {
            NSLog(@"参数缺失，没登录？注册？");
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,320 , 480) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
   
}
// 设置一个表单中有多少分组(非正式协议如果不实现该方法则默认只有一个分组)
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// 设置一个分组中有多少行(必须实现的正式协议)
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [myCourseArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"cell";
    // 声明cell并去复用池中找是否有对应标签的闲置cell
    MyCoursesCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    // 如果没找到可复用的cell
    if(cell == nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MyCoursesCell" owner:self options:nil]lastObject];

    }

    dic=[myCourseArray objectAtIndex:indexPath.row];
    cell.titleLabel.text=[dic objectForKey:@"courseName"];
    cell.describeLabel.text=[dic objectForKey:@"description"];
    
    UIImageView *igv=[[UIImageView alloc]init];
    [igv setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"course_images"]]];
    cell.courseImage=igv;
    return cell;
}
- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 76.0;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
