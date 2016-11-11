//
//  AcImageScrollView.h
//  广告循环滚动效果
//
//  Created by wrs on 15/4/20.
//  Copyright (c) 2015年 Qzy. All rights reserved.
//

#import <UIKit/UIKit.h>


//[[SDImageCache sharedImageCache] clearDisk];
//
//[[SDImageCache sharedImageCache] clearMemory];


typedef void(^WSImageScrollViewCallBack)(int index);

@interface WSImageScrollView : UIView

@property (copy) void(^downloadImageFinish)(NSInteger index, UIImage *image);

+ (instancetype)getView;

- (void)setImageData:(NSArray *)imageNames;

@property (strong, nonatomic) WSImageScrollViewCallBack callback;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end
