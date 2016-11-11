//
//  WSInternationControl.h
//  WSAfrica
//
//  Created by wrs on 15/9/28.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import <Foundation/Foundation.h>

#define WSLanguageChangeNotification       @"WSLanguageChangeNotification"   // 语言切换通知
#define WSLanguageTypeKey                  @"WSLanguageType"
#define WSLaguageKey                       @"WSLaguage"

typedef NS_ENUM(NSInteger, WSLanguageType) {
    WSLanguageTypeZhHans = 0,  // 简体中文
    WSLanguageTypeEn
};

@interface WSInternationControl : NSObject

/**
 *  获取当前资源文件
 *
 *  @return return
 */
+(NSBundle *)languageBundle;

+(NSString *)userLanguage;//获取应用当前语言

+ (WSLanguageType)languageType;

+ (WSLanguageType)converToLanguageType:(NSString *)language;

+ (NSString *)converToLanguage:(WSLanguageType)languageType;

/**
 *
 *
 *  @param language 
  en,"zh-Hant", (繁体中文),"zh-Hans",(zh-Hans-CN简体中文),fr,de,ja,nl,it,es,pt,"pt-PT",da,fi,nb,sv,ko,ru,pl,tr,uk,ar,hr,cs,el,he,ro,sk,th,id,"en-GB",ca,hu,vi
 *
 */
+ (void)setUserlanguage:(NSString *)language;//设置当前语言

+ (void)setUserlanguageType:(WSLanguageType)languageType;

/**
 *
 *
 *  @param key   key
 *  @param value 默认值
 *
 *  @return return
 */
+ (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value;

@end
