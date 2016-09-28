//
//  CommonFunction.h
//  BLEDemo
//
//  Created by chensen on 16/9/27.
//  Copyright © 2016年 阿森纳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonFunction : NSObject

// 上下拉刷新
#define PULL_REFRESH_TAG 999999
#define CELL_SUBVIEW_TAG 100000

// 公共颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:a]
#define bg_color [UIColor colorWithRed:243/255.0f green:243/255.0f blue:243/255.0f alpha:1]                  // #F3F3F3
#define bottom_bg_color [UIColor colorWithRed:242/255.0f green:242/255.0f blue:242/255.0f alpha:1]           // #F2F2F2
#define white_color [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1]               // #FFFFFF
#define light_white_color [UIColor colorWithRed:247/255.0f green:247/255.0f blue:247/255.0f alpha:1]         // #F7F7F7
#define red_color [UIColor colorWithRed:229/255.0f green:0/255.0f blue:17/255.0f alpha:1]                    // #E50011
#define light_gray_color [UIColor colorWithRed:204/255.0f green:204/255.0f blue:204/255.0f alpha:1]          // #CCCCCC
#define dark_light_gray_color [UIColor colorWithRed:171/255.0f green:171/255.0f blue:171/255.0f alpha:1]     // #ABABAB
#define hight_light_gray_color [UIColor colorWithRed:221/255.0f green:221/255.0f blue:221/255.0f alpha:1]    // #dddddd
#define small_light_gray_color [UIColor colorWithRed:220/255.0f green:220/255.0f blue:220/255.0f alpha:1]    // #dcdcdc
#define green_color [UIColor colorWithRed:1/255.0f green:158/255.0f blue:151/255.0f alpha:1]                 // #019E97
#define blue_color [UIColor colorWithRed:4/255.0f green:168/255.0f blue:236/255.0f alpha:1]                  // #04A8EC
#define dark_blue_color [UIColor colorWithRed:0/255.0f green:124/255.0f blue:176/255.0f alpha:1]             // #007cb0
#define dark_gray_color [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1]              // #333333
#define hight_dark_gray_color [UIColor colorWithRed:62/255.0f green:62/255.0f blue:62/255.0f alpha:1]        // #3E3E3E
#define light_black_color [UIColor colorWithRed:78/255.0f green:78/255.0f blue:78/255.0f alpha:1]            // #4E4E4E
#define small_black_color [UIColor colorWithRed:85/255.0f green:85/255.0f blue:85/255.0f alpha:1]            // #555555
#define medium_gray_color [UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1]         // #666666
#define gray_color [UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1]                // #999999



// iOS系统版本
#define SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] doubleValue]
// 标准系统状态栏高度
#define SYS_STATUS_BAR_HEIGHT 20
// 热点栏高度
#define HOTSPOT_STATUS_BAR_HEIGHT 20
// 导航栏（UINavigationController.UINavigationBar）高度
#define NAVIGATION_BAR_HEIGHT 44
// 标签栏（UITabBarController.UITabBar）高度
#define TAB_BAR_HEIGHT 49
// 工具栏（UINavigationController.UIToolbar）高度
#define TOOL_BAR_HEIGHT 44
// APP_STATUS_BAR_HEIGHT = SYS_STATUS_BAR_HEIGHT + HOTSPOT_STATUS_BAR_HEIGHT
#define APP_STATUS_BAR_HEIGHT (CGRectGetHeight([UIApplication sharedApplication].statusBarFrame))
// 根据APP_STATUSBAR_HEIGHT判断是否存在热点栏
#define IS_HOTSPOT_CONNECTED  (APP_STATUS_BAR_HEIGHT == (SYS_STATUS_BAR_HEIGHT + HOTSPOT_STATUS_BAR_HEIGHT)?YES:NO)
// 无热点栏时，标准系统状态栏高度+导航栏高度
#define NORMAL_STATUS_AND_NAV_BAR_HEIGHT (SYS_STATUS_BAR_HEIGHT + NAVIGATION_BAR_HEIGHT)
// 实时系统状态栏高度+导航栏高度，如有热点栏，其高度包含在APP_STATUSBAR_HEIGHT中。
#define STATUS_AND_NAV_BAR_HEIGHT  (APP_STATUS_BAR_HEIGHT + NAVIGATION_BAR_HEIGHT)

#define SCREEN_X ([UIScreen mainScreen].bounds.origin.x)
#define SCREEN_Y ([UIScreen mainScreen].bounds.origin.y)
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT (([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0) ? (IS_HOTSPOT_CONNECTED ? ([UIScreen mainScreen].bounds.size.height) - 20 : ([UIScreen mainScreen].bounds.size.height)) : (([UIScreen mainScreen].bounds.size.height) - 20))

/**
 NSString 和Byte的转换
 */
+(NSData*)hexToBytes:(NSString *)string;

/**
 十六进制串转化为NSData数组
 */
+ (NSData *)convertHexStrToData:(NSString *)str;

/**
 将NSData转换成十六进制的字符串
 */
+ (NSString *)convertDataToHexStr:(NSData *)data;

@end
