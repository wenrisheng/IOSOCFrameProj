//
//  DESUtil.h
//  WSBase
//
//  Created by wenrisheng on 16/6/3.
//  Copyright © 2016年 wenrisheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DESUtil : NSObject
// 3DES
//加密方法
+(NSString *) encrypt:(NSString *)plainText key:(NSString *)key;
//解密方法
+(NSString *)decrypt:(NSString *)cipherText key:(NSString *)key;

@end
