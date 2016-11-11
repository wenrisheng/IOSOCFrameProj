//
//  WSTabSlideLineItemView.h
//  WSComponents
//
//  Created by wenrisheng on 16/5/24.
//  Copyright © 2016年 wenrisheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WSTabSlideLineItemView;
@protocol WSTabSlideLineItemViewDelegate <NSObject>

@optional
- (void)tabSlideLineItemViewClick:(WSTabSlideLineItemView *)itemView;

@end

@interface WSTabSlideLineItemView : UIView

+ (instancetype)getView;

- (IBAction)butAction:(id)sender;

@property (weak, nonatomic) id<WSTabSlideLineItemViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *but;

@end
