//
//  DeviceViewController.m
//  BLEDemo
//
//  Created by chensen on 16/9/27.
//  Copyright © 2016年 阿森纳. All rights reserved.
//

#import "DeviceViewController.h"
#import "CommonFunction.h"

@interface DeviceViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_tableView;
}

@end

@implementation DeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"蓝牙设备";
    [self.view setBackgroundColor:bg_color];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"扫描" style:UIBarButtonItemStylePlain target:self action:@selector(scan)];
    [self.navigationItem.rightBarButtonItem setTitlePositionAdjustment:UIOffsetMake(-10, 0) forBarMetrics:UIBarMetricsDefault];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [UIFont systemFontOfSize:13]} forState:UIControlStateNormal];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - CGRectGetHeight([UIApplication sharedApplication].statusBarFrame) + 44 + 49) style:UITableViewStylePlain];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [_tableView setShowsVerticalScrollIndicator:NO];   // 不显示纵向滚动条
    [_tableView setBackgroundColor:[UIColor clearColor]];
    [_tableView setBackgroundView:nil];
    [_tableView setDataSource:self];
    [_tableView setDelegate:self];
    [_tableView setTableFooterView:[[UIView alloc] init]];  // 删除多余线条
    [self.view addSubview:_tableView];
    
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [_tableView setSeparatorInset:UIEdgeInsetsZero]; //缩进 图标
    }
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [_tableView setLayoutMargins:UIEdgeInsetsZero]; //缩进 左边
    }
    
    _manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    _blePerArray = [[NSMutableArray alloc] initWithCapacity:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

// 告诉tableView一共有多少组数据
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// 当前组内有多少行数组
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _blePerArray.count;
}

// 动态获得cell的高度(每行高)
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

// 每一行显示什么内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"deviceCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
        cell.imageView.image = NULL;
        cell.textLabel.text = NULL;
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.detailTextLabel.text = NULL;
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;        // cell的样式
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;  // cell小图标
    }
    cell.imageView.image = NULL;
    
    CBPeripheral *per = (CBPeripheral *)_blePerArray[indexPath.row];
    cell.textLabel.text = per.name;
    
    return cell;
}

// 点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];  // 选中后的反显颜色即刻消失
}

#pragma mark - Bluetooth Delegate -

// 开始扫描
- (void)scan
{
    [_manager scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey:@YES}];   // 外设支持BLE，且正常工作
    
    [_blePerArray removeAllObjects];                   // 清空所有的外部设备数组
}

// 接下来检查蓝牙状态
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    if (central.state != CBCentralManagerStatePoweredOn)
    {
        NSLog(@"Fail, state is off.");
        switch (central.state)
        {
            case CBCentralManagerStatePoweredOff:
                NSLog(@"连接失败了\n请您再检查一下您的手机蓝牙是否开启，\n然后再试一次吧");
                break;
                
            case CBCentralManagerStateResetting:
                NSLog(@"警告提示您手机的蓝牙连接超时，需要去重置下。");
                break;
                
            case CBCentralManagerStateUnsupported:
                NSLog(@"检测到您的手机不支持蓝牙4.0\n所以建立不了连接.建议更换您\n的手机再试试。");
                break;
                
            case CBCentralManagerStateUnauthorized:  // (未经授权的)
                NSLog(@"连接失败了\n程序未授权");
                break;
                
            case CBCentralManagerStateUnknown:
                NSLog(@"检查到您手机未知。");
                break;
                
            default:
                break;
        }
        return;
    }
    NSLog(@">>>蓝牙设备处于开机状态，可以进行扫描了。");
    // ... so start scanning
        [self scan];
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSLog(@">>>已发现 peripheral:%@ RSSI：%@， UUID：%@ advertisementData：%@", peripheral, RSSI, peripheral.name, advertisementData);
    _currperipheral = peripheral;
    
    BOOL replace = NO;
    for (int i = 0; i < _blePerArray.count; i++)
    {
        CBPeripheral *p = [_blePerArray objectAtIndex:i];
        if ([p isEqual:peripheral])
        {
            [_blePerArray replaceObjectAtIndex:i withObject:peripheral];
            replace = YES;
        }
    }
    [_blePerArray addObject:peripheral];
    
    // Connects to the discovered peripheral
    [self.manager connectPeripheral:peripheral options:nil];
    [_tableView reloadData];
}

