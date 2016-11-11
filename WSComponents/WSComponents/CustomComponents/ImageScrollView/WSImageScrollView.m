//
//  AcImageScrollView.m
//  广告循环滚动效果
//
//  Created by wrs on 15/4/20.
//  Copyright (c) 2015年 Qzy. All rights reserved.
//

#import "WSImageScrollView.h"
#import "WSBaseMacro.h"
#import "WSComponents.h"
#import "UIView+WSBaseUtil.h"
#import "UIImageView+WebCache.h"

#define IMAGECHANGE_TIME    5.0

@interface WSImageScrollView () <UIScrollViewDelegate>
{
    BOOL isFirst;
    int currentInex;
    //循环滚动的周期时间
    NSTimer * _moveTime;
    //用于确定滚动式由人导致的还是计时器到了,系统帮我们滚动的,YES,则为系统滚动,NO则为客户滚动(ps.在客户端中客户滚动一个广告后,这个广告的计时器要归0并重新计时)
    BOOL _isTimeUp;
}

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (retain, nonatomic) UIImageView * leftImageView;
@property (retain, nonatomic) UIImageView * centerImageView;
@property (retain, nonatomic) UIImageView * rightImageView;
@property (retain, nonatomic) NSArray *imageNameArray;

@end

@implementation WSImageScrollView

+ (instancetype)getView
{
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:WSCOMPONENTS_BUNDLE withExtension:@"bundle"]];
    NSArray *array = [bundle loadNibNamed:@"WSImageScrollView" owner:nil options:nil];
    return [array firstObject];
}

- (void)awakeFromNib
{
    currentInex = 1;
    _scrollView.delegate = self;
 
    // 区域太小，没做点击事件
   // [_pageControl addTarget:self action:@selector(pageControlDidClick:) forControlEvents:UIControlEventValueChanged];

    isFirst = YES;
    _scrollView.bounces = NO;
    
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    
    _leftImageView = [[UIImageView alloc]init];
    _centerImageView = [[UIImageView alloc]init];
    _rightImageView = [[UIImageView alloc]init];
    NSArray *imageViewArray = @[_leftImageView, _centerImageView, _rightImageView];
    NSInteger itemCount = imageViewArray.count;
    for (int i = 0; i < itemCount; i++) {
        UIImageView *view = [imageViewArray objectAtIndex:i];
        view.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestAction:)];
        [view addGestureRecognizer:tapGest];
        view.contentMode = UIViewContentModeScaleAspectFit;
         [_containerView addSubview:view];
    }
    [_containerView constrainSubViewsForHorizontalAverage:imageViewArray];
    
    _moveTime = [NSTimer scheduledTimerWithTimeInterval:IMAGECHANGE_TIME target:self selector:@selector(animalMoveImage) userInfo:nil repeats:YES];
    _isTimeUp = NO;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (isFirst) {
        CGRect bounds = _scrollView.bounds;
        _scrollView.contentOffset = CGPointMake(bounds.size.width, 0);
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 3, bounds.size.height);
        isFirst = !isFirst;
    }
}

#pragma mark - tapGestAction
- (void)tapGestAction:(UITapGestureRecognizer *)tapGest
{
//    NSLog(@"tap index:%d", currentInex);
    
    NSInteger imageCount = _imageNameArray.count;
    // 修复只有一张图片时，currentIndex = 1
    if (imageCount == 1) {
        if (_callback) {
            _callback(0);
        }
    } else if (_callback) {
        _callback(currentInex);
    }
}

