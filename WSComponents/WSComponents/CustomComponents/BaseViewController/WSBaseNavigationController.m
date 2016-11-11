//
//  WSBaseNavigationController.m
//  BaseStaticLibrary
//
//  Created by wrs on 15/4/19.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import "WSBaseNavigationController.h"

@interface WSBaseNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation WSBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
   
#ifdef __IPHONE_7_0
     if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
         self.interactivePopGestureRecognizer.delegate = self;
     }
#endif
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (BOOL)shouldAutorotate
{
    return self.topViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return self.topViewController.supportedInterfaceOrientations;
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.viewControllers.count == 1) {
        return NO;
    } else {
        return YES;
    }
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