// 连接上设备之后，获取当前设备
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSLog(@">>>连接到名称为%@的设备--成功", peripheral);
    [peripheral setDelegate:self];
    [peripheral discoverServices:nil];        // 获取服务和特征
    
    // 或许只获取你的设备蓝牙服务uuid数组，一个或者多个
//    [peripheral discoverServices:@[[CBUUID UUIDWithString:@""],[CBUUID UUIDWithString:@""]]];
    
    NSLog(@"Peripheral Connected");
    
    [_manager stopScan];
    NSLog(@"Scanning stopped");
    _currperipheral = peripheral;
    [_currperipheral setDelegate:self];
    [_currperipheral discoverServices:nil];              // 获取服务和特征
}

//连接外设失败
-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"connecting Peripheral Error !%@",error);
}

// Peripherals断开连接
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@">>>外设连接断开连接%@: %@\n", [peripheral name], [error localizedDescription]);
}

// 读取接受的信号强大
- (void)peripheral:(CBPeripheral *)peripheral didReadRSSI:(NSNumber *)RSSI error:(NSError *)error
{
    int rssi = [RSSI intValue];
    CGFloat ci = (rssi - 49) / (10 * 4.0);
    NSString *length = [NSString stringWithFormat:@"发现BLT4.0热点:%@,距离:%.1fm", _currperipheral, pow(10, ci)];
    NSLog(@"距离：%@",length);
}

// 获取当前设备的service
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    if (error)
    {
        NSLog(@"Error discovering services：%@", [error localizedDescription]);
        return;
    }
    NSLog(@"所有的services的UUID ===== %@", peripheral.services);
    
    int i = 0;
    for (CBService *service in peripheral.services)             // 遍历所有service
    {
        i++;
        NSLog(@"%d：每个服务的UUID === %@(%@)", i, service.UUID.data, service.UUID);
        
        //        if ([service.UUID isEqual:[CBUUID UUIDWithString:@"ffe0"]])               // 可以过滤选出我们想要服务下的特征,找到你需要的servicesUUID
        //        {
        //            [peripheral discoverCharacteristics:nil forService:service];
        //        }
        [peripheral discoverCharacteristics:nil forService:service];
    }
    NSLog(@"此时链接的Peripheral：%@", peripheral);
}

// 特征获取
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    if (error)
    {
        NSLog(@"Discovered characteristics for %@ with error: %@", service.UUID, [error localizedDescription]);
        return;
    }
    NSLog(@"Discovered characteristics for ===== 服务：%@ （%@）", service.UUID.data, service.UUID);
    
    // 特征
    for (CBCharacteristic *characteristic in service.characteristics)
    {
        NSLog(@"特征 UUID: %@ (%@)", characteristic.UUID.data, characteristic.UUID);
//        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"ffe1"]])
//        {
//            [_peripheral readValueForCharacteristic:characteristic];                // 读取特征
//        }
//        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"ffe5"]])
//        {
//            [_peripheral readRSSI];
//        }
        
        if (characteristic.properties & CBCharacteristicPropertyNotify)                // 通知特征
        {
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"ffe2"]])
            {
                _currCharacteristic = characteristic;    // 保存当前这个通知的特征值对象
                [peripheral setNotifyValue:YES forCharacteristic:_currCharacteristic];
                NSLog(@"已经订阅特征通知。");
            }
        }
        if (characteristic.properties & CBCharacteristicPropertyWrite)                  // 写数据
        {
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"ffe1"]])
            {
                _currCharacteristic = characteristic;
            }
        }
    }
}

/*
 读取
 */
// 获取外设发来的数据，不论是read和notify，获取数据的特征值都是从这个方法中读取
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if (error)
    {
        NSLog(@"Error updating value for characteristic %@ error: %@", characteristic.UUID, [error localizedDescription]);
        return;
    }
    // 注意：value的类型是NSData，具体开发时，会根据外设协议制定的方式去解析数据
    NSLog(@"characteristic uuid：%@ value：%@", characteristic.UUID, characteristic.value);
    
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"ffe2"]])
    {
        NSString *ctsValue = [CommonFunction convertDataToHexStr:characteristic.value];
        NSLog(@" === 信号：%@", ctsValue);
    }
    else
    {
        NSLog(@"didUpdateValueForCharacteristic ===== %@", [[NSString alloc] initWithData:characteristic.value encoding:NSUTF8StringEncoding]);
    }
    
    [_tableView reloadData];
}

