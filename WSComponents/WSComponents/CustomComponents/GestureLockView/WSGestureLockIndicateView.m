//
//  WSGestureLockIndicateView.m
//  WSComponents
//
//  Created by wenrisheng on 16/11/3.
//  Copyright © 2016年 wenrisheng. All rights reserved.
//

#import "WSGestureLockIndicateView.h"
#import "WSComponents.h"

@interface WSGestureLockIndicateView ()

@property (strong, nonatomic) NSMutableArray *allButArray;

@end

@implementation WSGestureLockIndicateView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initData];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self initAllBut];
}


- (void)initData
{
    self.rowNum = 3;
    self.border = 5;
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:WSCOMPONENTS_BUNDLE withExtension:@"bundle"]];
    self.normalImage = [UIImage imageWithContentsOfFile:[[bundle bundlePath] stringByAppendingPathComponent:@"gesture_unselected"]];
    self.selectedImage  = [UIImage imageWithContentsOfFile:[[bundle bundlePath] stringByAppendingPathComponent:@"gesture_selected"]];
}

- (void)initAllBut
{
    if (self.width == 0) {
        self.width = (CGRectGetWidth(self.bounds) - (self.rowNum - 1) * self.border) / self.rowNum;
    }
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
    self.allButArray = [NSMutableArray array];
    for (int i = 0; i < _rowNum; i++) {
        for (int j = 0; j < _rowNum; j++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];;
            [button setBackgroundImage:self.normalImage forState:UIControlStateNormal];
            [button setBackgroundImage:self.selectedImage forState:UIControlStateSelected];
            button.userInteractionEnabled = NO;
            CGFloat X = ((_width + _border) * j);
            CGFloat Y = ((_width + _border) * i);
            button.frame = CGRectMake(X, Y, _width, _width);
             button.tag = j + i * _rowNum;
            [self addSubview:button];
            [self.allButArray addObject:button];
        }
    }
}

- (void)setPwd:(NSString *)pwd
{
    NSInteger length = pwd.length;
    for (UIButton *but in self.allButArray) {
        but.selected = NO;
    }
    
    for (int i = 0; i < length; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *subStr = [pwd substringWithRange:range];
        NSInteger index = [subStr integerValue];
        for (UIButton *but in self.allButArray) {
            NSInteger tag = but.tag;
            if (index == tag) {
                NSLog(@"相等:%d", tag);
                but.selected = YES;
                break;
            }
        }
        
    }

}

@end
