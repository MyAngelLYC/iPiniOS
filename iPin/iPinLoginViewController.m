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
    // 绘制登陆界面
    [[self view] setBackgroundColor:[UIColor whiteColor]];
    
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
    [mPasswordTextfield setKeyboardType:UIKeyboardTypeAlphabet];
    [[self view] addSubview:mPasswordTextfield];
    mPasswordTextField=mPasswordTextfield;
    
    UIButton *mLoginButton=[[UIButton alloc] initWithFrame:CGRectMake(viewBounds.size.width/2-81, 320, 71, 25)];
    [mLoginButton setBackgroundImage:[UIImage imageNamed:@"BlueButton"] forState:UIControlStateNormal];
    [mLoginButton setTitle:@"登陆" forState:UIControlStateNormal];
    [mLoginButton addTarget:self action:@selector(onLoginButton) forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:mLoginButton];
    
    UIButton *mRegisterButton=[[UIButton alloc] initWithFrame:CGRectMake(viewBounds.size.width/2+10, 320, 71, 25)];
    [mRegisterButton setBackgroundImage:[UIImage imageNamed:@"BlueButton"] forState:UIControlStateNormal];
    [mRegisterButton setTitle:@"注册" forState:UIControlStateNormal];
    [mRegisterButton addTarget:self action:@selector(onRegisterButton) forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:mRegisterButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //从本地数据库读取数据自动填充username文本框
    NSString *sqlCmd=@"select * from loginUser";
    sqlite3_stmt *statement;
    [[iPinDatabaseCenter sharedInstance] openDatabase];
    sqlite3_prepare_v2([[iPinDatabaseCenter sharedInstance] getDatabase], [sqlCmd UTF8String], -1, &statement, nil);
    if(SQLITE_ROW==sqlite3_step(statement))
    {
        char *name=(char*)sqlite3_column_text(statement, 1);
        NSString *username=[[NSString alloc] initWithUTF8String:name];
        [mUsernameTextField setText:username];
    }
    [[iPinDatabaseCenter sharedInstance] closeDatabase];
    sqlite3_finalize(statement);
}

- (void)onLoginButton
{
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
        NSInteger result=[(NSNumber *)[backJSON objectForKey:@"result"] intValue];
        if(result==1)
        {
            NSString *sqlCmd=@"delete from loginUser where 1";
            [[iPinDatabaseCenter sharedInstance] execSQL:sqlCmd];
            NSString *ID=[backJSON objectForKey:@"ID"];
            NSString *sex=[backJSON objectForKey:@"sex"];
            NSString *telephone=[backJSON objectForKey:@"telephone"];
            NSString *auth=[backJSON objectForKey:@"Auth"];
            NSString *StudentID=[backJSON objectForKey:@"StudentID"];
            NSString *PersonID=[backJSON objectForKey:@"PersonID"];
            sqlCmd=[NSString stringWithFormat:@"insert into loginUser (ID,username,password,sex,telephone,auth,StudentID,PersonID,autoLogin) values ('%@','%@','%@','%@','%@','%@','%@','%@','0')",ID,username,[[iPinRequestCenter sharedInstance]md5:password],sex,telephone,auth,StudentID,PersonID];
            [[iPinDatabaseCenter sharedInstance] execSQL:sqlCmd];
            [self dismissViewControllerAnimated:YES completion:nil];
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
    [self presentViewController:[[iPinRegisterViewController alloc] init] animated:YES completion:nil];
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
