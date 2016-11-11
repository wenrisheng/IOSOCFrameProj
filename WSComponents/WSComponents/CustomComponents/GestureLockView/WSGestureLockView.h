//
//  WSGestureLockView.h
//  WSComponents
//
//  Created by wenrisheng on 16/11/3.
//  Copyright © 2016年 wenrisheng. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WSGestureLockView : UIView

@property (strong, nonatomic) UIColor *lineColor; // 线颜色
@property (assign, nonatomic) CGFloat lineWidth;  // 线宽

@property (assign, nonatomic) NSInteger rowNum; // 行数
@property (assign, nonatomic) CGFloat border;   // 间隔
@property (assign, nonatomic) CGFloat width;    // 宽度
@property (strong, nonatomic) UIImage *normalImage;  // 正常状态图片
@property (strong, nonatomic) UIImage *selectedImage; // 选中状态图片

@property (copy) void(^passwordFinish)(NSInteger index, NSString *pwd);

- (void)resetDrawUI;

@end
