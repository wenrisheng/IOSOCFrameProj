//
//  WSTabbarItem.h
//  CustomTabbarViewController
//
//  Created by wenrisheng on 16/3/18.
//  Copyright © 2016年 wenrisheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSTabbarItem : NSObject

@property (strong, nonatomic) UIViewController *viewController; // ViewController
@property (strong, nonatomic) NSString *title;   //标题
@property (strong, nonatomic) NSString *normalImage; // 普通状态图片
@property (strong, nonatomic) NSString *selectedImage; // 选中状态图片
@property (strong, nonatomic) UIColor *normalColor; // 普通状态颜色
@property (strong, nonatomic) UIColor *selectedColor; //选中状态颜色

@end
