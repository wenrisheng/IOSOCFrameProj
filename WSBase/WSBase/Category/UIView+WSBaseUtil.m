//
//  UIView+WSCommonUtility.m
//  BaseStaticLibrary
//
//  Created by wrs on 15/4/19.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import "UIView+WSBaseUtil.h"
#import "WSBaseMacro.h"

@implementation UIView (WSBaseUtil)

+ (instancetype)getXIBView
{
    NSString *xibName = NSStringFromClass([self class]);
    return [self getXIBView:xibName];
}

+ (instancetype)getXIBView:(NSString *)xibName
{
     return GET_XIB_FIRST_OBJECT(xibName);
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = (cornerRadius > 0);
}

- (CGFloat)cornerRadius
{
    return self.layer.cornerRadius;
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    self.layer.borderWidth = borderWidth;
}

- (CGFloat)borderWidth
{
    return self.layer.borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor
{
    self.layer.borderColor = borderColor.CGColor;
}

- (UIColor *)borderColor
{
    UIColor *color = [UIColor colorWithCGColor:self.layer.borderColor];;
    return color;
}

- (UIViewController *)viewController
{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

- (UIViewController *)topViewController
{
    NSMutableArray *controllersHierarchy = [[NSMutableArray alloc] init];
    
    UIViewController *topController = self.window.rootViewController;
    
    [controllersHierarchy addObject:topController];
    
    while ([topController presentedViewController]) {
        
        topController = [topController presentedViewController];
        [controllersHierarchy addObject:topController];
    }
    
    UIResponder *matchController = [self viewController];
    
    while (matchController != nil && [controllersHierarchy containsObject:matchController] == NO)
    {
        do
        {
            matchController = [matchController nextResponder];
            
        } while (matchController != nil && [matchController isKindOfClass:[UIViewController class]] == NO);
    }
    
    return (UIViewController*)matchController;
}

- (void)expandToSuperView
{
    // 清除self的约束
//    [self clearSelfConstrains];
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    UIView *superView = self.superview;
    UIView *view = self;
    NSDictionary *dic = NSDictionaryOfVariableBindings(view);
    NSArray *hcon=[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:dic];
    NSArray *vcon=[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:dic];
    [superView addConstraints:hcon];
    [superView addConstraints:vcon];
    
}

- (void)addConstraintToSuperViewWithTop:(CGFloat)top bottom:(CGFloat)bottom left:(CGFloat)left right:(CGFloat)right
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    // 清除self的约束
    [self clearSelfConstrains];
    
    UIView *superView = self.superview;
    NSLayoutConstraint *topCon = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeTop multiplier:1.0 constant:top];
    NSLayoutConstraint *bottomCon = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:bottom];
    NSLayoutConstraint *leftCon = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:left];
    NSLayoutConstraint *rightCon = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeRight multiplier:1.0 constant:right];
    [superView addConstraints:@[topCon, bottomCon, leftCon, rightCon]];
}

- (void)updateTopConstrainToTopLayoutGuideWithViewController:(UIViewController *)viewController topMargin:(CGFloat)topMargin
{
    float systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (systemVersion >= 7) {
        UIView *superView = viewController.view;
        NSArray *constraints = superView.constraints;
        for (NSLayoutConstraint *layoutcon in constraints) {
            NSLayoutAttribute firstAttrible = layoutcon.firstAttribute;
            id firstItem = layoutcon.firstItem;
            if (firstItem == self) {
                switch (firstAttrible) {
                    case NSLayoutAttributeTop:
                    {
                        [superView removeConstraint:layoutcon];
                        id<UILayoutSupport> topLayoutGuide = viewController.topLayoutGuide;
                        NSLayoutConstraint *topLayoutConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:topLayoutGuide attribute:NSLayoutAttributeTop multiplier:0.0 constant:topMargin];
                        [superView addConstraint:topLayoutConstraint];
                    }
                        break;
                        
                    default:
                        break;
                }
            }
        }
    }
}

- (void)clearSelfConstrains
{
    [self clearConstrainsToSuperView];
    [self clearWidthAndHeight];
}

//清除superview的约束
- (void)clearConstrainsToSuperView
{
    NSArray *superConstraints = self.superview.constraints;
    for (NSLayoutConstraint *layoutcon in superConstraints) {
        id firstItem = layoutcon.firstItem;
        id secondItem = layoutcon.secondItem;
        if (firstItem == self || secondItem == self) {
            [self.superview removeConstraint:layoutcon];
        }
    }
}

//清除self宽高的约束
- (void)clearWidthAndHeight
{
    NSArray *selfConstraints = self.constraints;
    for (NSLayoutConstraint *layoutcon in selfConstraints) {
        id firstItem = layoutcon.firstItem;
        NSLayoutAttribute firstAttribute = layoutcon.firstAttribute;
        BOOL flag1 = (firstItem == self);
        BOOL flag2 = ((firstAttribute == NSLayoutAttributeWidth) || (firstAttribute == NSLayoutAttributeHeight));
        if (flag1 && flag2) {
            [self removeConstraint:layoutcon];
        }
    }
}


