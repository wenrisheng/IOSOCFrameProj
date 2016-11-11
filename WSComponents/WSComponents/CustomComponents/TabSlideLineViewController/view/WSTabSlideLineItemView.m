//
//  WSTabSlideLineItemView.m
//  WSComponents
//
//  Created by wenrisheng on 16/5/24.
//  Copyright © 2016年 wenrisheng. All rights reserved.
//

#import "WSTabSlideLineItemView.h"
#import "WSComponents.h"

@implementation WSTabSlideLineItemView

+ (instancetype)getView
{
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:WSCOMPONENTS_BUNDLE withExtension:@"bundle"]];
    NSArray *array = [bundle loadNibNamed:@"WSTabSlideLineItemView" owner:nil options:nil];
    return [array firstObject];
}

- (IBAction)butAction:(id)sender {
    if ([_delegate respondsToSelector:@selector(tabSlideLineItemViewClick:)]) {
        [_delegate tabSlideLineItemViewClick:self];
    }
}

@end
