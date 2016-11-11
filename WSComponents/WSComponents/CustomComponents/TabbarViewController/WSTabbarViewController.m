//
//  CSTabbarViewController.m
//  CustomTabbarViewController
//
//  Created by wenrisheng on 16/1/14.
//  Copyright © 2016年 wenrisheng. All rights reserved.
//

#import "WSTabbarViewController.h"
#import "UIView+WSBaseUtil.h"
#import "WSComponents.h"

#define TABBAR_VIEW_IS_LOADED                          @"TABBAR_VIEW_IS_LOADED"
#define TABBAR_VIEWCONTROLLER_WRAPVIEW                 @"TABBAR_VIEWCONTROLLER_WRAPVIEW"
#define TABBAR_ITEM                                     @"TABBAR_ITEM"
#define TABBAR_ITEMVIEW                                 @"TABBAR_ITEMVIEW"

#define INIT_CURRENTINDEX     -1

@interface WSTabbarViewController () <WSTabbarItemViewDelegate, UIScrollViewDelegate>

@property (strong, nonatomic) NSMutableArray *modelArray;
@property (assign, nonatomic) NSInteger currentIndex;
@property (strong, nonatomic) NSMutableArray *tabbarItemViewArray;

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contenView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation WSTabbarViewController

- (id)init
{
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:WSCOMPONENTS_BUNDLE withExtension:@"bundle"]];
    self = [super initWithNibName:[NSString stringWithUTF8String:object_getClassName(self)] bundle:bundle];
    if (self) {
        self.loadAllView = NO;
        self.initIndex = 0;
        self.callBackVCLifeCycle = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUInteger itemsCount = [_dataSource numberOfViewControllersInTabbarViewController:self];
    self.modelArray = [NSMutableArray array];
    NSMutableArray *wrapViewArray = [NSMutableArray array];
    self.tabbarItemViewArray = [NSMutableArray array];

    for (int i = 0; i < itemsCount; i++) {
        NSMutableDictionary *model = [NSMutableDictionary dictionary];
        WSTabbarItem *tabbarItem = [_dataSource tabbarViewController:self itemForRowAtIndex:i];
        
        // init tabbarView
        WSTabbarItemView *tabbarItemView = [WSTabbarItemView getView];
        tabbarItemView.delegate = self;
        tabbarItemView.tag = i;
        tabbarItemView.imageView.image = [UIImage imageNamed:tabbarItem.normalImage];
        tabbarItemView.label.text = tabbarItem.title;;
        UIColor *textColor = tabbarItem.normalColor;
        textColor = nil == textColor ? _titleNormalColor : textColor;
        textColor = nil == textColor ? TABBARITEM_TITLE_COLOR_NORMAL_DEFAULT : textColor;
        tabbarItemView.label.textColor = textColor;
        [_bottomView addSubview:tabbarItemView];
        [self.tabbarItemViewArray addObject:tabbarItemView];
        [model setValue:tabbarItemView forKey:TABBAR_ITEMVIEW];
        [model setValue:tabbarItem forKey:TABBAR_ITEM];
        
        //wrapView作为 ViewController的view的superView,wrapView用于控制ViewController的view的frame
        UIView *wrapView = [[UIView alloc] init];
        wrapView.tag = i;
        [wrapViewArray addObject:wrapView];
        [self.contenView addSubview:wrapView];
        [model setValue:wrapView forKey:TABBAR_VIEWCONTROLLER_WRAPVIEW];
        
        // init viewController
        if (self.loadAllView) {
            UIViewController *viewController = tabbarItem.viewController;
            [self addChildViewController:viewController];
//            [viewController didMoveToParentViewController:self];
            UIView *view = viewController.view;
            [wrapView addSubview:view];
            [view expandToSuperView];
        }
        [model setValue:[NSNumber numberWithBool:NO] forKey:TABBAR_VIEW_IS_LOADED];
        
        [self.modelArray addObject:model];
    }
    [_bottomView constrainSubViewsForHorizontalAverage:self.tabbarItemViewArray];
    
    // 扩大contenView的宽度为scrollerView宽度的itemCout倍，用于支持scrollView的滚动
    NSLayoutConstraint *widthCon = [NSLayoutConstraint constraintWithItem:self.contenView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeWidth multiplier:itemsCount constant:0.0];
    [self.scrollView addConstraint:widthCon];
    [self.contenView constrainSubViewsForHorizontalAverage:wrapViewArray];
    
    self.currentIndex = INIT_CURRENTINDEX;
   
    [self.bottomView bringSubviewToFront:self.borderView];
    if (_borderViewColor) {
        self.borderView.backgroundColor = _borderViewColor;
    }
   
#ifdef __IPHONE_7_0
    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 7) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
