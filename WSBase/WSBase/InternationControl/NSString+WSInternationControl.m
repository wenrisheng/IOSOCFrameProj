//
//  NSString+WSInternationControl.m
//  WSAfrica
//
//  Created by wrs on 15/9/28.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import "NSString+WSInternationControl.h"

@implementation NSString (WSInternationControl)

+ (NSString *)localizedStringForKey:(NSString *)key defaultValue:(NSString *)defaultValue
{
    NSString *str = [WSInternationControl localizedStringForKey:key value:defaultValue];
    return str;
}

@end
