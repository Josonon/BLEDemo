//
//  BasicIntroductionViewController.m
//  HomeLock
//
//  Created by chensen on 16/8/29.
//  Copyright © 2016年 阿森纳. All rights reserved.
//

#import "BasicIntroductionViewController.h"
#import "CommonFunction.h"

@interface BasicIntroductionViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_isOpenCellArray;          // 展开的数据
    NSMutableArray *_contentArray;
    
    NSMutableArray<NSNumber *> *_isExpland;    // 这里用到泛型，防止存入非数字类型
    BOOL _isOpen;                              // 是否展开
}

@end

@implementation BasicIntroductionViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _isOpenCellArray = [NSMutableArray array];
        _contentArray = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"基本介绍";
    [self.view setBackgroundColor:bg_color];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - STATUS_AND_NAV_BAR_HEIGHT) style:UITableViewStylePlain];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_tableView setShowsVerticalScrollIndicator:NO];
    [_tableView setBackgroundColor:[UIColor clearColor]];
    [_tableView setBackgroundView:nil];
    [_tableView setDataSource:self];
    [_tableView setDelegate:self];
    [self.view addSubview:_tableView];
    
    // 返回估算告诉,作用:在tablView显示时候,先根据估算高度得到整个tablView高,而不必知道每个cell的高度,从而达到高度方法的懒加载调用
    _tableView.estimatedRowHeight = 44.0f;                        // cell行高
    _tableView.rowHeight = UITableViewAutomaticDimension;         // 告诉tableView的真实高度是自动计算的，根据你的约束来计算
    
    _isExpland = [NSMutableArray array];
    _contentArray = [NSMutableArray arrayWithObjects:@"你我他你我他你我他你我他你我他你我他你我他你我他你我他你我他你我他你我他你我他你我他你我他你我他你我他你我他你我他你我他你我他你我他你我他你我他你我他你我他。",
                     @"Hello world, Hello world, Hello world, Hello world, Hello world, Hello world, Hello world, Hello world, Hello world, ",
                     @"YES Id, YES Id, YES Id, YES Id,Y ES Id", nil];
    
    _isOpenCellArray = [NSMutableArray arrayWithObjects:@"你我他？",
                        @"Hello world？",
                        @"YES Id", nil];
    for (int i = 0; i < _isOpenCellArray.count; i++)
    {
        [_isExpland addObject:@0];
    }
    [_tableView reloadData];
}

#pragma mark - 点击事件
- (void)onActionTouch:(UIButton *)btn
{
    NSInteger section = btn.tag - CELL_SUBVIEW_TAG;
    
    // 记录展开的状态
    _isExpland[section] = [_isExpland[section] isEqual:@0] ? @1:@0;
    
    // 刷新点击的section
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:section];    // 空的索引集合(唯一的、有序的、无符号整数)
    [_tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - UITableView Delegate

// 告诉tableView一共有多少组数据
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _isOpenCellArray.count;
}

// 当前组内有多少行数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_isExpland[section] boolValue])   // 存的是bool值，有几组就存几个
    {
        return 1;
    }
    else
    {
        return 0;
    }
}

// 头部
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIButton *selectBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 42)];
    [selectBtn setBackgroundColor:white_color];
    [selectBtn setTag:CELL_SUBVIEW_TAG + section];
    
    // 判断是否展开 图片选择
    NSString *imgName = [_isExpland[section] boolValue] ? @"btn_up":@"btn_enter";
    UIImage *img = [UIImage imageNamed:imgName];
    UIImageView  *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - img.size.width - 5, img.size.height * 3, img.size.width, img.size.height)];
    [imageView setImage:img];
    [selectBtn addSubview:imageView];
    
    // 标题
    [selectBtn setTitle:[_isOpenCellArray objectAtIndex:section] forState:UIControlStateNormal];
    selectBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    selectBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    selectBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [selectBtn setTitleColor:dark_gray_color forState:UIControlStateNormal];
    [selectBtn addTarget:self action:@selector(onActionTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    return selectBtn;
}

// 显示每行内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"basicCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
        cell.imageView.image = NULL;
        cell.textLabel.text = NULL;
        cell.textLabel.textColor = light_black_color;
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.backgroundColor = light_white_color;
        cell.accessoryType = UITableViewCellAccessoryNone;               // cell小图标
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;      // cell样式
    }
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = _contentArray[indexPath.section];
    return cell;
}

// 点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
