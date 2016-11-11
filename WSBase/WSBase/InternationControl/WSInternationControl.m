//
//  WSInternationControl.m
//  WSAfrica
//
//  Created by wrs on 15/9/28.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import "WSInternationControl.h"

#define WS_USER_LANGUAGE          @"WS_USER_LANGUAGE"

@implementation WSInternationControl

+(NSBundle *)languageBundle
{
    //1.第一步改变bundle的值
    NSString *language = [WSInternationControl userLanguage];
    NSString *path = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj"];
    NSBundle *languageBundle = [NSBundle bundleWithPath:path];
    return languageBundle;
}

+(NSString *)userLanguage
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *string = [userDefaults valueForKey:WS_USER_LANGUAGE];
    
    if(string.length == 0){
        //获取系统当前语言版本(中文zh-Hans zh-Hans-CN,英文en)
   //     NSArray* languages = [userDefaults objectForKey:@"AppleLanguages"];
 //       NSString *current = [languages objectAtIndex:0];
        string = @"zh-Hans";
        [userDefaults setValue:string forKey:WS_USER_LANGUAGE];
        [userDefaults synchronize];//持久化，不加的话不会保存
    }
  
    return string;
}

+ (WSLanguageType)languageType
{
    WSLanguageType languageType = WSLanguageTypeZhHans;
    NSString *languageStr = [WSInternationControl userLanguage];
    languageType = [WSInternationControl converToLanguageType:languageStr];
    return languageType;
}

+ (WSLanguageType)converToLanguageType:(NSString *)language
{
    WSLanguageType languageType;
    if ([language isEqualToString:@"zh-Hans"] || [language isEqualToString:@"zh-Hans-CN"]) {
        languageType = WSLanguageTypeZhHans;
    } else if ([language isEqualToString:@"en"]) {
        languageType = WSLanguageTypeEn;
    }
    return languageType;
}

+ (NSString *)converToLanguage:(WSLanguageType)languageType
{
    NSString *language;
    switch (languageType) {
        case WSLanguageTypeZhHans:
        {
            language = @"zh-Hans";
        }
            break;
        case WSLanguageTypeEn:
        {
            language = @"en";
        }
            break;
        default:
            break;
    }
    return language;
}

+(void)setUserlanguage:(NSString *)language
{
   
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    //2.持久化
    [userDefaults setValue:language forKey:WS_USER_LANGUAGE];
    
    [userDefaults synchronize];
    
    // 语言切换通知
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setValue:language forKey:WSLaguageKey];
    WSLanguageType languageType = [WSInternationControl converToLanguageType:language];
    [userInfo setValue:[NSNumber numberWithInteger:languageType] forKey:WSLanguageTypeKey];
    [[NSNotificationCenter defaultCenter] postNotificationName:WSLanguageChangeNotification object:nil userInfo:userInfo];
}

+ (void)setUserlanguageType:(WSLanguageType)languageType
{
    NSString *languageStr = [WSInternationControl converToLanguage:languageType];
    [WSInternationControl setUserlanguage:languageStr];
}

+ (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value
{
     NSString *str = [[WSInternationControl languageBundle] localizedStringForKey:key value:value table:@"Localizable"];
    return str;
}

@end
