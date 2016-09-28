//
//  CommonFunction.m
//  BLEDemo
//
//  Created by chensen on 16/9/27.
//  Copyright © 2016年 阿森纳. All rights reserved.
//

#import "CommonFunction.h"

@implementation CommonFunction

+(NSData*) hexToBytes :(NSString *)string
{
    NSMutableData *data = [NSMutableData data];
    int idx;
    for (idx = 0; idx+2 <= string.length; idx+=2)
    {
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [string substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    return data;
}

+ (NSData *)convertHexStrToData:(NSString *)str
{
    if (!str || [str length] == 0)
    {
        return nil;
    }
    
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:8];
    NSRange range;
    if ([str length] % 2 == 0)
    {
        range = NSMakeRange(0, 2);
    }
    else
    {
        range = NSMakeRange(0, 1);
    }
    for (NSInteger i = range.location; i < [str length]; i += 2)
    {
        unsigned int anInt;
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt: &anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
    NSLog(@"hexdata：%@", hexData);
    return hexData;
}

+ (NSString *)convertDataToHexStr:(NSData *)data
{
    if (!data || [data length] == 0)
    {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop)
     {
         unsigned char *dataBytes = (unsigned char *)bytes;
         for (NSInteger i = 0; i < byteRange.length; i++)
         {
             NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
             if ([hexStr length] == 2)
             {
                 [string appendString:hexStr];
             }
             else
             {
                 [string appendFormat:@"0%@", hexStr];
             }
         }
     }];
    return string;
}

@end
