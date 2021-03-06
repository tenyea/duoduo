//
//  CategoryTableView.m
//  duoduo
//
//  Created by tenyea on 14-4-17.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "CategoryTableView.h"
#import "CourseModel.h"
#import "UIImageView+WebCache.h"
@implementation CategoryTableView

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame isMore:YES refreshHeader:NO]) {

    }
    return self;
}


#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell ;

    if (!cell) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell = [[[NSBundle mainBundle]loadNibNamed:@"CategoryCell" owner:self options:nil]lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CourseModel *model = self.dataArray[indexPath.row];
    UIImageView *image = (UIImageView *)VIEWWITHTAG(cell.contentView, 100);
    [image setImageWithURL:[NSURL URLWithString: model.course_images]];
    
    UILabel *title = (UILabel *)VIEWWITHTAG(cell.contentView, 101);
    title.text = model.courseName ;
    UILabel *desc = (UILabel *)VIEWWITHTAG(cell.contentView, 102);
    desc.text =  model.Description;
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
#pragma mark UITableViewDelegate

@end