/*
 通知
 */
// 这儿，如果一个特征的值被更新，然后周边代理接收-peripheral:didUpdateNotificationStateForCharacteristic:error:。你可以用-readValueForCharacteristics：读取新的值
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if (error)
    {
        NSLog(@"Error changing notification state: %@", error.localizedDescription);
    }
    // Notification has started
    if (characteristic.isNotifying)
    {
        NSLog(@"Notification began on %@", characteristic.UUID);
        [peripheral readValueForCharacteristic:characteristic];
    }
    else
    {
        // Notification has stopped
        // so id connect from the peripheral
        NSLog(@"Notification stopped on %@.Disconnecting", characteristic);
        [_manager cancelPeripheralConnection:_currperipheral];
    }
}

// 用于检测中心向外设写数据是否成功
- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if (error)
    {
        NSLog(@" ===== %@", error.userInfo);
    }
    else
    {
        NSLog(@"发送数据成功");
    }
}

#pragma mark - 5、把数据写到Characteristic中

// 把数据写到Characteristic中
- (void)writeCharacteristic:(CBPeripheral *)peripheral characteristic:(CBCharacteristic *)characteristic value:(NSData *)value
{
    NSLog(@"%lu", (unsigned long)characteristic.properties);
    
    // 只有 characteristic.properties 有write的权限才可以写
    if (characteristic.properties & CBCharacteristicPropertyWrite)
    {
        /*
         最好一个type参数可以为CBCharacteristicWriteWithResponse或type：CBCharactersticWriteWithResponse，区别是是否会有反馈
         */
        [peripheral writeValue:value forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
    }
    else
    {
        NSLog(@"该字段不可写!");
    }
}

/*
 搜索Characteristic的Descriptors，读到数据会进入方法
 */
// 寻找特征里面的描述
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSLog(@"Discovering descriptor:%@", characteristic.descriptors);
    
    // 在这里，发现了特征的描述，就可以做数据的交互了
    for (CBDescriptor *dp in characteristic.descriptors)
    {
        [_currperipheral readValueForDescriptor:dp];   // 读取特征描述
        NSLog(@"%@", dp.UUID);
    }
}

#pragma mark - 6、订阅Characteristic的通知
// 设置通知
- (void)notifyCharacteristic:(CBPeripheral *)peripheral characteristic:(CBCharacteristic *)characteristic
{
    // 设置通知，数据通知会进入：didUpdateValueForCharacteristic方法
    [peripheral setNotifyValue:YES forCharacteristic:characteristic];
}

// 取消通知
-(void)cancelNotifyCharacteristic:(CBPeripheral *)peripheral characteristic:(CBCharacteristic *)characteristic
{
    [peripheral setNotifyValue:NO forCharacteristic:characteristic];
}

#pragma mark - 7、断开连接(Disconnect)
// 停止扫描并断开连接
- (void)disconnectPeripheral:(CBCentralManager *)centralManager peripheral:(CBPeripheral *)peripheral
{
    // 停止扫描
    [centralManager stopScan];
    
    // 断开连接
    [centralManager cancelPeripheralConnection:peripheral];
}

#pragma mark - 8、模拟器蓝牙调试，慎用； 最好还是用真机去调试。


#pragma mark - 其他方法 -

// 写数据(发送数据)
- (void)writeChar
{
    
    //    [_manager connectPeripheral:_peripheral options:nil];
    NSLog(@"%@", _currperipheral.name);
    // 下发数据
    //    NSString *numbers = [CommonFunction getAccount];
    //    NSString *count = [NSString stringWithFormat:@"01%@000", numbers];
    Byte byte[] = {01, 13, 00, 39, 73, 35, 20, 00};
    NSData *data = [NSData dataWithBytes:byte length:8];
    //    NSData *phoneData = [CommonFunction hexToBytes:count];
    //    NSLog(@"%@", phoneData);
    
    NSLog(@"写数据给外设");
    if (_currCharacteristic != nil && _currperipheral != nil)
    {
        //        [_peripheral writeValue:phoneData forCharacteristic:_writeAddPhoneCts type:CBCharacteristicWriteWithoutResponse];
        [_currperipheral writeValue:data forCharacteristic:_currCharacteristic type:CBCharacteristicWriteWithoutResponse];
    }
}

// 连接外设
- (void)connectionPeripheral
{
    [_manager connectPeripheral:_currperipheral options:nil];
}















@end
