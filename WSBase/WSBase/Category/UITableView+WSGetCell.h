//
//  UITableView+GetCell.h
//  WSBase
//
//  Created by wrs on 15/9/8.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (WSGetCell)

/**
 *
 *
 *  @param identify identify
 *
 *  @return return
 */
- (UITableViewCell *)getCellWithIdentify:(NSString *)identify;

- (UITableViewCell *)getCellWithIdentify:(NSString *)identify bundle:(NSString *)bundleName;

@end
