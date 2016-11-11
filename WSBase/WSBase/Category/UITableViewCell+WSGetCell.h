//
//  UITableViewCell+WSGetCell.h
//  WSBase
//
//  Created by wenrisheng on 16/4/15.
//  Copyright © 2016年 wenrisheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (WSGetCell)

+ (instancetype)getCellFromTableView:(UITableView *)tableView;
+ (instancetype)getCellFromTableView:(UITableView *)tableView identify:(NSString *)identify;

@end
