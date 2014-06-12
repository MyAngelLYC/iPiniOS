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

@synthesize refreshHeaderAndFooterView ;//= _refreshHeaderAndFooterView;
@synthesize reloading ;//= _reloading;
@synthesize myScrollView;
@synthesize myTableView;

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
    
    UITableView *listTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 362) style:UITableViewStylePlain];
    [listTable setDelegate:self];
    [listTable setDataSource:self];
    UINib *nib=[UINib nibWithNibName:@"iPinListTableViewCell" bundle:nil];
    [listTable registerNib:nib forCellReuseIdentifier:@"iPinListTableViewCell"];
    [self setMyTableView:listTable];
    //[listTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    //[[self view] addSubview:listTable];
    
    listItem=[[NSMutableArray alloc] init];
    [listItem addObject:[[iPinListItem alloc] initWithUsername:@"ussam" sex:@"男" telephone:@"15105178519" fromPlace:@"东大西门" toPlace:@"百家湖" date:@"2014-6-9" detail:@"只限妹子" seats:@"1"]];
    [listItem addObject:[[iPinListItem alloc] initWithUsername:@"lyc" sex:@"女" telephone:@"15105178519" fromPlace:@"东大东门" toPlace:@"禄口机场" date:@"2014-5-30" detail:@"我要回家" seats:@"3"]];
    [listItem addObject:[[iPinListItem alloc] initWithUsername:@"lyc" sex:@"女" telephone:@"15105178519" fromPlace:@"东大东门" toPlace:@"禄口机场" date:@"2014-5-30" detail:@"我要回家" seats:@"3"]];
    [listItem addObject:[[iPinListItem alloc] initWithUsername:@"lyc" sex:@"女" telephone:@"15105178519" fromPlace:@"东大东门" toPlace:@"禄口机场" date:@"2014-5-30" detail:@"我要回家" seats:@"3"]];
    [listItem addObject:[[iPinListItem alloc] initWithUsername:@"lyc" sex:@"女" telephone:@"15105178519" fromPlace:@"东大东门" toPlace:@"禄口机场" date:@"2014-5-30" detail:@"我要回家" seats:@"3"]];
    [listItem addObject:[[iPinListItem alloc] initWithUsername:@"lyc" sex:@"女" telephone:@"15105178519" fromPlace:@"东大东门" toPlace:@"禄口机场" date:@"2014-5-30" detail:@"我要回家" seats:@"3"]];
    
    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 43, 320, 362)];
    [scrollView setContentSize:CGSizeMake(scrollView.bounds.size.width, scrollView.bounds.size.height*2)];
    [scrollView setDelegate:self];
    [scrollView addSubview:listTable];
    [[self view] addSubview:scrollView];
    [self setMyScrollView:scrollView];
    RefreshHeaderAndFooterView *view = [[RefreshHeaderAndFooterView alloc] initWithFrame:CGRectMake(0, 0, myScrollView.frame.size.width, myScrollView.contentSize.height)];
    view.delegate = self;
    [myScrollView addSubview:view];
    self.refreshHeaderAndFooterView = view;
    [self.refreshHeaderAndFooterView.refreshHeaderView updateRefreshDate:[NSDate date]];
    
    //listTable.frame = CGRectMake(self.myScrollView.frame.origin.x, self.myScrollView.frame.origin.y, self.myScrollView.frame.size.width, self.myScrollView.contentSize.height);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    int count=[listItem count];
    float height=88;
    if(height*count>362)
    {
        [myScrollView setContentSize:CGSizeMake(myScrollView.bounds.size.width, height*count+10)];
        [myTableView setFrame:CGRectMake(0, 0, 320, height*count+10)];
    }
    else
    {
        [myScrollView setContentSize:CGSizeMake(myScrollView.bounds.size.width, 362+100)];
        [myTableView setFrame:CGRectMake(0, 0, 320, 362+5)];
    }
    
    [refreshHeaderAndFooterView removeFromSuperview];
    RefreshHeaderAndFooterView *view = [[RefreshHeaderAndFooterView alloc] initWithFrame:CGRectMake(0, 0, myScrollView.frame.size.width, myScrollView.contentSize.height)];
    view.delegate = self;
    [myScrollView addSubview:view];
    self.refreshHeaderAndFooterView = view;
    return [listItem count];

}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    iPinListTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"iPinListTableViewCell"];
    [cell setItem:[listItem objectAtIndex:[indexPath row]]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    iPinListTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"iPinListTableViewCell"];
    return [[cell contentView] bounds].size.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int clickItem=[indexPath row];
    iPinListItem *item=[listItem objectAtIndex:clickItem];
    NSString *msg=[[NSString alloc] initWithFormat:@"用户：%@\n性别：%@\n电话：%@\n出发：%@\n前往：%@\n日期：%@\n详情：%@",[item username],[item sex],[item telephone],[item fromPlace],[item toPlace],[item date],[item detail]];
    UIAlertView *myAlert=[[UIAlertView alloc] initWithTitle:@"拼车信息" message:msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"打电话",  nil];
    [myAlert addButtonWithTitle:@"发短信"];
    [myAlert show];
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
- (void)doneLoadingViewData{
	
	//  model should call this when its done loading
	self.reloading = NO;
    [self.refreshHeaderAndFooterView RefreshScrollViewDataSourceDidFinishedLoading:self.myScrollView];
	
}
#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    [self.refreshHeaderAndFooterView RefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.refreshHeaderAndFooterView RefreshScrollViewDidEndDragging:scrollView];
	
}
#pragma mark -
#pragma mark RefreshHeaderAndFooterViewDelegate Methods

- (void)RefreshHeaderAndFooterDidTriggerRefresh:(RefreshHeaderAndFooterView*)view{
	self.reloading = YES;
    if (view.refreshHeaderView.state == PullRefreshLoading) {//下拉刷新动作的内容
        NSLog(@"header");
        [self performSelector:@selector(doneLoadingViewData) withObject:nil afterDelay:3.0];
        
    }else if(view.refreshFooterView.state == PullRefreshLoading){//上拉加载更多动作的内容
        NSLog(@"footer");
        [self performSelector:@selector(doneLoadingViewData) withObject:nil afterDelay:3.0];
    }
}

- (BOOL)RefreshHeaderAndFooterDataSourceIsLoading:(RefreshHeaderAndFooterView*)view{
	
	return self.reloading; // should return if data source model is reloading
	
}
- (NSDate*)RefreshHeaderAndFooterDataSourceLastUpdated:(RefreshHeaderAndFooterView*)view{
    return [NSDate date];
}

@end
