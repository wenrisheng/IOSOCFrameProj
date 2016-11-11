//
//  WSNavViewController.m
//  WSComponents
//
//  Created by wenrisheng on 16/5/6.
//  Copyright © 2016年 wenrisheng. All rights reserved.
//

#import "WSBaseNavViewController.h"
#import "WSComponents.h"

@interface WSBaseNavViewController ()

@end

@implementation WSBaseNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView = [WSNavView getView];
   
    [self.navView.backBut addTarget:self action:@selector(navBackButAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.navView.rightBut addTarget:self action:@selector(navRightButAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navView.rightBut.hidden = YES;
    [self.view addSubview:self.navView];
    self.navView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *leftCon = [NSLayoutConstraint constraintWithItem:self.navView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
    NSLayoutConstraint *rightCon = [NSLayoutConstraint constraintWithItem:self.navView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0];
    NSLayoutConstraint *topCon = [NSLayoutConstraint constraintWithItem:self.navView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
    NSLayoutConstraint *heightCon = [NSLayoutConstraint constraintWithItem:self.navView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:64.0];
    [self.view addConstraints:@[leftCon, rightCon, topCon, heightCon]];
    if (self.title) {
        self.navView.titleLabel.text = self.title;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 导航栏按钮事件
- (void)navBackButAction:(UIButton *)but
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)navRightButAction:(UIButton *)but
{
    
}

@end
