//
//  HelpViewController.m
//  BLEDemo
//
//  Created by chensen on 16/9/27.
//  Copyright © 2016年 阿森纳. All rights reserved.
//

#import "HelpViewController.h"
#import "CommonFunction.h"
#import "BasicIntroductionViewController.h"
#import "AboutUsViewController.h"

@interface HelpViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_tableView;
    NSArray *_cellImage;       // 图标
    NSArray *_cellTitle;       // 标题
}

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"帮助中心";
    self.view.backgroundColor = bg_color;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - STATUS_AND_NAV_BAR_HEIGHT - TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_tableView setShowsVerticalScrollIndicator:NO];        // 不显示纵向滚动条
    [_tableView setBackgroundColor:[UIColor clearColor]];
    [_tableView setBackgroundView:nil];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    [self.view addSubview:_tableView];
    
    // cell图标
    _cellImage = [NSArray arrayWithObjects:@" ",
                  @"help_basic_introduct",
                  @" ",
                  @"help_about_us", nil];
    
    _cellTitle = [NSArray arrayWithObjects:@" ",
                  @"基本介绍",
                  @" ",
                  @"关于我们", nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableViewDelegate
// 告诉tableView一共有多少组数据
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// 当前组内有多少行数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

// 动态获得cell的高度(每行高)
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 || indexPath.row == 2)
    {
        return 5;
    }
    else
    {
        return 50;
    }
}

// 每一行显示什么内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"myListCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
        cell.imageView.image = NULL;
        cell.textLabel.text = NULL;
        cell.textLabel.textColor = dark_gray_color;
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.detailTextLabel.text = NULL;
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;         // cell样式
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;   // cell中小图标
        
        UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(38, 0, _tableView.frame.size.width - 38, 42)];
        [myLabel setBackgroundColor:[UIColor clearColor]];
        [myLabel setTextColor:dark_gray_color];
        [myLabel setFont:[UIFont systemFontOfSize:13]];
        [myLabel setTextAlignment:NSTextAlignmentLeft];
        [myLabel setAdjustsFontSizeToFitWidth:YES];      // 控制文本基线的行为
        [myLabel setTag:CELL_SUBVIEW_TAG + 1];
        [cell addSubview:myLabel];
    }
    
    UILabel *myLabel = (UILabel *)[cell viewWithTag:CELL_SUBVIEW_TAG + 1];
    [myLabel setText:[_cellTitle objectAtIndex:indexPath.row]];
    
    if (indexPath.row == 0 || indexPath.row == 2)
    {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;     // cell选中后的颜色
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.accessoryView = nil;
        cell.backgroundColor = [UIColor clearColor];
    }
    if (indexPath.row == 1)
    {
        cell.imageView.image = [UIImage imageNamed:@"help_basic_introduct"];
    }
    if (indexPath.row == 3)
    {
        cell.imageView.image = [UIImage imageNamed:@"help_about_us"];
    }
    return cell;
}

// 点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];  // 选中后的反显颜色即刻消失
    
    if (indexPath.row == 1)
    {
        BasicIntroductionViewController *basicIntroductionVC = [[BasicIntroductionViewController alloc] init];
        [self.navigationController pushViewController:basicIntroductionVC animated:YES];
    }
    if (indexPath.row == 3)
    {
        AboutUsViewController *aboutUsVC = [[AboutUsViewController alloc] init];
        [self.navigationController pushViewController:aboutUsVC animated:YES];
    }
}

@end