#endif

    self.currentIndex = _initIndex;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (WSTabbarItemView *)getTabbarItemView:(NSInteger)index
{
   return [self.tabbarItemViewArray objectAtIndex:index];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    NSInteger curIndex = self.currentIndex;
    self.currentIndex = INIT_CURRENTINDEX;
    [self selectedIndex:curIndex];

}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

- (BOOL)shouldAutorotate
{
    return NO;
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

/**
 *  减速时调用
 *
 *  @param scrollView
 */
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if ([_delegate respondsToSelector:@selector(tabbarViewControllerToTheEndScrolling:direction:index:)]) {
        NSInteger itemCount = [_dataSource numberOfViewControllersInTabbarViewController:self];
        if (self.currentIndex == itemCount - 1 || self.currentIndex == 0) { // 在第一个一个ViewController或最后一个ViewController
            WSTabbarViewControllerDirection direction = [self getDirection:scrollView];
            [_delegate tabbarViewControllerToTheEndScrolling:self direction:direction index:self.currentIndex];
        }
    }
  
}

- (WSTabbarViewControllerDirection)getDirection:(UIScrollView *)scrollView
{
    // 相对上次的偏移量
    CGPoint point = [scrollView.panGestureRecognizer translationInView:scrollView.superview];
    if (point.x < 0) { // 向左滑动
        return WSTabbarViewControllerDirectionLeft;
    } else if (point.x > 0) { // 向左滑动
        return WSTabbarViewControllerDirectionRight;
    } else {
        return WSTabbarViewControllerDirectionLeftNone;
    }
}

#pragma mark - CTTabbarItemViewDelegate
- (void)clickTabbarItemView:(WSTabbarItemView *)tabbarItemView
{
    NSInteger tag = tabbarItemView.tag;
    CGPoint contentOffset = self.scrollView.contentOffset;
    CGSize contentSize = self.scrollView.contentSize;
    NSInteger itemCount = [_dataSource numberOfViewControllersInTabbarViewController:self];
    CGFloat itemWidth = contentSize.width / itemCount;
    contentOffset.x = tag * itemWidth;
    self.scrollView.contentOffset = contentOffset;
   
}

- (void)selectedIndex:(NSInteger)index
{
 if (self.currentIndex != index) {
     // 改变 ViewController
     [self changeContentViewStatus:index];
     
     CGPoint contentOffset = self.scrollView.contentOffset;
     CGSize contentSize = self.scrollView.contentSize;
     NSInteger itemCount = [_dataSource numberOfViewControllersInTabbarViewController:self];
     contentOffset.x = index * contentSize.width / itemCount;
     self.scrollView.contentOffset = contentOffset;
     
     [self changeTabbarStatus:index];
     
     
     self.currentIndex = index;
     // 回调代理事件
     if ([_delegate respondsToSelector:@selector(tabbarViewControllerDidSelected:index:)]) {
         [_delegate tabbarViewControllerDidSelected:self index:self.currentIndex];
     }
 }
}

