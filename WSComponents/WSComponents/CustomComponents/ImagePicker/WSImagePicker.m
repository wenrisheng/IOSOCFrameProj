//
//  WSImagePickerUtil.m
//  WSTestFace
//
//  Created by wenrisheng on 16/3/29.
//  Copyright © 2016年 wenrisheng. All rights reserved.
//

#import "WSImagePicker.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/ALAsset.h>
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <AssetsLibrary/ALAssetsGroup.h>
#import <AssetsLibrary/ALAssetRepresentation.h>
#import <UIKit/UIKit.h>
#import "WSBase.h"

@interface WSImagePicker ()


@end

@implementation WSImagePicker

+ (instancetype)shareInstance
{
    static WSImagePicker *instance;
    static dispatch_once_t demoglobalclassonce;
    dispatch_once(&demoglobalclassonce, ^{
        instance = [[WSImagePicker alloc] init];
    });
    return instance;
}

+ (void)showActionSheetImagePickerWithViewController:(UIViewController *)viewController didFinishPicker:(void (^)(UIImage *image, NSURL *imageUrl, NSString *imageName, NSDictionary *info))finishCallBack cancelCallBack:(void (^)(void))cancelCallBack errorCallBack:(void (^)(NSError *error))errorCallBack
{
    WSImagePicker *imagePicker = [self shareInstance];
    imagePicker.viewController = viewController;
    imagePicker.finishCallBack = finishCallBack;
    imagePicker.cancelCallBack = cancelCallBack;
    imagePicker.errorCallBack = errorCallBack;
    [imagePicker showActionSheet];
}

+ (void)showImagePickerWithViewController:(UIViewController *)viewController imagePickerControllerSourceType:(UIImagePickerControllerSourceType)sourceType didFinishPicker:(void (^)(UIImage *, NSURL *, NSString *, NSDictionary *))finishCallBack cancelCallBack:(void (^)(void))cancelCallBack errorCallBack:(void (^)(NSError *))errorCallBack
{
    [self isAvailableWithImagePickerControllerSourceType:sourceType callBack:^(BOOL available, NSError *error) {
        if (available) {
            WSImagePicker *imagePicker = [self shareInstance];
            imagePicker.viewController = viewController;
            imagePicker.finishCallBack = finishCallBack;
            imagePicker.cancelCallBack = cancelCallBack;
            imagePicker.errorCallBack = errorCallBack;
            [imagePicker showImagePicker:sourceType];
        } else {
            errorCallBack(error);
        }
    }];
}

+ (void)isAvailableWithImagePickerControllerSourceType:(UIImagePickerControllerSourceType)sourceType callBack:(void(^)(BOOL, NSError *))callBack
{
    //检查相机模式是否可用
    if (![UIImagePickerController isSourceTypeAvailable:sourceType]) {
        callBack(NO, [NSError errorWithDomain:@"sourceType 不可访问" code:0 userInfo:nil]);
        return;
    }
    //获得相机模式下支持的媒体类型
    if (sourceType == UIImagePickerControllerSourceTypeCamera) {
        NSArray* availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        BOOL canTakePicture = NO;
        for (NSString* mediaType in availableMediaTypes) {
            if ([mediaType isEqualToString:(NSString*)kUTTypeImage]) {
                //支持拍照
                canTakePicture = YES;
                break;
            }
        }
        //检查是否支持拍照
        if (!canTakePicture) {
            callBack(NO, [NSError errorWithDomain:@"设备不支持拍照" code:0 userInfo:nil]);
            return;
        }
    }
    callBack(YES, nil);
}

- (void)showActionSheet
{
     [self dealTitle];
    if (IOS8ORLATER) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle: nil                                                                             message: nil                                                                       preferredStyle:UIAlertControllerStyleActionSheet];
        [alertController addAction: [UIAlertAction actionWithTitle:self.photoLibraryTitle style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self showImagePicker:UIImagePickerControllerSourceTypePhotoLibrary];
        }]];
        [alertController addAction: [UIAlertAction actionWithTitle:self.cameraTitle style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
             [self showImagePicker:UIImagePickerControllerSourceTypeCamera];
        }]];
        [alertController addAction: [UIAlertAction actionWithTitle:self.cancelTitle style: UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (_cancelCallBack) {
                _cancelCallBack();
            }
            [self clearProperties];
        }]];
        
        [self.viewController presentViewController: alertController animated: YES completion: nil];
    } else {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:nil
                                      delegate:self
                                      cancelButtonTitle:self.cancelTitle
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:self.photoLibraryTitle, self.cameraTitle,nil];
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        [actionSheet showInView:self.viewController.view];
    }
}

- (void)dealTitle
{
    self.photoLibraryTitle = self.photoLibraryTitle == nil ? WSIMAGEPICKER_PHOTOLIBRARY_TITLE : self.photoLibraryTitle;
    self.cameraTitle = self.cameraTitle == nil ? WSIMAGEPICKER_CAMERA_TITLE : self.cameraTitle;
    self.cancelTitle = self.cancelTitle == nil ? WSIMAGEPICKER_CANCEL_TITLE : self.cancelTitle;
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
            // 相册
        case 0:
        {
//             [self showImagePicker:UIImagePickerControllerSourceTypePhotoLibrary];
        }
            break;
            // 相机
        case 1:
        {
//            [self showImagePicker:UIImagePickerControllerSourceTypeCamera];
        }
            break;
        case 2:
        {
            if (_cancelCallBack) {
                _cancelCallBack();
            }
            [self clearProperties];
            return;
        }
            break;
        default:
            break;
    }
   
}

- (void)actionSheetCancel:(UIActionSheet *)actionSheet
{
    if (_cancelCallBack) {
        _cancelCallBack();
    }
    [self clearProperties];
}


- (void)showImagePicker:(UIImagePickerControllerSourceType)sourceType {
    UIImagePickerController *imagePickerVC = [[UIImagePickerController alloc] init];
    imagePickerVC.delegate = self;
    imagePickerVC.mediaTypes = @[(NSString *)kUTTypeImage];
    imagePickerVC.sourceType = sourceType;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.viewController presentViewController:imagePickerVC animated:YES completion:NULL];
};

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    UIImage *orgImage = info[UIImagePickerControllerOriginalImage];
    NSURL *imageURL = [info valueForKey:UIImagePickerControllerReferenceURL];
    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
    [assetslibrary assetForURL:imageURL resultBlock:^(ALAsset *myasset) {
        ALAssetRepresentation *representation = [myasset defaultRepresentation];
        NSString *fileName = [representation filename];
        if (_finishCallBack) {
            _finishCallBack(orgImage, imageURL, fileName, info);
        }
        [self clearProperties];
    } failureBlock:^(NSError *error){
        if (_finishCallBack) {
            _finishCallBack(orgImage, imageURL, nil, info);
        }
        [self clearProperties];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    if (_cancelCallBack) {
        _cancelCallBack();
    }
    [self clearProperties];
}

- (void)clearProperties
{
    self.viewController = nil;
    self.finishCallBack = nil;
    self.cancelCallBack = nil;
    self.errorCallBack = nil;
    self.photoLibraryTitle = nil;
    self.cameraTitle = nil;
    self.cancelTitle = nil;
}

@end
