//
//  DeviceViewController.h
//  BLEDemo
//
//  Created by chensen on 16/9/27.
//  Copyright © 2016年 阿森纳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface DeviceViewController : UIViewController<CBCentralManagerDelegate, CBPeripheralDelegate>

@property (nonatomic, strong) CBCentralManager *manager;
@property (nonatomic, strong) CBPeripheral *currperipheral;              // 当前外设
@property (nonatomic, strong) CBCharacteristic *currCharacteristic;      // 当前特征值

@property (nonatomic, strong) NSMutableArray *blePerArray;               // 外设数组

@end
