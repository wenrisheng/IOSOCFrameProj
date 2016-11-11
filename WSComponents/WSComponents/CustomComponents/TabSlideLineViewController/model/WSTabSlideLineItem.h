//
//  WSSllideLineItem.h
//  WSComponents
//
//  Created by wenrisheng on 16/5/24.
//  Copyright © 2016年 wenrisheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSTabSlideLineItem : NSObject

@property (strong, nonatomic) UIViewController *viewController; // ViewController
@property (strong, nonatomic) NSString *title;   //标题
@property (strong, nonatomic) UIColor *normalColor; // 普通状态颜色
@property (strong, nonatomic) UIColor *selectedColor; //选中状态颜色
@property (strong, nonatomic) UIView *tapView;
@property (assign, nonatomic) BOOL isLoadView;

@end
