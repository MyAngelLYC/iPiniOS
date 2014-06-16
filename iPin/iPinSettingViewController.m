//
//  iPinSettingViewController.m
//  iPin
//
//  Created by 刘亦辰 on 14-6-16.
//  Copyright (c) 2014年 ___iPinStudio___. All rights reserved.
//

#import "iPinSettingViewController.h"

@interface iPinSettingViewController ()

@end

@implementation iPinSettingViewController

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
    UIImageView *backgroundImage=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"settings_bg"]];
    [backgroundImage setFrame:CGRectMake(0, 0, 320, 460)];
    [[self view] addSubview:backgroundImage];
    
    UIView *titleView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 43.5f)];
    UIImageView *titleImage=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"settings_title_bar"]];
    [titleImage setFrame:CGRectMake(0, 0, 320, 43.5f)];
    [titleView addSubview:titleImage];
    UIButton *backButton=[[UIButton alloc] initWithFrame:CGRectMake(20, 11.75f, 10, 20)];
    [backButton setImage:[UIImage imageNamed:@"settings_back_action"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"settings_back_action"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(onBackButton) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:backButton];
    [[self view] addSubview:titleView];
    
    UIButton *logoutButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 400, 320, 40)];
    [logoutButton setImage:[UIImage imageNamed:@"settings_logout_button"] forState:UIControlStateNormal];
    [logoutButton setImage:[UIImage imageNamed:@"settings_logout_button"] forState:UIControlStateHighlighted];
    //[logoutButton addTarget:self action:@selector(onBackButton) forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:logoutButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)onBackButton
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
