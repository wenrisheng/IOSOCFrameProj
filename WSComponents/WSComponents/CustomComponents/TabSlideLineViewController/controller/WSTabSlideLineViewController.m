//
//  WSTabSlideLineViewControllerViewController.m
//  WSComponents
//
//  Created by wenrisheng on 16/5/24.
//  Copyright © 2016年 wenrisheng. All rights reserved.
//

#import "WSTabSlideLineViewController.h"
#import "UIView+WSBaseUtil.h"
#import "WSTabSlideLineItem.h"
#import "WSTabSlideLineItemView.h"
#import "WSComponents.h"

#define WSTABSLIDELINEVC_TAPBUT            @"WSTABSLIDELINEVC_TAPBUT"
#define WSTABSLIDELINEVC_ITEM              @"WSTABSLIDELINEVC_ITEM"
#define WSTABSLIDELINEVC_VIEW_ISLOAD       @"WSTABSLIDELINEVC_VIEW_ISLOAD"
#define WSTABSLIDELINEVC_WRAP_VIEW         @"WSTABSLIDELINEVC_WRAP_VIEW"

#define INIT_CURRENTINDEX     -1

@interface WSTabSlideLineViewController () <UIScrollViewDelegate, WSTabSlideLineItemViewDelegate>

@property (strong, nonatomic) NSMutableArray *modelArray;
@property (assign, nonatomic) NSInteger currentIndex;

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;


@end

@implementation WSTabSlideLineViewController


- (id)init
{
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:WSCOMPONENTS_BUNDLE withExtension:@"bundle"]];
    self = [super initWithNibName:@"WSTabSlideLineViewController" bundle:bundle];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSUInteger itemsCount = [_dataSource numberOfViewControllersInTabbarViewController:self];
    self.modelArray = [NSMutableArray array];
    NSMutableArray *wrapViewArray = [NSMutableArray array];
    NSMutableArray *tapButArray = [NSMutableArray array];
    for (int i = 0; i < itemsCount; i++) {
        NSMutableDictionary *model = [NSMutableDictionary dictionary];
        WSTabSlideLineItem *item = [_dataSource tabbarViewController:self itemForRowAtIndex:i];
        
        // init tabbarView
        WSTabSlideLineItemView *itemView = [WSTabSlideLineItemView getView];
        itemView.delegate = self;
        itemView.tag = i;
        itemView.titleLabel.text = item.title;
        UIColor *textColor = item.normalColor;
        textColor = nil == textColor ? _titleNormalColor : textColor;
        textColor = nil == textColor ? TABBUTITEM_TITLE_COLOR_NORMAL_DEFAULT : textColor;
        itemView.titleLabel.textColor = textColor;
        [_topView addSubview:itemView];
        [tapButArray addObject:itemView];
        [model setValue:itemView forKey:WSTABSLIDELINEVC_TAPBUT];
        [model setValue:item forKey:WSTABSLIDELINEVC_ITEM];
        
        //wrapView作为 ViewController的view的superView,wrapView用于控制ViewController的view的frame
        UIView *wrapView = [[UIView alloc] init];
        wrapView.tag = i;
        [wrapViewArray addObject:wrapView];
        [self.contentView addSubview:wrapView];
        [model setValue:wrapView forKey:WSTABSLIDELINEVC_WRAP_VIEW];
        
        [model setValue:[NSNumber numberWithBool:NO] forKey:WSTABSLIDELINEVC_VIEW_ISLOAD];
        
        [self.modelArray addObject:model];
    }
//    [_topView constrainSubViewsForHorizontalAverage:tapButArray];
    
    // 扩大contenView的宽度为scrollerView宽度的itemCout倍，用于支持scrollView的滚动
    NSLayoutConstraint *widthCon = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeWidth multiplier:itemsCount constant:0.0];
    [self.scrollView addConstraint:widthCon];
    [self.contentView constrainSubViewsForHorizontalAverage:wrapViewArray];
    
    self.currentIndex = INIT_CURRENTINDEX;
    
    NSLayoutConstraint *borderViewWidthCon = [NSLayoutConstraint constraintWithItem:self.borderView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.topView attribute:NSLayoutAttributeWidth multiplier:1/itemsCount constant:0.0];
    [self.topView addConstraint:borderViewWidthCon];
    [self.topView bringSubviewToFront:self.borderWrapView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self selectedIndex:self.initIndex];
}

#pragma mark - WSTabSlideLineItemViewDelegate
- (void)tabSlideLineItemViewClick:(WSTabSlideLineItemView *)itemView
{
    NSInteger tag = itemView.tag;
    CGPoint contentOffset = self.scrollView.contentOffset;
    CGSize contentSize = self.scrollView.contentSize;
    NSInteger itemCount = [_dataSource numberOfViewControllersInTabbarViewController:self];
    CGFloat itemWidth = contentSize.width / itemCount;
    contentOffset.x = tag * itemWidth;
    self.scrollView.contentOffset = contentOffset;
}
- (void)tabButAction:(UIButton *)but
{
    NSInteger tag = but.tag;
    CGPoint contentOffset = self.scrollView.contentOffset;
    CGSize contentSize = self.scrollView.contentSize;
    NSInteger itemCount = [_dataSource numberOfViewControllersInTabbarViewController:self];
    CGFloat itemWidth = contentSize.width / itemCount;
    contentOffset.x = tag * itemWidth;
    self.scrollView.contentOffset = contentOffset;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint contentOffset = scrollView.contentOffset;
    CGSize contentSize = scrollView.contentSize;
    NSInteger itemCount = [_dataSource numberOfViewControllersInTabbarViewController:self];
    CGFloat itemWidth = contentSize.width / itemCount;
    CGFloat flag = contentOffset.x / itemWidth;
    int flagInt = flag;
    if (flagInt == flag) { // 当flag为整数时切换视图
        [self selectedIndex:flagInt];
    }
}

