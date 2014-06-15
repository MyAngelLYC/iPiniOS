//
//  iPinNearbyViewController.m
//  iPin
//
//  Created by 刘亦辰 on 14-6-15.
//  Copyright (c) 2014年 ___iPinStudio___. All rights reserved.
//

#import "iPinNearbyViewController.h"

@interface iPinNearbyViewController ()

@end

@implementation iPinNearbyViewController

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
    UIView *titleView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 43)];
    UIImageView *titleImage=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nearby_title_bar"]];
    [titleImage setBounds:CGRectMake(0, 0, 320, 43)];
    [titleView addSubview:titleImage];
    UIButton *backButton=[[UIButton alloc] initWithFrame:CGRectMake(20, 11.75f, 10, 20)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"nearby_back_function"] forState:UIControlStateNormal];
    [backButton setBackgroundImage:[UIImage imageNamed:@"nearby_back_function"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(onBackButton) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:backButton];
    [[self view] addSubview:titleView];
    
    UIView *bottomView=[[UIView alloc] initWithFrame:CGRectMake(0, 425, 322, 35)];
    UIImageView *bottomImage=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nearby_bottom_bar"]];
    [bottomImage setFrame:CGRectMake( 0,0, 322, 32.5f)];
    [bottomView addSubview:bottomImage];
    UIButton *confirmButton=[[UIButton alloc] initWithFrame:CGRectMake(240, 5, 70, 25)];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"nearby_confirm_button"] forState:UIControlStateNormal];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"nearby_confirm_button"] forState:UIControlStateHighlighted];
    [bottomView addSubview:confirmButton];
    [[self view] addSubview:bottomView];
    
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
