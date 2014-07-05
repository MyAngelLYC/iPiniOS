//
//  iPinLoginViewController.m
//  iPin
//
//  Created by 刘亦辰 on 14-7-1.
//  Copyright (c) 2014年 ___iPinStudio___. All rights reserved.
//

#import "iPinLoginViewController.h"

@interface iPinLoginViewController ()

@end

@implementation iPinLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect viewBounds=[[UIScreen mainScreen]applicationFrame];
    
    UIImageView *mLogoImage=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo"]];
    [mLogoImage setFrame:CGRectMake(viewBounds.size.width/2-70, 60, 140, 140)];
    [[self view] addSubview:mLogoImage];
    
    UILabel *mUsernameLabel=[[UILabel alloc] initWithFrame:CGRectMake(50, 230, 100, 30)];
    [mUsernameLabel setText:@"账号："];
    [[self view] addSubview:mUsernameLabel];
    
    UILabel *mPasswordLabel=[[UILabel alloc] initWithFrame:CGRectMake(50, 270, 100, 30)];
    [mPasswordLabel setText:@"密码："];
    [[self view] addSubview:mPasswordLabel];
    
    UITextField *mUsernameTextfield=[[UITextField alloc] initWithFrame:CGRectMake(100, 230, 180, 30)];
    [mUsernameTextfield setPlaceholder:@"用户名/手机号"];
    [mUsernameTextfield setBorderStyle:UITextBorderStyleRoundedRect];
    [mUsernameTextfield setDelegate:self];
    [mUsernameTextfield setReturnKeyType:UIReturnKeyDone];
    [mUsernameTextfield setText:@""];
    [[self view] addSubview:mUsernameTextfield];
    mUsernameTextField=mUsernameTextfield;
    
    UITextField *mPasswordTextfield=[[UITextField alloc] initWithFrame:CGRectMake(100, 270, 180, 30)];
    [mPasswordTextfield setPlaceholder:@"请输入密码"];
    [mPasswordTextfield setBorderStyle:UITextBorderStyleRoundedRect];
    [mPasswordTextfield setDelegate:self];
    [mPasswordTextfield setReturnKeyType:UIReturnKeyDone];
    [mPasswordTextfield setSecureTextEntry:YES];
    [mPasswordTextfield setText:@""];
    [[self view] addSubview:mPasswordTextfield];
    mPasswordTextField=mPasswordTextfield;
    
    UIButton *mLoginButton=[[UIButton alloc] initWithFrame:CGRectMake(viewBounds.size.width/2-81, 320, 71, 25)];
    [mLoginButton setBackgroundImage:[UIImage imageNamed:@"Button"] forState:UIControlStateNormal];
    [mLoginButton setTitle:@"登陆" forState:UIControlStateNormal];
    [mLoginButton addTarget:self action:@selector(onLoginButton) forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:mLoginButton];
    
    UIButton *mRegisterButton=[[UIButton alloc] initWithFrame:CGRectMake(viewBounds.size.width/2+10, 320, 71, 25)];
    [mRegisterButton setBackgroundImage:[UIImage imageNamed:@"Button"] forState:UIControlStateNormal];
    [mRegisterButton setTitle:@"注册" forState:UIControlStateNormal];
    [mRegisterButton addTarget:self action:@selector(onRegisterButton) forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:mRegisterButton];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onLoginButton
{
    NSLog(@"Login");
    NSString *username=[mUsernameTextField text];
    NSString *password=[mPasswordTextField text];
    if([username isEqualToString:@""])
    {
        UIAlertView *myAlert=[[UIAlertView alloc] initWithTitle:@"信息提示" message:@"用户名不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil,  nil];
        [myAlert show];
        return;
    }
    if([password isEqualToString:@""])
    {
        UIAlertView *myAlert=[[UIAlertView alloc] initWithTitle:@"信息提示" message:@"密码不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil,  nil];
        [myAlert show];
        return;
    }
    
    NSMutableDictionary *sendJSON=[[NSMutableDictionary alloc] init];
    [sendJSON setObject:@"userLogin" forKey:@"cmd"];
    [sendJSON setObject:username forKey:@"username"];
    [sendJSON setObject:[[iPinRequestCenter sharedInstance]md5:password] forKey:@"password"];
    NSMutableDictionary *backJSON=[[iPinRequestCenter sharedInstance] sendRequest:sendJSON];
    if(backJSON!=nil)
    {
        NSLog(@"%@",[backJSON objectForKey:@"result"]);
        if(1==(NSInteger)[backJSON objectForKey:@"result"])
        {
            
        }
        else
        {
            UIAlertView *myAlert=[[UIAlertView alloc] initWithTitle:@"信息提示" message:@"用户名或密码错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil,  nil];
            [myAlert show];
        }
    }
    else
    {
        UIAlertView *myAlert=[[UIAlertView alloc] initWithTitle:@"信息提示" message:@"请检查您的网络连接是否正常" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil,  nil];
        [myAlert show];
    }
}

- (void)onRegisterButton
{
    NSLog(@"Register");
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    mTextField=textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    mTextField=textField;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    mTextField=textField;
    [mTextField resignFirstResponder];
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
