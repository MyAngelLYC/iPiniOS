//
//  iPinRegisterViewController.m
//  iPin
//
//  Created by LYC on 14-7-12.
//  Copyright (c) 2014年 ___iPinStudio___. All rights reserved.
//

#import "iPinRegisterViewController.h"

@interface iPinRegisterViewController ()

@end

@implementation iPinRegisterViewController

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
    [[self view] setBackgroundColor:[UIColor whiteColor]];
    
    CGRect viewBounds=[[UIScreen mainScreen]applicationFrame];
    
    UIImageView *titleImage=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main_title_bar"]];
    [titleImage setFrame:CGRectMake(0,0,viewBounds.size.width,40)];
    [titleImage setUserInteractionEnabled:YES];
    [[self view] addSubview:titleImage];

    UIButton *backButton=[[UIButton alloc] initWithFrame:CGRectMake(10,0,40,40)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"backBtn"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(onBackButton) forControlEvents:UIControlEventTouchUpInside];
    [titleImage addSubview:backButton];
    
    UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(viewBounds.size.width/2-22, 0, 100, 40)];
    [titleLabel setText:@"注册"];
    [titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:24]];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleImage addSubview:titleLabel];
    
    UITextField *mUsernameTextfield=[[UITextField alloc] initWithFrame:CGRectMake(40, 60, viewBounds.size.width-80, 30)];
    [mUsernameTextfield setPlaceholder:@"用户名"];
    [mUsernameTextfield setBorderStyle:UITextBorderStyleRoundedRect];
    [mUsernameTextfield setDelegate:self];
    [mUsernameTextfield setReturnKeyType:UIReturnKeyDone];
    [mUsernameTextfield setText:@""];
    [[self view] addSubview:mUsernameTextfield];
    mUsernameTextField=mUsernameTextfield;
    
    UITextField *mPasswordTextfield=[[UITextField alloc] initWithFrame:CGRectMake(40, 110, viewBounds.size.width-80, 30)];
    [mPasswordTextfield setPlaceholder:@"密码"];
    [mPasswordTextfield setBorderStyle:UITextBorderStyleRoundedRect];
    [mPasswordTextfield setDelegate:self];
    [mPasswordTextfield setReturnKeyType:UIReturnKeyDone];
    [mPasswordTextfield setSecureTextEntry:YES];
    [mPasswordTextfield setText:@""];
    [mPasswordTextfield setKeyboardType:UIKeyboardTypeAlphabet];
    [[self view] addSubview:mPasswordTextfield];
    mPasswordTextField=mPasswordTextfield;
    
    UITextField *mConfirmPasswordTextfield=[[UITextField alloc] initWithFrame:CGRectMake(40, 160, viewBounds.size.width-80, 30)];
    [mConfirmPasswordTextfield setPlaceholder:@"确认密码"];
    [mConfirmPasswordTextfield setBorderStyle:UITextBorderStyleRoundedRect];
    [mConfirmPasswordTextfield setDelegate:self];
    [mConfirmPasswordTextfield setReturnKeyType:UIReturnKeyDone];
    [mConfirmPasswordTextfield setSecureTextEntry:YES];
    [mConfirmPasswordTextfield setText:@""];
    [mConfirmPasswordTextfield setKeyboardType:UIKeyboardTypeAlphabet];
    [[self view] addSubview:mConfirmPasswordTextfield];
    mConfirmPasswordTextField=mConfirmPasswordTextfield;
    
    UITextField *mTelephoneTextfield=[[UITextField alloc] initWithFrame:CGRectMake(40, 210, viewBounds.size.width-80, 30)];
    [mTelephoneTextfield setPlaceholder:@"手机号码"];
    [mTelephoneTextfield setBorderStyle:UITextBorderStyleRoundedRect];
    [mTelephoneTextfield setDelegate:self];
    [mTelephoneTextfield setReturnKeyType:UIReturnKeyDone];
    [mTelephoneTextfield setText:@""];
    [mTelephoneTextfield setKeyboardType:UIKeyboardTypeNumberPad];
    [[self view] addSubview:mTelephoneTextfield];
    mTelephoneTextField=mTelephoneTextfield;
    
    UIButton *RegisterButton=[[UIButton alloc] initWithFrame:CGRectMake(viewBounds.size.width/2-81, 320, 71, 24)];
    [RegisterButton setBackgroundImage:[UIImage imageNamed:@"BlueButton"] forState:UIControlStateNormal];
    [RegisterButton setTitle:@"注册" forState:UIControlStateNormal];
    [RegisterButton addTarget:self action:@selector(onRegisterButton) forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:RegisterButton];
    
    UIButton *CancleButton=[[UIButton alloc] initWithFrame:CGRectMake(viewBounds.size.width/2+10, 320, 71, 24)];
    [CancleButton setBackgroundImage:[UIImage imageNamed:@"RedButton"] forState:UIControlStateNormal];
    [CancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [CancleButton addTarget:self action:@selector(onBackButton) forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:CancleButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onBackButton
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)onRegisterButton
{
    NSString *username=[mUsernameTextField text];
    NSString *password=[mPasswordTextField text];
    NSString *comfirmPassword=[mConfirmPasswordTextField text];
    NSString *telephone=[mTelephoneTextField text];
    if([username isEqualToString:@""])
    {
        UIAlertView *myAlert=[[UIAlertView alloc] initWithTitle:@"信息提示" message:@"用户名不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil,  nil];
        [myAlert show];
        return;
    }
    else if([username length]>20)
    {
        UIAlertView *myAlert=[[UIAlertView alloc] initWithTitle:@"信息提示" message:@"用户名长度不能超过20个字符" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil,  nil];
        [myAlert show];
        return;
    }
    else if([password isEqualToString:@""])
    {
        UIAlertView *myAlert=[[UIAlertView alloc] initWithTitle:@"信息提示" message:@"密码不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil,  nil];
        [myAlert show];
        return;
    }
    else if([password length]<6)
    {
        UIAlertView *myAlert=[[UIAlertView alloc] initWithTitle:@"信息提示" message:@"密码长度不能低于6位" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil,  nil];
        [myAlert show];
        return;
    }
    else if(![password isEqualToString:comfirmPassword])
    {
        UIAlertView *myAlert=[[UIAlertView alloc] initWithTitle:@"信息提示" message:@"密码与确认密码不同" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil,  nil];
        [myAlert show];
        return;
    }
    else if([telephone length]!=11)
    {
        UIAlertView *myAlert=[[UIAlertView alloc] initWithTitle:@"信息提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil,  nil];
        [myAlert show];
        return;
    }
    
    password=[[iPinRequestCenter sharedInstance] md5:password];
    NSString *sex=@"male";
    NSMutableDictionary *sendJSON=[[NSMutableDictionary alloc] init];
    [sendJSON setObject:@"userRegister" forKey:@"cmd"];
    [sendJSON setObject:username forKey:@"username"];
    [sendJSON setObject:password forKey:@"password"];
    [sendJSON setObject:sex forKey:@"sex"];
    [sendJSON setObject:telephone forKey:@"telephone"];
    NSMutableDictionary *backJSON=[[iPinRequestCenter sharedInstance] sendRequest:sendJSON];
    if(backJSON!=nil)
    {
        NSInteger result=[(NSNumber *)[backJSON objectForKey:@"result"] intValue];
        if(result==1)
        {
            NSString *ID=[backJSON objectForKey:@"ID"];
            NSString *sqlCmd=@"delete from loginUser where 1";
            [[iPinDatabaseCenter sharedInstance] execSQL:sqlCmd];
            sqlCmd=[NSString stringWithFormat:@"insert into loginUser (ID,username,password,sex,telephone,auth,StudentID,PersonID,autoLogin) values ('%@','%@','%@','%@','%@','0','NULL','NULL','0')",ID,username,password,sex,telephone];
            [[iPinDatabaseCenter sharedInstance] execSQL:sqlCmd];
            UIAlertView *myAlert=[[UIAlertView alloc] initWithTitle:@"信息提示" message:@"用户注册成功，请登陆" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil,  nil];
            [myAlert show];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else
        {
            UIAlertView *myAlert=[[UIAlertView alloc] initWithTitle:@"信息提示" message:@"该用户名已经存在，请选择其他用户名" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil,  nil];
            [myAlert show];
        }
    }
    else
    {
        UIAlertView *myAlert=[[UIAlertView alloc] initWithTitle:@"信息提示" message:@"请检查您的网络连接是否正常" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil,  nil];
        [myAlert show];
    }
}
@end
