//
//  WSActionSheet.h
//  WSBase
//
//  Created by wenrisheng on 16/4/27.
//  Copyright © 2016年 wenrisheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSAlertViewModel.h"

typedef NS_ENUM(NSUInteger, WSAlertViewType) {
    WSAlertViewTypeActionSheet,
    WSAlertViewTypeAlert
};

@interface WSAlertView : NSObject <UIActionSheetDelegate>

@property (strong, nonatomic) NSArray<WSAlertViewModel *> *modelArray;
@property (strong, nonatomic) WSAlertViewModel *cancelmodel;


+ (void)show:(NSString *)title message:(NSString *)message modelArray:(NSArray<WSAlertViewModel *> *) modelArray cancelModel:(WSAlertViewModel *)cancelmodel viewController:(UIViewController *)viewController alertViewType:(WSAlertViewType)alertViewType;


@end
