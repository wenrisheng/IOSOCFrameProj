//
//  BaseMacro.h
//  BaseStaticLibrary
//
//  Created by wrs on 15/4/7.
//  Copyright (c) 2015年 wrs. All rights reserved.
//
#import <Foundation/Foundation.h>


#ifndef BaseStaticLibrary_BaseMacro_h
#define BaseStaticLibrary_BaseMacro_h


// 资源bundle名
#define BASESTATICLIBRARY_BOUNDNAME     @"WSBaseResource"

#define REQUEST_TIP                     @"正在请求……"
#define REQUEST_FAIL_TIP                @"请求失败！"
#define TOAST_VIEW_TIME                 2
#define PAGESIZE                        15

#define WSKey                           @"WSKey"
#define WSValue                         @"WSValue"

#pragma mark - 常用
#define STATUSBAR_HEIGHT                20
#define NAVIGITIONBAR_HEIGHT            44

#define SHARE_APPLICATION               [UIApplication sharedApplication]
#define APP_DELEGATE                    [UIApplication sharedApplication].delegate
#define KEY_WINDOW                      [UIApplication sharedApplication].keyWindow

// 获取xib第一个对象
#define GET_XIB_FIRST_OBJECT(xibName)   [[[NSBundle mainBundle] loadNibNamed:xibName owner:nil options:nil] firstObject]
// 获取bundle里xib第一个对象
#define GET_XIB_FIRST_OBJECT_INBUNDLE(xibName,bundleName) [[[NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:bundleName withExtension:@"bundle"]] loadNibNamed:xibName owner:nil options:nil] firstObject]


//获取屏幕 宽度、高度 (包括状态栏)
#define SCREEN_WIDTH_NO_STATUS          [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT_NO_STATUS         [UIScreen mainScreen].bounds.size.height

//获取屏幕 宽度、高度 (不包括状态栏)
#define SCREEN_WIDTH                    [UIScreen mainScreen].applicationFrame.size.width
#define SCREEN_HEITHT                   [UIScreen mainScreen].applicationFrame.size.height
#define RATIO_HEIGHT(ratio)             SCREEN_HEITHT * ratio
#define RATIO_WIDTH(ratio)              SCREEN_WIDTH * ratio

#define USER_DEFAULT                    [NSUserDefaults standardUserDefaults]

#pragma mark - 打印日志
//DEBUG  模式下打印日志,当前行
#ifdef DEBUG
    #define DLog(fmt, ...)              NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
    #define DLog(...)
#endif


//重写NSLog,Debug模式下打印日志和当前行数
#if DEBUG
    #define NSLog(FORMAT, ...)          fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
    #define NSLog(FORMAT, ...) nil
#endif

//DEBUG  模式下打印日志,当前行 并弹出一个警告
#ifdef DEBUG
    #define ULog(fmt, ...)               { UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%s\n [Line %d] ", __PRETTY_FUNCTION__, __LINE__] message:[NSString stringWithFormat:fmt, ##__VA_ARGS__]  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil]; [alert show]; }
#else
    #define ULog(...)
#endif

#pragma mark - 系统
//获取系统版本
#define IOS_VERSION                           [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion                  [[UIDevice currentDevice] systemVersion]
#define IOS7ORLATER                           [[[UIDevice currentDevice] systemVersion] floatValue] >= 7 ? YES : NO
#define IOS8ORLATER                           [[[UIDevice currentDevice] systemVersion] floatValue] >= 8 ? YES : NO
#define IOS9ORLATER                           [[[UIDevice currentDevice] systemVersion] floatValue] >= 9 ? YES : NO

//获取当前语言
#define CurrentLanguage                       ([[NSLocale preferredLanguages] objectAtIndex:0])

//判断是否 Retina屏、设备是否%fhone 5、是否是iPad
#define isRetina                              ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5                               ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6                               ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)) : NO)
#define iPhone6plus                           ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)
#define isPad                                 (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)


//判断是真机还是模拟器
#if TARGET_OS_IPHONE
//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif

//检查系统版本
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#pragma mark - APP
// 获取plish 字典value
#define INFODICTIONARY_VALE(key)                [[[NSBundle mainBundle] infoDictionary]objectForKey:key]

// 获取应用版本号
#define APP_VERSION                             [[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleVersion"]
#define APP_VERSION_STRING                      [[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleShortVersionString"]

#pragma mark - 内存
//使用ARC和不使用ARC
#if __has_feature(objc_arc)
//compiling with ARC
#else
// compiling without ARC
#endif

//释放一个对象
#define SAFE_DELETE(P)                          if(P) { [P release], P = nil; }

#define SAFE_RELEASE(x)                         if(x) {[x release];x=nil;}

#pragma mark - 图片
//读取本地图片
#define LOADIMAGE(file,ext)                     [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]
//定义UIImage对象
#define IMAGE(A)                                [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]

#pragma mark - 颜色
// rgb颜色转换（16进制->10进制）
#define UIColorWithHexRGB(rgbValue)                [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

// 获取RGB颜色
#define UIColorWithRGBA(r,g,b,a)                [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define UIColorWithRGB(r,g,b)                   UIColorWithRGBA(r,g,b,1.0f)
// 透明色
#define CLEARCOLOR                              [UIColor clearColor]

#pragma mark -
//设置View的tag属性
#define VIEWWITHTAG(_OBJECT, _TAG)              [_OBJECT viewWithTag : _TAG]
//程序的本地化,引用国际化的文件
#define MyLocal(x, ...)                         NSLocalizedString(x, nil)

#pragma mark - GCD
#define BACK(block)                             dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block)                             dispatch_async(dispatch_get_main_queue(),block)

#pragma mark - 単例
#define SYNTHESIZE_SINGLETON_FOR_CLASS(classname) \
\
static classname *shared##classname = nil; \
\
+ (classname *)shared##classname \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [[self alloc] init]; \
} \
} \
\
return shared##classname; \
} \
\
+ (id)allocWithZone:(NSZone *)zone \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [super allocWithZone:zone]; \
return shared##classname; \
} \
} \
\
return nil; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return self; \
}


#endif

