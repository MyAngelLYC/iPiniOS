//
//  iPinMainViewController.m
//  iPin
//
//  Created by 刘亦辰 on 14-6-11.
//  Copyright (c) 2014年 ___iPinStudio___. All rights reserved.
//

#import "iPinMainViewController.h"

@interface iPinMainViewController ()

@end

@implementation iPinMainViewController

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
    UIView *titleView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 43)];
    UIImageView *titleBackground=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title_bar"]];
    [titleBackground setBounds:CGRectMake(0, 0, 320, 43)];
    [titleView addSubview:titleBackground];
    UIButton *myInfoButton=[[UIButton alloc] initWithFrame:CGRectMake(10, 9, 28, 25)];
    [myInfoButton setBackgroundImage:[UIImage imageNamed:@"settings_button"] forState:UIControlStateNormal];
    [myInfoButton setBackgroundImage:[UIImage imageNamed:@"settings_button"] forState:UIControlStateHighlighted];
    [titleView addSubview:myInfoButton];
    [[self view] addSubview:titleView];
    
    UIView *bottomView=[[UIView alloc] initWithFrame:CGRectMake(0, 405, 320, 55)];
    
    UIImageView *bottomBackground=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
    [bottomBackground setBounds:CGRectMake(0, 0, 320, 480)];
    [bottomView addSubview:bottomBackground];
    UIButton *publishButton=[[UIButton alloc] initWithFrame:CGRectMake(12.5, 10, 140, 35)];
    [publishButton setBackgroundImage:[UIImage imageNamed:@"release_function"] forState:UIControlStateNormal];
    [publishButton setBackgroundImage:[UIImage imageNamed:@"release_function"] forState:UIControlStateHighlighted];
    [bottomView addSubview:publishButton];
    UIButton *nearbyButton=[[UIButton alloc] initWithFrame:CGRectMake(167.5, 10, 140, 35)];
    [nearbyButton setBackgroundImage:[UIImage imageNamed:@"nearby_function"] forState:UIControlStateNormal];
    [nearbyButton setBackgroundImage:[UIImage imageNamed:@"nearby_function"] forState:UIControlStateHighlighted];
    [bottomView addSubview:nearbyButton];
    [[self view] addSubview:bottomView];
    
    UITableView *listTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 43, 320, 362) style:UITableViewStylePlain];
    [listTable setDelegate:self];
    [listTable setDataSource:self];
    UINib *nib=[UINib nibWithNibName:@"iPinListTableViewCell" bundle:nil];
    [listTable registerNib:nib forCellReuseIdentifier:@"iPinListTableViewCell"];
    [[self view] addSubview:listTable];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return [listItem count];
    return 2;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    iPinListTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"iPinListTableViewCell"];
    if([indexPath row]==1)
    {
        [cell changeSex];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    iPinListTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"iPinListTableViewCell"];
    return [[cell contentView] bounds].size.height;
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
