//
//  iPinLoginViewController.h
//  iPin
//
//  Created by 刘亦辰 on 14-7-1.
//  Copyright (c) 2014年 ___iPinStudio___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "iPinRequestCenter.h"
#import "iPinDatabaseCenter.h"

@interface iPinLoginViewController : BaseViewController
{
    UITextField *mUsernameTextField;
    UITextField *mPasswordTextField;

}

- (void)onLoginButton;
- (void)onRegisterButton;

@end
