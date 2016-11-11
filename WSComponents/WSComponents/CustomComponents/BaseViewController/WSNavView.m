//
//  WSNavView.m
//  WSComponents
//
//  Created by wenrisheng on 16/5/6.
//  Copyright © 2016年 wenrisheng. All rights reserved.
//

#import "WSNavView.h"
#import "WSComponents.h"

@implementation WSNavView

+ (instancetype)getView
{
    WSNavView *navView = [[[NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:WSCOMPONENTS_BUNDLE withExtension:@"bundle"]] loadNibNamed:@"WSNavView" owner:nil options:nil] firstObject];
    return navView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
