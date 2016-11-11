//
//  BaseStaticHeader.h
//  BaseStaticLibrary
//
//  Created by wrs on 15/4/11.
//  Copyright (c) 2015年 wrs. All rights reserved.
//  WSBase 放在项目同等级目录下，在项目的Building Setting -> User Header Search Paths增加一项$(PROJECT_DIR)/../WSBase来搜索WSBase的头文件，在项目中引入WSBase。h文件即可，将WSBase的$(SRCROOT)路劲下的WSBaseResource文件拖入项目中
//

#ifndef BaseStaticLibrary_BaseStaticHeader_h
#define BaseStaticLibrary_BaseStaticHeader_h


/*************常用工具类、宏**************/
#import "WSBaseMacro.h"

/************Util**************/
#import "WSBaseUtil.h"
#import "WSCalendarUtil.h"
#import "WSIdentifierValidator.h"
#import "WSPathUtil.h"
#import "WSDictionaryUtil.h"
#import "WSJsonUtil.h"
#import "WSArchiveUtil.h"
#import "WSBundleUtil.h"
#import "WSFileUtil.h"
#import "PinyinHelper.h"
#import "WSDeviceUtil.h"
//#import "WSQrCodeUtil.h"
// 加密
#import "MDUtil.h"
#import "DESUtil.h"
#import "RSAUtil.h"
#import "AES.h"
#import "RSA.h"

// 多语言切换
#import "NSString+WSInternationControl.h"

/****************Category******************/
#import "UIButton+WSEnlargeResponseDomain.h"
#import "NSDictionary+WSBaseUtil.h"
#import "UIImage+WSResizable.h"
#import "UIImage+ColorAtPixel.h"
#import "UIView+WSBaseUtil.h"
#import "UILabel+WSBaseUtil.h"
#import "NSString+WSBaseUtil.h"
#import "UIImage+Impress.h"
#import "UITableView+WSGetCell.h"
#import "UITableViewCell+WSGetCell.h"
#import "NSObject+WSClass.h"

/*********************CustomView************************/
#import "WSDesignableView.h"
#import "WSDesignableLabel.h"
#import "WSDesignableButton.h"
#import "WSDesignableImageView.h"
#import "WSDesignableTextField.h"

/***************CustomComponents*****************/
//#import "WSBaseNavigationController.h"
//#import "WSBaseViewController.h"
//#import "WSImagePicker.h"
//#import "WSActionSheet.h"

#endif
