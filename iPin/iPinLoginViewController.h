//
//  iPinLoginViewController.h
//  iPin
//
//  Created by 刘亦辰 on 14-7-1.
//  Copyright (c) 2014年 ___iPinStudio___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>
#import "BaseViewController.h"
#import "iPinRequestCenter.h"

@interface iPinLoginViewController : BaseViewController
{
    UITextField *mUsernameTextField;
    UITextField *mPasswordTextField;
}

- (void)onLoginButton;
- (void)onRegisterButton;
@end