//
//  BaseViewController.m
//  BaseStaticLibrary
//
//  Created by wrs on 15/4/11.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import "WSBaseViewController.h"
#import "WSBaseMacro.h"

@interface WSBaseViewController ()

@end

@implementation WSBaseViewController

- (void)dealloc
{
    DLog(@"----------%@  dealloc---------", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
#ifdef __IPHONE_7_0
   if ([[[UIDevice currentDevice] systemVersion] floatValue] > 7) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
#endif
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
