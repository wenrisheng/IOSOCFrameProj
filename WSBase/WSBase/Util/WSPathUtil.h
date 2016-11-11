//
//  WSPathUtil.h
//  NotificationProj
//
//  Created by wrs on 15/6/30.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSPathUtil : NSObject

/**
 *  获取根路径
 *
 *  @return return
 */
+ (NSString *)getHomePath;

/**
 *  获取Document路径
 *
 *  @return return
 */
+ (NSString *)getDocumentsPath;

/**
 *  获取缓存路径
 *
 *  @return return
 */
+ (NSString *)getCachePath;

/**
 *  获取零时路径
 *
 *  @return return
 */
+ (NSString *)getTempPath;

/**
 *  获取bundle路径
 *
 *  @return return
 */
+ (NSString *)getBundlePath;

@end
