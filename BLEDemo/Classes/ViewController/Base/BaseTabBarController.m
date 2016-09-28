//
//  BaseTabBarController.m
//  BLEDemo
//
//  Created by chensen on 16/9/27.
//  Copyright © 2016年 阿森纳. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
#import "CommonFunction.h"
#import "UIImage+Extension.h"
#import "DeviceViewController.h"
#import "FindViewController.h"
#import "HelpViewController.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [UITabBar appearance].backgroundImage = [UIImage imageWithColor:white_color size:self.tabBar.bounds.size];
    [UITabBar appearance].shadowImage = [[UIImage alloc] init];   // 阴影图片
//    [UITabBar appearance].translucent = NO;   // 是否半透明状态
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:small_black_color} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:blue_color} forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -2)];     // 设置文字跟图片的距离
    
    DeviceViewController *deviceVC = [[DeviceViewController alloc] init];
    deviceVC.tabBarItem.title = @"设备";
    deviceVC.tabBarItem.image = [[UIImage imageNamed:@"main_no_shebei"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]; // 图片按原样渲染，而不是系统默认的蓝色
    deviceVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"main_shebei"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    BaseNavigationController *navigationController = [[BaseNavigationController alloc] initWithRootViewController:deviceVC];  // 为每个功能模块视图控制器添加导航栏控制器
    [self addChildViewController: navigationController];   // 添加子势图
    
    FindViewController *findVC = [[FindViewController alloc] init];
    findVC.tabBarItem.title = @"发现";
    findVC.tabBarItem.image = [[UIImage imageNamed:@"main_no_find"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    findVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"main_find"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navigationController = [[BaseNavigationController alloc] initWithRootViewController:findVC];
    [self addChildViewController:navigationController];
    
    HelpViewController *helpVC = [[HelpViewController alloc] init];
    helpVC.tabBarItem.title = @"帮助";
    helpVC.tabBarItem.image = [[UIImage imageNamed:@"main_no_help"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    helpVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"main_help"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navigationController = [[BaseNavigationController alloc] initWithRootViewController:helpVC];
    [self addChildViewController:navigationController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