- (void)setImageData:(NSArray *)imageNames
{
    _pageControl.hidden = NO;
    _scrollView.scrollEnabled = YES;
    
    
    self.imageNameArray = imageNames;

    NSUInteger imageCount = _imageNameArray.count;
    currentInex = 0;
    if (imageCount == 0) {
        
    } else if (imageCount == 1) {
        
        [self setImageWithLeft:0 center:currentInex right:0];
        _pageControl.hidden = YES;
        _scrollView.scrollEnabled = NO;
        [_moveTime invalidate];
    } else if (imageCount == 2){
        _pageControl.hidden = NO;
        _scrollView.scrollEnabled = YES;
       [self setImageWithLeft:1 center:currentInex right:currentInex + 1];
    } else {
        _pageControl.hidden = NO;
        _scrollView.scrollEnabled = YES;
        [self setImageWithLeft:imageCount - 1 center:currentInex right:currentInex + 1];
    }
    _pageControl.currentPage = currentInex;
    _pageControl.numberOfPages = imageCount;
    
}

#pragma mark - 计时器到时,系统滚动图片
- (void)animalMoveImage
{
    [_scrollView setContentOffset:CGPointMake(_scrollView.bounds.size.width * 2, 0) animated:YES];
    _isTimeUp = YES;
    [NSTimer scheduledTimerWithTimeInterval:0.4f target:self selector:@selector(scrollViewDidEndDecelerating:) userInfo:nil repeats:NO];
}


#pragma mark - 图片停止时,调用该函数使得滚动视图复用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
      //DLog(@"before center index:%d", currentInex);
    NSUInteger imageCount =  _imageNameArray.count;
    if (imageCount == 0) {
        return;
    }
    
    // 向右滚动
    if (_scrollView.contentOffset.x == 0)
    {
        if (currentInex == 0) {
            currentInex = (int)imageCount - 1;
        } else {
            currentInex = (currentInex - 1) % imageCount;
        }
        _pageControl.currentPage = currentInex;
    
    // 向左滚动
    } else if (_scrollView.contentOffset.x == _scrollView.bounds.size.width * 2) {
        currentInex = (currentInex + 1) % imageCount;
        _pageControl.currentPage = currentInex;
    } else {
        return;
    }
    
    NSInteger leftIndex = (currentInex - 1) % imageCount;
    NSInteger centerIndex = currentInex % imageCount;
    NSInteger rightIndex = (currentInex + 1) % imageCount;
    
    // 修正只有三张图片时的bug
    if (centerIndex == 0) {
        leftIndex = imageCount - 1;
        rightIndex = 1;
    }
    
    if (imageCount == 0) {
        
    } else if (imageCount == 1) {
       
        [self setImageWithLeft:0 center:0 right:0];
    } else if (imageCount == 2){
        [self setImageWithLeft:leftIndex center:centerIndex right:leftIndex];
    } else {
      [self setImageWithLeft:leftIndex center:centerIndex right:rightIndex];
    }
    
    
    _scrollView.contentOffset = CGPointMake(_scrollView.bounds.size.width, 0);
    
    //手动控制图片滚动应该取消那个三秒的计时器
    if (!_isTimeUp) {
        [_moveTime setFireDate:[NSDate dateWithTimeIntervalSinceNow:IMAGECHANGE_TIME]];
    }
    _isTimeUp = NO;
}

- (void)setImageWithLeft:(NSInteger)left center:(NSInteger)center right:(NSInteger)right
{
    NSString *leftURL = [_imageNameArray objectAtIndex:left];
    NSString *centerURL = [_imageNameArray objectAtIndex:center];
    NSString *rightURL = [_imageNameArray objectAtIndex:right];
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:leftURL] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
       // DLog(@"第%d张图片下载完", (int)left);
        [self downloadImageFinishCallBack:left image:image];

    }];
    [_centerImageView sd_setImageWithURL:[NSURL URLWithString:centerURL] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
       [self downloadImageFinishCallBack:center image:image];
    }];
    [_rightImageView sd_setImageWithURL:[NSURL URLWithString:rightURL] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
     [self downloadImageFinishCallBack:right image:image];
    }];
}

- (void)downloadImageFinishCallBack:(NSInteger)index image:(UIImage *)image
{
    if (_downloadImageFinish) {
        _downloadImageFinish(index, image);
    }
}

@end
