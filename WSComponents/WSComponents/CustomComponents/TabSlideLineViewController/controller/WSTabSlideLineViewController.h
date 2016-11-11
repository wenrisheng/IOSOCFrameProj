//
//  WSTabSlideLineViewControllerViewController.h
//  WSComponents
//
//  Created by wenrisheng on 16/5/24.
//  Copyright © 2016年 wenrisheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSTabSlideLineItem.h"

#define TABBUTITEM_TITLE_COLOR_NORMAL_DEFAULT          [UIColor colorWithRed:0.486 green:0.486 blue:0.490 alpha:1.000]                  // 正常状态标题默认颜色
#define TABBUTITEM_TITLE_COLOR_SELECTED_DEFAULT        [UIColor colorWithRed:0.494 green:0.176 blue:0.710 alpha:1.000]                    // 选中状态标题默认颜色

@class WSTabSlideLineViewController;

@protocol WSTabSlideLineViewControllerDataSource <NSObject>

@required
- (NSInteger)numberOfViewControllersInTabbarViewController:(WSTabSlideLineViewController *)tabbarViewController;

- (WSTabSlideLineItem *)tabbarViewController:(WSTabSlideLineViewController *)tabbarViewController itemForRowAtIndex:(NSInteger)index;

@end

@interface WSTabSlideLineViewController : UIViewController

@property (assign, nonatomic) NSInteger initIndex;
@property (assign, nonatomic) BOOL loadAllView; // 一次性加载所有view
@property (strong, nonatomic) UIColor *titleNormalColor;
@property (strong, nonatomic) UIColor *titleSelectedColor;
@property (weak, nonatomic) id<WSTabSlideLineViewControllerDataSource> dataSource;
@property (weak, nonatomic) IBOutlet UIView *borderView;
@property (weak, nonatomic) IBOutlet UIView *borderWrapView;


@end
