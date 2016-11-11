//
//  MD5Util.m
//  Encryption
//
//  Created by 雷传营 on 16/1/10.
//  Copyright © 2016年 leichuanying. All rights reserved.
//

#import "MDUtil.h"
#import <CommonCrypto/CommonDigest.h>
@interface MDUtil ()

@end

@implementation MDUtil

+ (NSString *)encryptToLowercase:(NSString *)str
{
    NSString *tempStr = [self encryptToSupercase:str];
    return [tempStr lowercaseString];
}

+ (NSString *)encryptToSupercase:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02X",result[i]];
    }
    return ret;
}

@end
