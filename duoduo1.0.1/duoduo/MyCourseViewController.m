//
//  MyCourseViewController.m
//  duoduo
//
//  Created by tenyea on 14-4-19.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "MyCourseViewController.h"
#import "MyCoursesCell.h"
@interface MyCourseViewController ()

@end

@implementation MyCourseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"我的课程";
    }
    return self;
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
    return 2;
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
    cell.titleLabel.text=@"123";
    cell.describeLabel.text=@"2afdfsdfsadfsd342afdfsdfsadfsd342afdfsdfsadfsd342afdfsdfsadfsd342afdfsdfsadfsd342afdfsdfsadfsd342afdfsdfsadfsd342afdfsdfsadfsd342afdfsdfsadfsd342afdfsdfsadfsd342afdfsdfsadfsd342afdfsdfsadfsd342afdfsdfsadfsd342afdfsdfsadfsd342afdfsdfsadfsd342afdfsdfsadfsd342afdfsdfsadfsd34";
    UIImage *image=[UIImage imageNamed:@"home_top_focus.png"];
    cell.courseImage.image=image;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
