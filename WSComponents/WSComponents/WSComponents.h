//
//  WSThirdComponents.h
//  WSThirdComponents
//
//  Created by wrs on 15/9/11.
//  Copyright (c) 2015年 wrs. All rights reserved.
/*  WSComponents 放在项目同等级目录下，依赖于WSBase，并且添加pod依赖：
 
xcodeproj '../WSComponents/WSComponents'
 
# WSComponents
target :WSComponents do
    pod 'SDWebImage'
    xcodeproj '../WSComponents/WSComponents'
end
 
在项目的Building Setting -> User Header Search Paths增加一项
 $(PROJECT_DIR)/../WSComponents
 来搜索WSComponents的头文件，在项目中引入WSComponents.h文件即可，将WSComponents的$(SRCROOT)路劲下的WSComponentsBundle文件拖入项目中
*/
#ifndef WSComponents_WSThirdComponents_h
#define WSComponents_WSThirdComponents_h

#define WSCOMPONENTS_BUNDLE    @"WSComponentsBundle"

/**************CustomComponents**********************/
#import "WSBaseNavigationController.h"
#import "WSBaseViewController.h"
#import "WSBaseNavViewController.h"
#import "WSImagePicker.h"
#import "WSAlertView.h"
#import "WSImageScrollView.h"
#import "WSTabbarViewController.h"
#import "WSTabSlideLineViewController.h"
#import "WSGuideViewController.h"
#import "WSGestureLockView.h"
#import "WSGestureLockIndicateView.h"

/*************ThirdComponents*************/
#import "CHTCollectionViewWaterfallLayout.h"
#import "QRCodeGenerator.h"
#import "SVProgressHUD.h"
#import "UIView+Toast.h"
#import "MJRefresh.h"
#import "PECropViewController.h"
#import "LBorderView.h"

#endif
