//
//  WSActionSheet.m
//  WSBase
//
//  Created by wenrisheng on 16/4/27.
//  Copyright © 2016年 wenrisheng. All rights reserved.
//

#import "WSAlertView.h"
#import "WSBaseMacro.h"
#import <UIKit/UIKit.h>

@implementation WSAlertView

- (void)dealloc
{
    DLog(@"----------%@  dealloc---------", NSStringFromClass([self class]));

}

+ (instancetype)shareInstance
{
    static WSAlertView *instance;
    static dispatch_once_t demoglobalclassonce;
    dispatch_once(&demoglobalclassonce, ^{
        instance = [[WSAlertView alloc] init];
    });
    return instance;
}

+ (void)show:(NSString *)title message:(NSString *)message modelArray:(NSArray<WSAlertViewModel *> *) modelArray cancelModel:(WSAlertViewModel *)cancelmodel viewController:(UIViewController *)viewController alertViewType:(WSAlertViewType)alertViewType
{
    if (IOS8ORLATER) {
        UIAlertControllerStyle style = UIAlertControllerStyleAlert;
        switch (alertViewType) {
            case WSAlertViewTypeActionSheet:
            {
                style = UIAlertControllerStyleActionSheet;
            }
                break;
            case WSAlertViewTypeAlert:
            {
                style = UIAlertControllerStyleAlert;
            }
                break;
            default:
                break;
        }
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title                                                                             message: message                                                                       preferredStyle:style];
        NSInteger count = modelArray.count;
        for (int i = 0; i < count; i++) {
            WSAlertViewModel *model = [modelArray objectAtIndex:i];
            [alertController addAction: [UIAlertAction actionWithTitle:model.title style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                if (model.handle) {
                    model.handle();
                }
            }]];
        }

        [alertController addAction: [UIAlertAction actionWithTitle:cancelmodel.title style: UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (cancelmodel.handle) {
                cancelmodel.handle();
            }
        }]];
        
        [viewController presentViewController: alertController animated: YES completion: nil];
    } else {
        switch (alertViewType) {
            case WSAlertViewTypeActionSheet:
            {
                [self showActionSheet:title message:message modelArray:modelArray cancelModel:cancelmodel viewController:viewController];
            }
                break;
            case WSAlertViewTypeAlert:
            {
                
            }
                break;
            default:
                break;
        }


    }

}

+ (void)showActionSheet:(NSString *)title message:(NSString *)message modelArray:(NSArray<WSAlertViewModel *> *) modelArray cancelModel:(WSAlertViewModel *)cancelmodel viewController:(UIViewController *)viewController
{
    WSAlertView *wsActionSheet = [self shareInstance];
    wsActionSheet.modelArray = modelArray;
    wsActionSheet.cancelmodel = cancelmodel;
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:wsActionSheet cancelButtonTitle:cancelmodel.title destructiveButtonTitle:nil otherButtonTitles: nil];
    NSInteger count = modelArray.count;
    for (int i = 0; i < count; i++) {
        WSAlertViewModel *model = [modelArray objectAtIndex:i];
        [actionSheet addButtonWithTitle:model.title];
    }
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:viewController.view];
}

+ (void)showAlert:(NSString *)title message:(NSString *)message modelArray:(NSArray<WSAlertViewModel *> *) modelArray cancelModel:(WSAlertViewModel *)cancelmodel viewController:(UIViewController *)viewController
{
    WSAlertView *shareInstance = [self shareInstance];
    shareInstance.modelArray = modelArray;
    shareInstance.cancelmodel = cancelmodel;
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:shareInstance cancelButtonTitle:cancelmodel.title otherButtonTitles:nil, nil];
    NSInteger count = modelArray.count;
    for (int i = 0; i < count; i++) {
        WSAlertViewModel *model = [modelArray objectAtIndex:i];
        [alertView addButtonWithTitle:model.title];
    }
    alertView.alertViewStyle =  UIAlertViewStyleDefault;
    [alertView show];
}



#pragma mark - UIAlertViewDelegate
// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 9_0)
{
    if (buttonIndex == 0) {
        if (_cancelmodel.handle) {
            _cancelmodel.handle();
        }
    } else {
        NSInteger count = _modelArray.count;
        if (buttonIndex <= count) {
            WSAlertViewModel *model = [_modelArray objectAtIndex:buttonIndex - 1];
            if (model.handle) {
                model.handle();
            }
        }
    }
}

// Called when we cancel a view (eg. the user clicks the Home button). This is not called when the user clicks the cancel button.
// If not defined in the delegate, we simulate a click in the cancel button
- (void)alertViewCancel:(UIAlertView *)alertView NS_DEPRECATED_IOS(2_0, 9_0)
{
    if (_cancelmodel.handle) {
        _cancelmodel.handle();
    }
}

- (void)willPresentAlertView:(UIAlertView *)alertView NS_DEPRECATED_IOS(2_0, 9_0)  // before animation and showing view
{
    
}
- (void)didPresentAlertView:(UIAlertView *)alertView NS_DEPRECATED_IOS(2_0, 9_0)  // after animation
{
    
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 9_0) // before animation and hiding view
{
    
}


#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        if (_cancelmodel.handle) {
            _cancelmodel.handle();
        }
    } else {
        NSInteger count = _modelArray.count;
        if (buttonIndex <= count) {
            WSAlertViewModel *model = [_modelArray objectAtIndex:buttonIndex - 1];
            if (model.handle) {
                model.handle();
            }
        }
    }
}

- (void)actionSheetCancel:(UIActionSheet *)actionSheet
{
    if (_cancelmodel.handle) {
        _cancelmodel.handle();
    }
}


@end
