//
//  iPinRegisterViewController.h
//  iPin
//
//  Created by LYC on 14-7-12.
//  Copyright (c) 2014年 ___iPinStudio___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "iPinRequestCenter.h"
#import "iPinDatabaseCenter.h"

@interface iPinRegisterViewController : BaseViewController
{
    UITextField *mUsernameTextField;
    UITextField *mPasswordTextField;
    UITextField *mConfirmPasswordTextField;
    UITextField *mTelephoneTextField;
}

- (void)onBackButton;
- (void)onRegisterButton;
@end