- (void)selectedIndex:(NSInteger)index
{
    if (self.currentIndex != index) {
        // 改变ViewController
        [self changeContentViewStatus:index];
        
        CGPoint contentOffset = self.scrollView.contentOffset;
        CGSize contentSize = self.scrollView.contentSize;
        NSInteger itemCount = [_dataSource numberOfViewControllersInTabbarViewController:self];
        contentOffset.x = index * contentSize.width / itemCount;
        self.scrollView.contentOffset = contentOffset;
        
        [self changeTabbarStatus:index];
        
        
        self.currentIndex = index;
        // 回调代理事件
//        if ([_delegate respondsToSelector:@selector(tabbarViewControllerDidSelected:index:)]) {
//            [_delegate tabbarViewControllerDidSelected:self index:self.currentIndex];
//        }
    }
}

#pragma mark -
- (void)changeContentViewStatus:(NSInteger)index
{
    if (!self.loadAllView) {
        if (self.currentIndex != INIT_CURRENTINDEX) {
            // 移走oldModel的view主要是让viewController自动调用自身的viewWillAppear,viewWillDidAppear,viewWillDisAppear,viewDidDisappear方法
            NSMutableDictionary *oldModel = [self.modelArray objectAtIndex:self.currentIndex];
            WSTabSlideLineItem *oldTabbarItem = [oldModel objectForKey:WSTABSLIDELINEVC_ITEM];
            UIViewController *viewController = oldTabbarItem.viewController;
            [viewController willMoveToParentViewController:nil];
            UIView *view = viewController.view;
            [view removeFromSuperview];
            [viewController removeFromParentViewController];
        }
        NSMutableDictionary *newModel = [self.modelArray objectAtIndex:index];
        WSTabSlideLineItem *newTabbarItem = [newModel objectForKey:WSTABSLIDELINEVC_ITEM];
        UIViewController *viewController = newTabbarItem.viewController;
        [self addChildViewController:viewController];
        UIView *view = viewController.view;
        UIView *wrapView = [newModel objectForKey:WSTABSLIDELINEVC_WRAP_VIEW];
        [wrapView addSubview:view];
        [view expandToSuperView];
        [viewController didMoveToParentViewController:self];
    }
    
//    if ([_delegate respondsToSelector:@selector(tabbarViewController:viewDisAppear:index:)]) {
//        NSMutableDictionary *oldModel = [self.modelArray objectAtIndex:self.currentIndex];
//        WSTabbarItem *oldTabbarItem = [oldModel objectForKey:TABBAR_ITEM];
//        
//        [_delegate tabbarViewController:self viewDisAppear:oldTabbarItem.viewController index:self.currentIndex];
//    }
//    if ([_delegate respondsToSelector:@selector(tabbarViewController:viewAppear:index:)]) {
//        NSMutableDictionary *newModel = [self.modelArray objectAtIndex:index];
//        WSTabbarItem *newTabbarItem = [newModel objectForKey:TABBAR_ITEM];
//        [_delegate tabbarViewController:self viewAppear:newTabbarItem.viewController index:index];
//    }
}

- (void)changeTabbarStatus:(NSInteger)index
{
    
    if (self.currentIndex != INIT_CURRENTINDEX) {
        // 上一个TabbarItemView 恢复正常状态
        NSMutableDictionary *oldModel = [self.modelArray objectAtIndex:self.currentIndex];
        WSTabbarItem *oldTabbarItem = [oldModel objectForKey:WSTABSLIDELINEVC_ITEM];
        WSTabSlideLineItemView *olderTabbarItemView = [oldModel objectForKey:WSTABSLIDELINEVC_TAPBUT];
        UIColor *oldTextColor = oldTabbarItem.normalColor;
        oldTextColor = nil == oldTextColor ? _titleNormalColor : oldTextColor;
        oldTextColor = nil == oldTextColor ? TABBUTITEM_TITLE_COLOR_NORMAL_DEFAULT : oldTextColor;
        olderTabbarItemView.titleLabel.textColor = oldTextColor;
        
    }
    
    // 当前TabbarItemView 作为选中状态
    NSMutableDictionary *newModel = [self.modelArray objectAtIndex:index];
    WSTabbarItem *newTabbarItem = [newModel objectForKey:WSTABSLIDELINEVC_ITEM];
    WSTabSlideLineItemView *nweTabbarItemView = [newModel objectForKey:WSTABSLIDELINEVC_TAPBUT];
    UIColor *nweTextColor = newTabbarItem.selectedColor;
    nweTextColor = nil == nweTextColor ?  _titleSelectedColor : nweTextColor;
    nweTextColor = nil == nweTextColor ? TABBUTITEM_TITLE_COLOR_SELECTED_DEFAULT : nweTextColor;
    nweTabbarItemView.titleLabel.textColor = nweTextColor;
    
    CGPoint butCenter = nweTabbarItemView.center;
    CGPoint center = _borderView.center;
    center.x = butCenter.x;
    _borderView.center = center;
}


@end
