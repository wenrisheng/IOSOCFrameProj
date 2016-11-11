//
//  WSQrCodeUtil.h
//  WSBase
//
//  Created by wenrisheng on 16/5/30.
//  Copyright © 2016年 wenrisheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSQrCodeUtil : NSObject

+ (UIImage *)getImageWithQrCode:(NSString *)qrCode size:(CGFloat)size;

@end
