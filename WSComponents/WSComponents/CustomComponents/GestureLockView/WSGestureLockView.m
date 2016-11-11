//
//  WSGestureLockView.m
//  WSComponents
//
//  Created by wenrisheng on 16/11/3.
//  Copyright © 2016年 wenrisheng. All rights reserved.
//

#import "WSGestureLockView.h"
#import "WSComponents.h"


#define WSGestureLock_Pwd_Key    @"WSGestureLock_Pwd_Key"

@interface WSGestureLockView ()

@property (strong, nonatomic) NSMutableArray *allButArray;
@property (strong, nonatomic) NSMutableArray *selectedButArray;
@property (strong, nonatomic) NSString *pwd;
@property (assign, nonatomic) NSInteger gestureRecognizerCount;
@property (assign, nonatomic)  CGPoint curTouchPosition;

@end

@implementation WSGestureLockView

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

- (void)initData
{
    self.selectedButArray = [NSMutableArray array];
    self.gestureRecognizerCount = 0;
    self.lineColor = [UIColor redColor];
    self.lineWidth = 5;
    self.rowNum = 3;
    self.border = 40;
    
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:WSCOMPONENTS_BUNDLE withExtension:@"bundle"]];
    self.normalImage = [UIImage imageWithContentsOfFile:[[bundle bundlePath] stringByAppendingPathComponent:@"gesture_unselected"]];
    self.selectedImage  = [UIImage imageWithContentsOfFile:[[bundle bundlePath] stringByAppendingPathComponent:@"gesture_selected"]];
   
}

- (void)layoutSubviews
{
    [super layoutSubviews];
     [self initAllBut];
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

#pragma mark ---- 绘制的整过过程 ----
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    self.curTouchPosition = [touch locationInView:self];
    UIButton *button = [self isSucceedExistButtonWithPosition:self.curTouchPosition];
    if (button) {
        button.selected = YES;
        [self.selectedButArray removeAllObjects];
        [self.selectedButArray addObject:button];
    }
   
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];

    UITouch *touch = [touches anyObject];
    self.curTouchPosition = [touch locationInView:self];
    UIButton *button = [self isSucceedExistButtonWithPosition:self.curTouchPosition];
    if (button) {
        button.selected = YES;
        //判读是否存在,如果存在,则不存储.
        if (![self isExistWithButton:button]) {
            [self.selectedButArray addObject:button];
        }
    }
    [self setNeedsDisplay];
}



-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    self.curTouchPosition = [touch locationInView:self];
    //根据selectedButtons这个数组生成nowButtonIndex
    [self producePwdWithSelectedButtons];
    

    [self resetDrawUI];
    
    //操作次数+1
    self.gestureRecognizerCount ++;
    
    //
    [self drawFinish];
}

- (void)resetDrawUI
{
    //所有的按钮设置为不活跃状态
    for (UIButton *button in self.allButArray) {
        button.selected = NO;
        
    }
    //selectedButtons删除所有的选定按钮
    [self.selectedButArray removeAllObjects];
    
    //重新绘制
    [self setNeedsDisplay];
}

#pragma mark --- 绘制贝塞尔曲线 ----

- (void)drawRect:(CGRect)rect{
    
    [super drawRect:rect];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    int i = 0;
    for (UIButton *button in self.selectedButArray) {
        if (i == 0) {
            [path moveToPoint:button.center];
        }else{
            [path addLineToPoint:button.center];
        }
        i++;
    }
    
    [path addLineToPoint:self.curTouchPosition];
    [self.lineColor set];
    [path setLineWidth:self.lineWidth];
    [path setLineJoinStyle:kCGLineJoinRound];
    [path stroke];
    
}

- (void)drawFinish
{
    if (self.passwordFinish) {
        self.passwordFinish(self.gestureRecognizerCount, self.pwd);
    }
}


- (void)producePwdWithSelectedButtons
{
    NSInteger selectedCount = self.selectedButArray.count;
    NSMutableString *tempStr = [NSMutableString string];
    for (int i = 0; i < selectedCount; i++) {
        UIButton *but = [self.selectedButArray objectAtIndex:i];
        NSInteger tag = but.tag;
        [tempStr appendFormat:@"%d", tag];
    }
    self.pwd = [NSString stringWithString:tempStr];
}

#pragma mark --- 判断某一个点是否在在某一个按钮之上,如果存在,那么就返回当前按钮;否则返回nil. ---
-(UIButton *)isSucceedExistButtonWithPosition:(CGPoint)position{
    for (UIButton *button in self.allButArray) {
        if (CGRectContainsPoint(button.frame, position)) {
            return button;
        }
    }
    return nil;
}

//查看selectedButtons是否存在某一个按钮

-(BOOL)isExistWithButton:(UIButton *)button{
    BOOL isExist = NO;
    for (UIButton *obj in self.selectedButArray) {
        if ([obj isEqual:button]) {
            isExist = YES;
        }
    }
    return isExist;
}


@end
