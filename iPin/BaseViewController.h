//
//  BaseViewController.h
//  iPin
//
//  Created by 刘亦辰 on 14-7-4.
//  Copyright (c) 2014年 ___iPinStudio___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController <UITextFieldDelegate>
{
    UITextField *mTextField;
}
- (void)keyboardWillShow:(NSNotification *)notification;
- (void)keyboardWillHide:(NSNotification *)notification;
@end
