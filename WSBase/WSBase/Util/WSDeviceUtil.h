//
//  WSDeviceUtil.h
//  WSBase
//
//  Created by wenrisheng on 16/4/29.
//  Copyright © 2016年 wenrisheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSDeviceUtil : NSObject

+ (NSString *)getIPAddress:(BOOL)preferIPv4;
+ (NSDictionary *)getIPAddresses;

@end
