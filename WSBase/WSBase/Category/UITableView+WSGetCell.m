//
//  UITableView+GetCell.m
//  WSBase
//
//  Created by wrs on 15/9/8.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import "UITableView+WSGetCell.h"
#import "WSBaseMacro.h"

@implementation UITableView (WSGetCell)

- (UITableViewCell *)getCellWithIdentify:(NSString *)identify
{
    UITableViewCell *cell = [self dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = GET_XIB_FIRST_OBJECT(identify);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}


- (UITableViewCell *)getCellWithIdentify:(NSString *)identify bundle:(NSString *)bundleName
{
    UITableViewCell *cell = [self dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
//        cell = [[[NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:bundleName withExtension:@"bundle"]] loadNibNamed:identify owner:nil options:nil] firstObject];
        cell = GET_XIB_FIRST_OBJECT_INBUNDLE(identify, bundleName);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
