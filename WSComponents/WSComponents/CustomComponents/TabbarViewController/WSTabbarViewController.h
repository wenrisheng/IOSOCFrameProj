//
//  CSTabbarViewController.h
//  CustomTabbarViewController
//
//  Created by wenrisheng on 16/1/14.
//  Copyright © 2016年 wenrisheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSTabbarItemView.h"
#import "WSTabbarItem.h"
#import "WSTabbarItemView.h"

#define TABBARITEM_TITLE_COLOR_NORMAL_DEFAULT          [UIColor colorWithRed:0.486 green:0.486 blue:0.490 alpha:1.000]                  // 正常状态标题默认颜色
#define TABBARITEM_TITLE_COLOR_SELECTED_DEFAULT        [UIColor colorWithRed:0.494 green:0.176 blue:0.710 alpha:1.000]                    // 选中状态标题默认颜色

typedef enum WSTabbarViewControllerDirection: NSUInteger {
    WSTabbarViewControllerDirectionLeft,
    WSTabbarViewControllerDirectionRight,
    WSTabbarViewControllerDirectionLeftNone
} WSTabbarViewControllerDirection;

@class WSTabbarViewController;
@protocol WSTabbarViewControllerDataSource <NSObject>
@required
- (NSInteger)numberOfViewControllersInTabbarViewController:(WSTabbarViewController *)tabbarViewController;

- (WSTabbarItem *)tabbarViewController:(WSTabbarViewController *)tabbarViewController itemForRowAtIndex:(NSInteger)index;

@end

@protocol WSTabbarViewControllerDelegate <NSObject>

@optional
/**
 *  选中tabbarItem
 *
 */
- (void)tabbarViewControllerDidSelected:(WSTabbarViewController *)tabbarController index:(NSInteger)index;

/**
 *  滑到第一个或最后一个viewController后再滑动手势后调用
 *
 */
- (void)tabbarViewControllerToTheEndScrolling:(WSTabbarViewController *)tabbarController direction:(WSTabbarViewControllerDirection)direction index:(NSInteger)index;

/**
 *  以下两个方法是补充当loadAllView为YES时或者callBackVCLifeCycle为NO时viewContoller的iewWillAppear,viewWillDidAppear,viewWillDisAppear,viewDidDisappear等方法不回调增加的
 *
 */
- (void)tabbarViewController:(WSTabbarViewController *)tabbarController viewAppear:(UIViewController *)viewController index:(NSInteger)index;

- (void)tabbarViewController:(WSTabbarViewController *)tabbarController viewDisAppear:(UIViewController *)viewController index:(NSInteger)index;

@end

@interface WSTabbarViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *borderView;

- (void)selectedIndex:(NSInteger)index;
- (WSTabbarItemView *)getTabbarItemView:(NSInteger)index;

@property (strong, nonatomic) UIColor *borderViewColor;
@property (assign, nonatomic) NSInteger initIndex; // 初次显示哪个tab,default is 0
@property (assign, nonatomic) BOOL loadAllView; // 一次性加载所有view,default is NO
@property (assign, nonatomic) BOOL callBackVCLifeCycle; // 是否回调viewCotroller的生命周期， default is NO
@property (strong, nonatomic) UIColor *titleNormalColor;
@property (strong, nonatomic) UIColor *titleSelectedColor;
@property (weak, nonatomic) id<WSTabbarViewControllerDataSource> dataSource;
@property (weak, nonatomic) id<WSTabbarViewControllerDelegate> delegate;

@end
