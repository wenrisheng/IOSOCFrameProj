//
//  WSImagePickerUtil.h
//  WSTestFace
//
//  Created by wenrisheng on 16/3/29.
//  Copyright © 2016年 wenrisheng. All rights reserved.
//

#import <UIKit/UIKit.h>

#define WSIMAGEPICKER_PHOTOLIBRARY_TITLE   @"从相册选取"
#define WSIMAGEPICKER_CAMERA_TITLE         @"拍照"
#define WSIMAGEPICKER_CANCEL_TITLE         @"取消"

@interface WSImagePicker : NSObject <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) UIViewController *viewController;
@property (strong, nonatomic) NSString *photoLibraryTitle;
@property (strong, nonatomic) NSString *cameraTitle;
@property (strong, nonatomic) NSString *cancelTitle;
@property (copy, nonatomic) void(^finishCallBack)(UIImage *image, NSURL *imageUrl, NSString *imageName, NSDictionary *info);
@property (copy, nonatomic) void(^cancelCallBack)(void);
@property (copy, nonatomic) void(^errorCallBack)(NSError *error);

/**
 *  从相册、相机中选择图片
 *
 */
+ (void)showActionSheetImagePickerWithViewController:(UIViewController *)viewController didFinishPicker:(void (^)(UIImage *image, NSURL *imageUrl, NSString *imageName, NSDictionary *info))finishCallBack cancelCallBack:(void (^)(void))cancelCallBack errorCallBack:(void (^)(NSError *error))errorCallBack;

/**
 *  打开相册、相机选择图片
 *
 */
+ (void)showImagePickerWithViewController:(UIViewController *)viewController imagePickerControllerSourceType:(UIImagePickerControllerSourceType)sourceType didFinishPicker:(void (^)(UIImage *image, NSURL *imageUrl, NSString *imageName, NSDictionary *info))finishCallBack cancelCallBack:(void (^)(void))cancelCallBack errorCallBack:(void (^)(NSError *error))errorCallBack;

@end
