//
//  MoreViewController.m
//  duoduo
//
//  Created by tenyea on 14-4-28.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()

@end
#define tablecellHeigh 50
@implementation MoreViewController
{
    NSArray *moreBtnImage;
    NSArray *moreBtnTitle;

}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=@"更多";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    moreBtnImage=[[NSArray alloc]init];
    moreBtnImage=@[@"set",@"help",@"feedback",@"update",@"push",@"about" ];
    moreBtnTitle=@[@"设置",@"帮助",@"意见反馈",@"检查更新",@"消息推送",@"关于"];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480) style:UITableViewStylePlain];
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
    return [moreBtnTitle count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"cell";
    // 声明cell并去复用池中找是否有对应标签的闲置cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    // 如果没找到可复用的cell
    if(cell == nil)
    {
        // 实例化新的cell并且加上标签
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellName] ;
        UIImageView *dottedLine=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"more_dotted_line.png"]];
        dottedLine.frame=CGRectMake(25, 47, 270, 3);
        [cell addSubview:dottedLine];
        UIImageView *pen=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"more_pen.png"]];
        pen.frame=CGRectMake(295, 38, 10, 10);
        [cell addSubview:pen];
        for(int i=0;i<[moreBtnTitle count];i++)
        {
            if(indexPath.row==i)
            {
                
                UIImage *image=[UIImage imageNamed:[NSString stringWithFormat:@"more_%@.png",[moreBtnImage objectAtIndex:indexPath.row]]];
                UIImageView *igv=[[UIImageView alloc]initWithImage:image];
                igv.frame=CGRectMake(35, 15, 20, 20);
                [cell addSubview:igv];
                UILabel *label=[[UILabel alloc]init];
                label.text=[moreBtnTitle objectAtIndex:indexPath.row];
                label.frame=CGRectMake(65, 10, 200, 30);
                [cell addSubview:label];
                
            }
            
        }
        

    }
   
    
    
    // 设置cell被选中样式
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // 取消tableview的row的横线
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    //}
    // 显示
    return cell;
}
// 设置行高(默认为44px)
- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tablecellHeigh;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
