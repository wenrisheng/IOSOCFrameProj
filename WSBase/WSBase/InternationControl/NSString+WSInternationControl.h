//
//  NSString+WSInternationControl.h
//  WSAfrica
//
//  Created by wrs on 15/9/28.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSInternationControl.h"

#define  WSLocalizedString(key, value) [NSString localizedStringForKey:key defaultValue:value]



@interface NSString (WSInternationControl)

+ (NSString *)localizedStringForKey:(NSString *)key defaultValue:(NSString *)defaultValue;

@end
