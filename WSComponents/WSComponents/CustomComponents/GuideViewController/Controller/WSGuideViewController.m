//
//  WSGuideViewController.m
//  SmartShopping
//
//  Created by wrs on 15/5/29.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import "WSGuideViewController.h"
#import "WSComponents.h"

@interface WSGuideViewController () <UIScrollViewDelegate>

@property (assign, nonatomic) NSInteger imageCount;
@property (assign, nonatomic) NSInteger curIndex;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerViewWithCon;

@end

@implementation WSGuideViewController
@synthesize imageCount, curIndex;


- (id)init
{
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:WSCOMPONENTS_BUNDLE withExtension:@"bundle"]];
    self = [super initWithNibName:[NSString stringWithUTF8String:object_getClassName(self)] bundle:bundle];
    if (self) {
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    curIndex = 0;
    imageCount = _imageArray.count;
    
    // 扩大contenView的宽度为scrollerView宽度的itemCout倍，用于支持scrollView的滚动
    NSLayoutConstraint *widthCon = [NSLayoutConstraint constraintWithItem:self.containerView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.contentScrollView attribute:NSLayoutAttributeWidth multiplier:imageCount constant:0.0];
    [self.contentScrollView addConstraint:widthCon];
    
    for (int i = 0; i < imageCount; i++) {
        NSString *imageName  = [_imageArray objectAtIndex:i];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:imageName];
        [_contentScrollView addSubview:imageView];
        CGRect rect = _contentScrollView.bounds;
        float width = rect.size.width;
        float height = rect.size.height;
        float x = i * width;
        float y = 0;
        imageView.frame = CGRectMake(x, y, width, height);
        imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
        if (i == imageCount - 1) {
            if (_endButImage) {
                UIButton *endBut = [UIButton buttonWithType:UIButtonTypeSystem];
                [endBut setBackgroundImage:[UIImage imageNamed:_endButImage] forState:UIControlStateNormal];
                [endBut addTarget:self action:@selector(endButAction:) forControlEvents:UIControlEventTouchUpInside];
                imageView.userInteractionEnabled = YES;
                [imageView addSubview:endBut];
                CGFloat endW = 110;
                CGFloat endH = 32;
                endBut.frame = CGRectMake((width - endW) / 2, height - endH - 50, endW, endH);
                endBut.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
            }
        }
        
//        imageView.translatesAutoresizingMaskIntoConstraints = NO;
//        NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0];
//        NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
//        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
//        NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_containerView attribute:NSLayoutAttributeRight multiplier:(1.0 * i / imageCount) constant:0.0];
//        [self.view addConstraints:@[width, height, top, left]];
    }
}

- (void)endButAction:(UIButton *)but
{
    if (_endCallBack) {
        _endCallBack();
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    CGSize size = _contentScrollView.contentSize;
    size.width = _contentScrollView.bounds.size.width * imageCount;
    _contentScrollView.contentSize = size;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  curIndex = scrollView.contentOffset.x / self.view.frame.size.width;
    
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if (!_endButImage) {
        if ([scrollView.panGestureRecognizer translationInView:scrollView.superview].x < 0) {
            if (curIndex == imageCount - 1) {
                if (_endCallBack) {
                    _endCallBack();
                }
            }
        }
    }
}

@end