- (void)setBorderCornerWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor cornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = borderWidth;
    self.layer.masksToBounds = YES;
    [self clipsToBounds];
}

// 圆形
- (void)setCircleCorner
{
    CGFloat radius = CGRectGetWidth(self.bounds) / 2;
    [self setBorderCornerWithBorderWidth:0 borderColor:nil cornerRadius:radius];
}

// 清空subviews
- (void)clearSubviews
{
    NSArray *array = self.subviews;
    for (UIView *subView in array) {
        [subView removeFromSuperview];
    }
}

- (void)constrainSubViewsForHorizontalAverage:(NSArray *)subViews
{
    if (subViews.count == 0) {
        return;
    }
    NSUInteger itemCount = subViews.count;
    CGFloat itemCountFloat = (float)itemCount / 1.00;
    for (int i = 0; i < itemCount; i++) {
        UIView *subview = [subViews objectAtIndex:i];
        subview.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:subview attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
        NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:subview attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
        
        // 修复ios 8.3multiplier不能为0的bug，8.3以前的版本系统报约束有错但会帮你修复，8.3直接闪退
        NSLayoutConstraint *left;
        CGFloat multiplier = i / itemCountFloat;
        if (multiplier == 0) {
            left =  [NSLayoutConstraint constraintWithItem:subview attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
        } else {
            left = [NSLayoutConstraint constraintWithItem:subview attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:(i / itemCountFloat) constant:0.0];
        }

        NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:subview attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:(1 / itemCountFloat) constant:0.0];
        [self addConstraints:@[top, bottom, left, width]];
    }
}

- (void)constrainSubViewsForVerticalAverage:(NSArray *)subViews
{
    if (subViews.count == 0) {
        return;
    }
    NSUInteger itemCount = subViews.count;
    CGFloat itemCountFloat = (float)itemCount / 1.00;
    for (int i = 0; i < itemCount; i++) {
        UIView *subview = [subViews objectAtIndex:i];
        subview.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:subview attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0];
        NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:subview attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
        
        // 修复ios 8.3multiplier不能为0的bug，8.3以前的版本系统报约束有错但会帮你修复，8.3直接闪退
        NSLayoutConstraint *top;
        CGFloat multiplier = i / itemCountFloat;
        if (multiplier == 0) {
            top =  [NSLayoutConstraint constraintWithItem:subview attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
        } else {
            top = [NSLayoutConstraint constraintWithItem:subview attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:(i / itemCountFloat) constant:0];
        }
        
        NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:subview attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:(1 / itemCountFloat) constant:0];
        [self addConstraints:@[left, right, top, height]];
    }

}

- (void)constrainSubViewsForVerticalAverage:(NSArray *)subViews height:(CGFloat)height
{
    if (subViews.count == 0) {
        return;
    }
    NSUInteger itemCount = subViews.count;
    CGFloat itemCountFloat = (float)itemCount / 1.00;
    for (int i = 0; i < itemCount; i++) {
        UIView *subview = [subViews objectAtIndex:i];
        subview.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:subview attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0];
        NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:subview attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
        
        // 修复ios 8.3multiplier不能为0的bug，8.3以前的版本系统报约束有错但会帮你修复，8.3直接闪退
        NSLayoutConstraint *top;
        CGFloat multiplier = i / itemCountFloat;
        if (multiplier == 0) {
            top =  [NSLayoutConstraint constraintWithItem:subview attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
        } else {
            top = [NSLayoutConstraint constraintWithItem:subview attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:i * height];
        }
        
        NSLayoutConstraint *heightCon = [NSLayoutConstraint constraintWithItem:subview attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:height];
        [self addConstraints:@[left, right, top, heightCon]];
    }

}

- (void)autoresizingMaskSubViewsForHorizontalAverage:(NSArray *)subViews
{

    NSInteger itemCount = subViews.count;
    if (itemCount == 0) {
        return;
    }
    UIView *superView = [[subViews objectAtIndex:0] superview];
    CGRect rect = superView.bounds;
    CGFloat width = rect.size.width / itemCount;
    CGFloat y = 0;
    CGFloat height = rect.size.height;
    for (int i = 0; i < itemCount; i ++) {
        UIView *itemView = [subViews objectAtIndex:i];
        itemView.translatesAutoresizingMaskIntoConstraints = YES;
        CGFloat x = i * width;
        itemView.frame = CGRectMake(x, y, width, height);
        itemView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin |UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
    }
}

- (UIImage *)getImageWithRect:(CGRect)rect
{
    CGRect bounds = self.bounds;
    UIGraphicsBeginImageContext(bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRef imageRef = CGImageCreateWithImageInRect([img CGImage], rect);
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return image;
}

@end
