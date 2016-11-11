//
//  WSDictionaryUtil.h
//  BaseStaticLibrary
//
//  Created by wrs on 15/7/6.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSDictionaryUtil : NSObject

/**
 *  对象转字典
 *
 *  @param obj obj
 *
 *  @return id id
 */
+ (NSMutableDictionary *)convertObjToDictionaryWithObj:(id)obj;

+ (id)getObjectInternal:(id)obj;


/**
 *  字典转对象
 *
 *  @param dic dic
 *  @param objClass objClass
 *
 *  @return id id
 */
+ (id)converDicToObjWithDic:(NSDictionary *)dic class:(Class)objClass;

@end
