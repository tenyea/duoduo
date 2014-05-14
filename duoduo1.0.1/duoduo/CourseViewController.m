//
//  CourseViewController.m
//  duoduo
//
//  Created by tenyea on 14-4-11.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "CourseViewController.h"

@interface CourseViewController ()

@end

@implementation CourseViewController

-(id)initWithCourseID:(NSString *)CourseId{
    self = [super init];
    if (self) {
      //  self.view.backgroundColor = [UIColor whiteColor];
        self.CourseID = CourseId;
    }
    return  self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UITableView *tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480) style:UITableViewStylePlain];
    tableView.delegate=self;
    tableView.dataSource=self;
    [self.view addSubview:tableView];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==1||section==2) {
        return 2;
    }else
    {
        return 1;
    }

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"cell";
    // 声明cell并去复用池中找是否有对应标签的闲置cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    // 如果没找到可复用的cell
    if(cell == nil)
    {
        // 实例化新的cell并且加上标签
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellName];
    }
    if (indexPath.section==0) {
        UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 160)];
         scrollView.contentSize = CGSizeMake(960 , 160);
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        
        [self.view addSubview:scrollView];
    }



    return cell;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 160;
    }else
        
    return 80.0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
