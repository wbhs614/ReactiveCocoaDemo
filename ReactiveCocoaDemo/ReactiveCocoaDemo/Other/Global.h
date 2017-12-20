//
//  Global.h
//  BeautifulAgent
//
//  Created by kkmac on 2017/3/15.
//  Copyright © 2017年 kkmac. All rights reserved.
//

#ifndef Global_h
#define Global_h


/*****常用宏*****/
#define NavigationColor [UIColor colorWithRed:25/255.0f green:165/ 255.0f blue:230/255.0f alpha:1.0]

#define isPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? YES : NO)
#define isRetina ([[UIScreen mainScreen] scale] > 1 ? YES : NO)
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width  //  设备的宽度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height //   设备的高度

/*****方法宏*****/
#define Weak(type)  __weak typeof(type) weak##type = type; // 弱引用
//不是debug状态时去掉NSLog
#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...)
#endif
//判断数组为空
#define NULLArray(array)   \
        ((array == nil)||[array isKindOfClass:[NSNull class]]||array.count == 0)
//判断字符串为空
#define NULLString(string)   \
        ((![string isKindOfClass:[NSString class]])||\
        [string isEqualToString:@""]||\
        (string == nil)||\
        [string isEqualToString:@"(null)"]||\
        [string isKindOfClass:[NSNull class]]||\
        [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)
//当前是否有toast弹出
#define ToastKey @"ishasTtoast"
#define ToastBottom 100 //toast距离底部的距离
#define NetWorkChangeNotification @"NetWorkChangeNotification"

//日志服务器地址
#define CrashLogSFTPHostName @"120.76.26.70"
#define CrashLogSFTPPort 22
#define CrashLogSFTPUserName @"kkxt"
#define CrashLogSFTPPassword @"admin88**"
#define CrashLogSFTPLogDir @"/home/applog/ioslog/"

//realm数据库相关参数
#define realmName @"StomatologyRealm"//数据库名称
#define realmVersion  9 //当前数据库版本

//蒲公英自动更新的APPID
#define paySDKKey @"2c99290f0cb2c567cb153c1fba75d867"

#endif /* Global_h */
