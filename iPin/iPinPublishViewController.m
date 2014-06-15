//
//  iPinPublishViewController.m
//  iPin
//
//  Created by 刘亦辰 on 14-6-13.
//  Copyright (c) 2014年 ___iPinStudio___. All rights reserved.
//

#import "iPinPublishViewController.h"

@interface iPinPublishViewController ()

@end

@implementation iPinPublishViewController

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
    UIImageView *backgroundView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
    [backgroundView setFrame:CGRectMake(0, 0, 320, 460)];
    [[self view] addSubview:backgroundView];
    
    UIView *titleView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 43.5f)];
    UIImageView *titleBackground=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"release_title_bar"]];
    [titleBackground setBounds:CGRectMake(0, 0, 320, 43.5f)];
    [titleView addSubview:titleBackground];
    UIButton *backButton=[[UIButton alloc] initWithFrame:CGRectMake(20, 11.75f, 10, 20)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back_function"] forState:UIControlStateNormal];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back_function"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(onBackButton) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:backButton];
    [[self view] addSubview:titleView];
    
    UIImageView *placeImageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"release_information_bg"]];
    [placeImageView setFrame:CGRectMake(0, 80, 320, 105)];
    [placeImageView setUserInteractionEnabled:YES];
    [[self view] addSubview:placeImageView];
    UITextField *fromView=[[UITextField alloc] initWithFrame:CGRectMake(40, 10, 260, 25)];
    [fromView setBorderStyle:UITextBorderStyleNone];
    [fromView setPlaceholder:@"从哪出发"];
    [placeImageView addSubview:fromView];
    UITextField *toView=[[UITextField alloc] initWithFrame:CGRectMake(40, 41, 260, 25)];
    [toView setBorderStyle:UITextBorderStyleNone];
    [toView setPlaceholder:@"到哪儿去"];
    [placeImageView addSubview:toView];
    UITextField *timeView=[[UITextField alloc] initWithFrame:CGRectMake(40, 72, 260, 25)];
    [timeView setBorderStyle:UITextBorderStyleNone];
    [timeView setPlaceholder:@"何时出发"];
    [placeImageView addSubview:timeView];
    
    UIImageView *seatsImageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"release_information_bg2"]];
    [seatsImageView setFrame:CGRectMake(0, 220, 320, 35)];
    [[self view] addSubview:seatsImageView];
    UIButton *minusButton=[[UIButton alloc] initWithFrame:CGRectMake(200, 9, 17, 17)];
    [minusButton setBackgroundImage:[UIImage imageNamed:@"release_minus_button"] forState:UIControlStateNormal];
    [minusButton setBackgroundImage:[UIImage imageNamed:@"release_minus_button"] forState:UIControlStateHighlighted];
    UIButton *plusButton=[[UIButton alloc] initWithFrame:CGRectMake(260, 9, 17, 17)];
    [plusButton setBackgroundImage:[UIImage imageNamed:@"release_plus_button"] forState:UIControlStateNormal];
    [plusButton setBackgroundImage:[UIImage imageNamed:@"release_plus_button"] forState:UIControlStateHighlighted];
    [seatsImageView addSubview:plusButton];
    [seatsImageView addSubview:minusButton];
    UITextField *seatsView=[[UITextField alloc] initWithFrame:CGRectMake(25, 6, 150, 25)];
    [seatsView setBorderStyle:UITextBorderStyleNone];
    [seatsView setPlaceholder:@"需要拼客几人："];
    [seatsImageView addSubview:seatsView];
    UILabel *seatsLabel=[[UILabel alloc] initWithFrame:CGRectMake(235, 6, 10, 25)];
    [seatsLabel setText:@"3"];
    [seatsImageView addSubview:seatsLabel];
    
    UIImageView *dateImageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"release_information_bg2"]];
    [dateImageView setFrame:CGRectMake(0, 290, 320, 35)];
    [dateImageView setUserInteractionEnabled:YES];
    [[self view] addSubview:dateImageView];
    UITextField *dateView=[[UITextField alloc] initWithFrame:CGRectMake(25, 6, 260, 25)];
    [dateView setBorderStyle:UITextBorderStyleNone];
    [dateView setPlaceholder:@"还有什么额外要求，告诉拼友吧"];
    [dateImageView addSubview:dateView];
    
    UIButton *publishButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 360, 320, 40)];
    [publishButton setBackgroundImage:[UIImage imageNamed:@"release_confirm_button"] forState:UIControlStateNormal];
    [publishButton setBackgroundImage:[UIImage imageNamed:@"release_confirm_button"] forState:UIControlStateHighlighted];
    [[self view] addSubview:publishButton];
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
