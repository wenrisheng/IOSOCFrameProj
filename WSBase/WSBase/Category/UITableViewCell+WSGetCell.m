//
//  UITableViewCell+WSGetCell.m
//  WSBase
//
//  Created by wenrisheng on 16/4/15.
//  Copyright © 2016年 wenrisheng. All rights reserved.
//

#import "UITableViewCell+WSGetCell.h"
#import "WSBaseMacro.h"

@implementation UITableViewCell (WSGetCell)

+ (instancetype)getCellFromTableView:(UITableView *)tableView
{
    NSString *identify = [NSString stringWithUTF8String:object_getClassName(self)];
    return [self getCellFromTableView:tableView identify:identify];
}

+ (instancetype)getCellFromTableView:(UITableView *)tableView identify:(NSString *)identify
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = GET_XIB_FIRST_OBJECT(identify);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
