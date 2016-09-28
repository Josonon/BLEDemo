//
//  FindViewController.h
//  BLEDemo
//
//  Created by chensen on 16/9/27.
//  Copyright © 2016年 阿森纳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

typedef NS_ENUM(NSInteger, BluetoothState){
    BluetoothStateDisconnect = 0,
    BLuetoothStateScanSuccess,
    BluetoothStateScaning,
    BluetoothStateConnected,
    BluetoothStateConnecting
};

typedef NS_ENUM(NSInteger, BluetoothFailState){
    BluetoothFailStateUnExit = 0,
    BluetoothFailStateUnKnow,
    BluetoothFailStateByHW,
    BluetoothFailStateByOff,
    BluetoothFailStateUnanthorized,
    BluetoothFailStateByTimeout
};

@interface FindViewController : UIViewController<CBCentralManagerDelegate, CBPeripheralDelegate>

@property (nonatomic, strong) CBCentralManager *manager;
@property (nonatomic, strong) CBPeripheral *currperipheral;          
@property (nonatomic, strong) CBCharacteristic *currCharacteristic;

@property (nonatomic, strong) NSMutableArray *blePerArray;                          // 设备数组

@property (nonatomic, assign) BluetoothFailState bluetoothFailState;
@property (nonatomic, assign) BluetoothState bluetoothState;

@end