#pragma mark -
- (void)changeContentViewStatus:(NSInteger)index
{
    if (!self.loadAllView) {
        // 移走oldModel的view主要是让viewController自动调用自身的viewWillAppear,viewWillDidAppear,viewWillDisAppear,viewDidDisappear方法
        NSInteger count = self.modelArray.count;
        if (self.currentIndex < count) {
            NSMutableDictionary *oldModel = [self.modelArray objectAtIndex:self.currentIndex];
            [oldModel setObject:[NSNumber numberWithBool:NO] forKey:TABBAR_VIEW_IS_LOADED];
            if (self.callBackVCLifeCycle) {
                WSTabbarItem *oldTabbarItem = [oldModel objectForKey:TABBAR_ITEM];
                UIViewController *viewController = oldTabbarItem.viewController;
                [viewController willMoveToParentViewController:nil];
                UIView *view = viewController.view;
                [view removeFromSuperview];
                [viewController removeFromParentViewController];
            }
        }
        NSMutableDictionary *newModel = [self.modelArray objectAtIndex:index];
        WSTabbarItem *newTabbarItem = [newModel objectForKey:TABBAR_ITEM];
        BOOL isLoad = [[newModel objectForKey:TABBAR_VIEW_IS_LOADED] boolValue];
        if (!isLoad) {
            UIViewController *viewController = newTabbarItem.viewController;
            [self addChildViewController:viewController];
            UIView *view = viewController.view;
            UIView *wrapView = [newModel objectForKey:TABBAR_VIEWCONTROLLER_WRAPVIEW];
            [wrapView addSubview:view];
            [view expandToSuperView];
            [viewController didMoveToParentViewController:self];
            [newModel setObject:[NSNumber numberWithBool:YES] forKey:TABBAR_VIEW_IS_LOADED];
        }
    }
    
    // 视图消失回调
    if ([_delegate respondsToSelector:@selector(tabbarViewController:viewDisAppear:index:)]) {
        NSMutableDictionary *oldModel = [self.modelArray objectAtIndex:self.currentIndex];
        WSTabbarItem *oldTabbarItem = [oldModel objectForKey:TABBAR_ITEM];
        
        [_delegate tabbarViewController:self viewDisAppear:oldTabbarItem.viewController index:self.currentIndex];
    }
    
    // 视图出现回调
    if ([_delegate respondsToSelector:@selector(tabbarViewController:viewAppear:index:)]) {
        NSMutableDictionary *newModel = [self.modelArray objectAtIndex:index];
        WSTabbarItem *newTabbarItem = [newModel objectForKey:TABBAR_ITEM];
        [_delegate tabbarViewController:self viewAppear:newTabbarItem.viewController index:index];
    }
}

- (void)changeTabbarStatus:(NSInteger)index
{
    NSInteger count = self.modelArray.count;
    if (self.currentIndex < count && self.currentIndex >= 0) {
        // 上一个TabbarItemView 恢复正常状态
        NSMutableDictionary *oldModel = [self.modelArray objectAtIndex:self.currentIndex];
        WSTabbarItem *oldTabbarItem = [oldModel objectForKey:TABBAR_ITEM];
        WSTabbarItemView *olderTabbarItemView = [oldModel objectForKey:TABBAR_ITEMVIEW];
        olderTabbarItemView.imageView.image = [UIImage imageNamed:oldTabbarItem.normalImage];
        UIColor *oldTextColor = oldTabbarItem.normalColor;
        oldTextColor = nil == oldTextColor ? _titleNormalColor : oldTextColor;
        oldTextColor = nil == oldTextColor ? TABBARITEM_TITLE_COLOR_NORMAL_DEFAULT : oldTextColor;
        olderTabbarItemView.label.textColor = oldTextColor;
    }
    
     // 当前TabbarItemView 作为选中状态
    NSMutableDictionary *newModel = [self.modelArray objectAtIndex:index];
     WSTabbarItem *newTabbarItem = [newModel objectForKey:TABBAR_ITEM];
    WSTabbarItemView *nweTabbarItemView = [newModel objectForKey:TABBAR_ITEMVIEW];
    nweTabbarItemView.imageView.image = [UIImage imageNamed:newTabbarItem.selectedImage];
    UIColor *nweTextColor = newTabbarItem.selectedColor;
    nweTextColor = nil == nweTextColor ?  _titleSelectedColor : nweTextColor;
    nweTextColor = nil == nweTextColor ? TABBARITEM_TITLE_COLOR_SELECTED_DEFAULT : nweTextColor;
    nweTabbarItemView.label.textColor = nweTextColor;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
