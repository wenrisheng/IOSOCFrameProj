//
//  WSActionSheetModel.h
//  WSBase
//
//  Created by wenrisheng on 16/4/27.
//  Copyright © 2016年 wenrisheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSAlertViewModel : NSObject

@property (strong, nonatomic) NSString *title;
@property (copy, nonatomic) void (^handle)(void);

@end
