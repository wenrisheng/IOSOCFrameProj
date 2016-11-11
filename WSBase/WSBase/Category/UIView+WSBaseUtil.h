//
//  UIView+WSCommonUtility.h
//  BaseStaticLibrary
//
//  Created by wrs on 15/4/19.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WSBaseUtil)

@property (assign, nonatomic) IBInspectable CGFloat cornerRadius;
@property (assign, nonatomic) IBInspectable CGFloat borderWidth;
@property (strong, nonatomic) IBInspectable UIColor *borderColor;


+ (instancetype)getXIBView;
+ (instancetype)getXIBView:(NSString *)xibName;

/**
 Returns the topMost UIViewController object in hierarchy.
 */
@property (nonatomic, readonly, strong) UIViewController *topViewController;

//  获取当前uiview所在的viewController
@property (nonatomic, readonly) UIViewController *viewController;

// 扩展到supView大小
- (void)expandToSuperView;

// 相距supview 上、下、左、右
- (void)addConstraintToSuperViewWithTop:(CGFloat)top bottom:(CGFloat)bottom left:(CGFloat)left right:(CGFloat)right;

// 更新距离TopLayout顶部的距离
- (void)updateTopConstrainToTopLayoutGuideWithViewController:(UIViewController *)viewController topMargin:(CGFloat)topMargin;

//清除superview的约束
- (void)clearConstrainsToSuperView;

//清除self宽高的约束
- (void)clearWidthAndHeight;

// 设置边框线
- (void)setBorderCornerWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor cornerRadius:(CGFloat)cornerRadius;

// 圆形
- (void)setCircleCorner;

// 清空subviews
- (void)clearSubviews;

- (void)constrainSubViewsForHorizontalAverage:(NSArray *)subViews;

- (void)constrainSubViewsForVerticalAverage:(NSArray *)subViews;

- (void)constrainSubViewsForVerticalAverage:(NSArray *)subViews height:(CGFloat)height;

- (void)autoresizingMaskSubViewsForHorizontalAverage:(NSArray *)subViews;

- (UIImage *)getImageWithRect:(CGRect)rect;

@end
