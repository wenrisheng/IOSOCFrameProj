//
//  MD5Util.h
//  Encryption
//
//  Created by 雷传营 on 16/1/10.
//  Copyright © 2016年 leichuanying. All rights reserved.
//  awerf

#import <Foundation/Foundation.h>

@interface MDUtil : NSObject

//md5 16位加密 （大写）
+ (NSString *)encryptToLowercase:(NSString *)str;
+ (NSString *)encryptToSupercase:(NSString *)str;



@end
