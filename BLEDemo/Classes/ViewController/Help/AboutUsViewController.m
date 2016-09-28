//
//  AboutUsViewController.m
//  HomeLock
//
//  Created by chensen on 16/8/29.
//  Copyright © 2016年 阿森纳. All rights reserved.
//

#import "AboutUsViewController.h"
#import "CommonFunction.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"关于我们";
    [self.view setBackgroundColor:bg_color];

    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, self.view.frame.size.width - 20, 300)];
    [textLabel setBackgroundColor:[UIColor clearColor]];
    [textLabel setTextColor:dark_gray_color];
    [textLabel setText:@"      你我他你我他你我他你我他你我他你我他你我他你我他你我他你我他你我他你我他你我他你我他你我他你我他你我他你我他。\n\n 你我他你我他你我他你我他你我他你我他你我他你我他你我他你我他你我他你我他你我他你我他你我他你我他。\n\n  你我他你我他你我他你我他你我他你我他你我他你我他你我他你我他你我他你我他你我他你我他。"];
    [textLabel setTextAlignment:NSTextAlignmentLeft];
    [textLabel setFont:[UIFont systemFontOfSize:14]];
    [textLabel setNumberOfLines:0];
    //自适应高度
    CGRect txtFrame = textLabel.frame;
    
    textLabel.frame = CGRectMake(10, 20, self.view.frame.size.width - 20,
                             txtFrame.size.height =[textLabel.text boundingRectWithSize:
                                                    CGSizeMake(txtFrame.size.width, CGFLOAT_MAX)
                                                                            options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                                         attributes:[NSDictionary dictionaryWithObjectsAndKeys:textLabel.font,NSFontAttributeName, nil] context:nil].size.height);
    textLabel.frame = CGRectMake(10, 20, self.view.frame.size.width - 20, txtFrame.size.height);
    [self.view addSubview:textLabel];
}

@end
