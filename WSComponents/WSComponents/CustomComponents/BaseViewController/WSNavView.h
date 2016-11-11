//
//  WSNavView.h
//  WSComponents
//
//  Created by wenrisheng on 16/5/6.
//  Copyright © 2016年 wenrisheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSNavView : UIView

+ (instancetype)getView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLayoutConst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backButWidthCon;
@property (weak, nonatomic) IBOutlet UIButton *backBut;
@property (weak, nonatomic) IBOutlet UIButton *rightBut;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightButWidthCon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backButHeightCon;

@end
