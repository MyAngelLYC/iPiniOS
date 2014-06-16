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

@synthesize refreshHeaderAndFooterView ;
@synthesize reloading ;
@synthesize myScrollView;
@synthesize myTableView;
@synthesize mainView;
@synthesize infoView;
@synthesize overlayView;
@synthesize tapGesture;
@synthesize panGesture;
@synthesize mainViewCenter;
@synthesize isMainView;
@synthesize mSocket;
@synthesize mReceivedInfoCount;

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
    UIView *mMainView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    UIView *mInfoView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    UIView *mOverlayView=[[UIView alloc] initWithFrame:CGRectMake(280, 0, 320, 460)];
    [self setMainView:mMainView];
    [self setInfoView:mInfoView];
    [self setOverlayView:mOverlayView];
    [[self view] addSubview:mMainView];
    [[self view] addSubview:mInfoView];
    [[self view] addSubview:mOverlayView];
    [[self view] sendSubviewToBack:mInfoView];
    [[self view] sendSubviewToBack:mOverlayView];
    [[self view] bringSubviewToFront:mMainView];
    [self setTapGesture:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClose)]];
    [self setPanGesture:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragView:)]];
    [self setMainViewCenter:[mMainView center]];
    [self setIsMainView:YES];
    [mMainView addGestureRecognizer:[self panGesture]];
    UIImageView *personInfoView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"personal_center_bg"]];
    [personInfoView setBounds:CGRectMake(0, 0, 280, 460)];
    [mInfoView addSubview:personInfoView];
    UIButton *shareButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton setFrame:CGRectMake(0, 193, 280, 42)];
    [shareButton addTarget:self action:@selector(onShare) forControlEvents:UIControlEventTouchUpInside];
    UIButton *settingButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [settingButton setFrame:CGRectMake(0, 238, 280, 40)];
    [settingButton addTarget:self action:@selector(onSetting) forControlEvents:UIControlEventTouchUpInside];
    //[settingButton setBackgroundColor:[UIColor whiteColor]];
    [mInfoView addSubview:shareButton];
    [mInfoView addSubview:settingButton];

    
    UIView *titleView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 43)];
    UIImageView *titleBackground=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title_bar"]];
    [titleBackground setBounds:CGRectMake(0, 0, 320, 43)];
    [titleView addSubview:titleBackground];
    UIButton *myInfoButton=[[UIButton alloc] initWithFrame:CGRectMake(10, 9, 28, 25)];
    [myInfoButton setBackgroundImage:[UIImage imageNamed:@"settings_button"] forState:UIControlStateNormal];
    [myInfoButton setBackgroundImage:[UIImage imageNamed:@"settings_button"] forState:UIControlStateHighlighted];
    [myInfoButton addTarget:self action:@selector(onMyInfoButton) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:myInfoButton];
    [[self mainView] addSubview:titleView];
    
    UIView *bottomView=[[UIView alloc] initWithFrame:CGRectMake(0, 405, 320, 55)];
    UIImageView *bottomBackground=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
    [bottomBackground setBounds:CGRectMake(0, 0, 320, 480)];
    [bottomView addSubview:bottomBackground];
    UIButton *publishButton=[[UIButton alloc] initWithFrame:CGRectMake(12.5, 10, 140, 35)];
    [publishButton setBackgroundImage:[UIImage imageNamed:@"release_function"] forState:UIControlStateNormal];
    [publishButton setBackgroundImage:[UIImage imageNamed:@"release_function"] forState:UIControlStateHighlighted];
    [publishButton addTarget:self action:@selector(onPublishButton) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:publishButton];
    UIButton *nearbyButton=[[UIButton alloc] initWithFrame:CGRectMake(167.5, 10, 140, 35)];
    [nearbyButton setBackgroundImage:[UIImage imageNamed:@"nearby_function"] forState:UIControlStateNormal];
    [nearbyButton setBackgroundImage:[UIImage imageNamed:@"nearby_function"] forState:UIControlStateHighlighted];
    [nearbyButton addTarget:self action:@selector(onNearbyButton) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:nearbyButton];
    [[self mainView] addSubview:bottomView];
    
    UITableView *listTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 360) style:UITableViewStylePlain];
    [listTable setDelegate:self];
    [listTable setDataSource:self];
    [listTable setScrollEnabled:NO];
    UINib *nib=[UINib nibWithNibName:@"iPinListTableViewCell" bundle:nil];
    [listTable registerNib:nib forCellReuseIdentifier:@"iPinListTableViewCell"];
    [self setMyTableView:listTable];
    
    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 43, 320, 360)];
    [scrollView setContentSize:CGSizeMake(scrollView.bounds.size.width, scrollView.bounds.size.height+1)];
    [scrollView setBackgroundColor:[UIColor whiteColor]];
    [scrollView setDelegate:self];
    //[scrollView addSubview:listTable];
    [self setMyScrollView:scrollView];
    RefreshHeaderAndFooterView *view = [[RefreshHeaderAndFooterView alloc] initWithFrame:CGRectMake(0, 0, myScrollView.frame.size.width, myScrollView.contentSize.height)];
    view.delegate = self;
    self.refreshHeaderAndFooterView = view;
    [self.refreshHeaderAndFooterView.refreshHeaderView updateRefreshDate:[NSDate date]];
    [[self mainView] addSubview:scrollView];
    [myScrollView addSubview:view];
    [myScrollView addSubview:listTable];
    
    if([self mSocket])
    {
        [[self mSocket] disconnect];
        [self setMSocket:nil];
    }
    else
    {
        [self setMSocket:[[AsyncSocket alloc] initWithDelegate:self]];
        [[self mSocket] connectToHost:@"www.ipinstudio.tk" onPort:20000 error:nil];
        NSData *tmpData=[@"InfoListRefresh 0 10" dataUsingEncoding:NSUTF8StringEncoding];
        [mSocket writeData:tmpData withTimeout:-1 tag:0];
        [mSocket readDataWithTimeout:-1 tag:0];
        [self setMReceivedInfoCount:0];
    }
    
    listItem=[[NSMutableArray alloc] init];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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
    //UIAlertView *myAlert=[[UIAlertView alloc] initWithTitle:@"拼车信息" message:msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"打电话",  nil];
    //[myAlert addButtonWithTitle:@"发短信"];
    //[myAlert show];
    [SGActionView showAlertWithTitle:@"拼车详情"
                             message:msg
                     leftButtonTitle:@"打电话"
                    rightButtonTitle:@"发短信"
                      selectedHandle:^(NSInteger index) {
                          NSLog(@"%d",index);
                          switch (index) {
                              case 0:
                              {
                                  //打电话
                                  NSString *str=[[NSString alloc] initWithFormat:@"tel://%@",[item telephone]];
                                  UIWebView *callView=[[UIWebView alloc] init];
                                  [callView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
                                  [[self view] addSubview:callView];
                                  break;
                              }
                              case 1:
                              {
                                  //发送短信
                                  MFMessageComposeViewController *controller=[[MFMessageComposeViewController alloc] init];
                                  if([MFMessageComposeViewController canSendText])
                                  {
                                      [controller setRecipients:[NSArray arrayWithObject:[item telephone]]];
                                      [controller setBody:[[NSString alloc] initWithFormat:@"同学您好，我通过iPin拼车看到您预定%@从%@出发，前往%@，我和您有相同或相近目的地，想和您一起拼车，可以吗？",[item date],[item fromPlace],[item toPlace]]];
                                      [controller setMessageComposeDelegate:self];
                                      [self presentViewController:controller animated:YES completion:nil];
                                      
                                  }
                                  break;
                              }
                              default:
                                  break;
                          }
                      }];
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
    //if(![scrollView isKindOfClass:[UITableView class]])
        [self.refreshHeaderAndFooterView RefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    //if(![scrollView isKindOfClass:[UITableView class]])
        [self.refreshHeaderAndFooterView RefreshScrollViewDidEndDragging:scrollView];
	
}
#pragma mark -
#pragma mark RefreshHeaderAndFooterViewDelegate Methods

- (void)RefreshHeaderAndFooterDidTriggerRefresh:(RefreshHeaderAndFooterView*)view{
	self.reloading = YES;
    if (view.refreshHeaderView.state == PullRefreshLoading) {//下拉刷新动作的内容
        //NSLog(@"header");
        [listItem removeAllObjects];
        [self setMReceivedInfoCount:0];
        [self setMSocket:[[AsyncSocket alloc] initWithDelegate:self]];
        [[self mSocket] connectToHost:@"www.ipinstudio.tk" onPort:20000 error:nil];
        NSData *tmpData=[[NSString stringWithFormat:@"InfoListRefresh %d 10",[self mReceivedInfoCount]] dataUsingEncoding:NSUTF8StringEncoding];
        [mSocket writeData:tmpData withTimeout:-1 tag:0];
        [mSocket readDataWithTimeout:-1 tag:0];
        [self setMReceivedInfoCount:0];
        
        [self performSelector:@selector(doneLoadingViewData) withObject:nil afterDelay:3.0];
        
    }else if(view.refreshFooterView.state == PullRefreshLoading){//上拉加载更多动作的内容
        //NSLog(@"footer");
        
        [self setMSocket:[[AsyncSocket alloc] initWithDelegate:self]];
        [[self mSocket] connectToHost:@"www.ipinstudio.tk" onPort:20000 error:nil];
        NSData *tmpData=[[NSString stringWithFormat:@"InfoListRefresh %d 10",[self mReceivedInfoCount]] dataUsingEncoding:NSUTF8StringEncoding];
        [mSocket writeData:tmpData withTimeout:-1 tag:0];
        [mSocket readDataWithTimeout:-1 tag:0];
        [self setMReceivedInfoCount:0];
        
        [self performSelector:@selector(doneLoadingViewData) withObject:nil afterDelay:3.0];
    }
}

- (BOOL)RefreshHeaderAndFooterDataSourceIsLoading:(RefreshHeaderAndFooterView*)view{
	
	return self.reloading; // should return if data source model is reloading
	
}
- (NSDate*)RefreshHeaderAndFooterDataSourceLastUpdated:(RefreshHeaderAndFooterView*)view{
    return [NSDate date];
}

- (void)onMyInfoButton
{
    [UIView animateWithDuration:0.5f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.mainView.frame = CGRectMake(280, 0, 320, 460);
        self.overlayView.frame = CGRectMake(280, 0, 320, 460);
    } completion:^(BOOL finished) {
        [[self view] bringSubviewToFront:[self overlayView]];
        [[self overlayView] addGestureRecognizer:[self tapGesture]];
        [[self overlayView] addGestureRecognizer:[self panGesture]];
        [[self mainView] removeGestureRecognizer:[self panGesture]];
        [self setIsMainView:NO];
    }];
}

- (void)tapClose
{
    [UIView animateWithDuration:0.5f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.mainView.frame = CGRectMake(0, 0, 320, 460);
        self.overlayView.frame = CGRectMake(0, 0, 320, 460);
    } completion:^(BOOL finished) {
        [[self view] bringSubviewToFront:[self mainView]];
        [[self overlayView] removeGestureRecognizer:[self tapGesture]];
        [[self overlayView] removeGestureRecognizer:[self panGesture]];
        [[self mainView] addGestureRecognizer:[self panGesture]];
        [self setIsMainView:YES];
    }];
}

- (void)dragView:(id)sender
{
    
    if ([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan)
    {
        mainViewCenter=[[self mainView] center];
    }
    if ([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded)
    {
        mainViewCenter=[[self mainView] center];
        if(mainViewCenter.x<320)
        {
            if(isMainView)
            {
                [UIView animateWithDuration:0.5f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                    self.mainView.frame = CGRectMake(0, 0, 320, 460);
                    self.overlayView.frame = CGRectMake(0, 0, 320, 460);
                } completion:nil];
            }
            else [self tapClose];
            
        }
        else
        {
            if(isMainView)
            {
                [self onMyInfoButton];
            }
            else
            {
                [UIView animateWithDuration:0.5f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                    self.mainView.frame = CGRectMake(280, 0, 320, 460);
                    self.overlayView.frame = CGRectMake(280, 0, 320, 460);
                } completion:nil];
            }
            
        }
        mainViewCenter=[[self mainView] center];
    }
    if ([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateChanged)
    {
        CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView:self.view];
        if(isMainView && translatedPoint.x>0)
        {
            CGPoint newCenter = CGPointMake(mainViewCenter.x + translatedPoint.x, mainViewCenter.y);
            [self mainView].center = newCenter;
            [self overlayView].center=newCenter;
        }
        else if (!isMainView && translatedPoint.x<0)
        {
            CGPoint newCenter = CGPointMake(mainViewCenter.x + translatedPoint.x, mainViewCenter.y);
            [self mainView].center = newCenter;
            [self overlayView].center=newCenter;
        }
        
    }
}

- (void)onPublishButton
{
    [self presentViewController:[[iPinPublishViewController alloc] init] animated:YES completion:nil];
}

- (void)onNearbyButton
{
    [self presentViewController:[[iPinNearbyViewController alloc] init] animated:YES completion:nil];
}

- (void)onShare
{
    [SGActionView showGridMenuWithTitle:@"分享给好友"
                             itemTitles:@[ @"短信",@"微博",@"微信",@"朋友圈" ]
                                 images:@[ [UIImage imageNamed:@"share_sms_icon"],
                                           [UIImage imageNamed:@"share_weibo_icon"],
                                           [UIImage imageNamed:@"share_wechat_icon"],
                                           [UIImage imageNamed:@"share_pengyouquan_icon"]]
                         selectedHandle:^(NSInteger index) {
                             NSLog(@"%d",index);
                             switch (index) {
                                 case 1:
                                 {
                                     //发送短信
                                     MFMessageComposeViewController *controller=[[MFMessageComposeViewController alloc] init];
                                     if([MFMessageComposeViewController canSendText])
                                     {
                                         //[controller setRecipients:[NSArray arrayWithObject:[item telephone]]];
                                         [controller setBody:[[NSString alloc] initWithFormat:@"我正在使用iPin拼车，感觉非常好用，来和我一起使用，一起拼车出行吧！"]];
                                         [controller setMessageComposeDelegate:self];
                                         [self presentViewController:controller animated:YES completion:nil];
                                         
                                     }
                                     break;
                                 }
                                 case 2:
                                 {
                                     NSLog(@"微博");
                                     break;
                                 }
                                 case 3:
                                 {
                                     NSLog(@"微信");
                                     break;
                                 }
                                 case 4:
                                 {
                                     NSLog(@"朋友圈");
                                     break;
                                 }
                                 default:
                                     break;
                             }
                         }];
}

- (void)onSetting
{
    [self presentViewController:[[iPinSettingViewController alloc] init] animated:YES completion:nil];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    if(result==MessageComposeResultCancelled || result==MessageComposeResultSent)
        [controller dismissViewControllerAnimated:YES completion:nil];
    //[self onShare];
}

- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSString *str=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSArray *tempStr=[str componentsSeparatedByString:@"`"];
    for(NSInteger i=0;i<[[tempStr objectAtIndex:0] intValue];i++)
    {
        [listItem addObject:[[iPinListItem alloc] initWithUsername:[tempStr objectAtIndex:(11*i+4)] sex:@"男" telephone:@"12345678901" fromPlace:[tempStr objectAtIndex:(11*i+5)] toPlace:[tempStr objectAtIndex:(11*i+6)] date:[tempStr objectAtIndex:(11*i+7)] detail:[tempStr objectAtIndex:(11*i+8)] seats:[NSString stringWithFormat:@"%d",(4-[[tempStr objectAtIndex:(11*i+10)] intValue])]]];
    }
    //[[self myTableView] reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
    
    [self setMReceivedInfoCount:[listItem count]];
    NSLog(@"Received Info Count:%d",[self mReceivedInfoCount]);
    [mSocket disconnect];
    [self setMSocket:nil];
    
    iPinListTableViewCell *cell=[myTableView dequeueReusableCellWithIdentifier:@"iPinListTableViewCell"];
    float height=[self mReceivedInfoCount]*[cell frame].size.height;
    //float height=[self mReceivedInfoCount]*88;
    if(height>360)
    {
        [myScrollView setContentSize:CGSizeMake(myScrollView.bounds.size.width, height+8)];
        [myTableView setFrame:CGRectMake(0, 0, 320, height+8)];
    }
    else
    {
        [myScrollView setContentSize:CGSizeMake(myScrollView.bounds.size.width, 360+1)];
        [myTableView setFrame:CGRectMake(0, 0, 320, 360+1)];
    }
    //[refreshHeaderAndFooterView setFrame:CGRectMake(0, 0, myScrollView.frame.size.width, myScrollView.contentSize.height)];
    //[refreshHeaderAndFooterView layoutSubviews];
    
    [refreshHeaderAndFooterView removeFromSuperview];
    [self setRefreshHeaderAndFooterView:nil];
    RefreshHeaderAndFooterView *view = [[RefreshHeaderAndFooterView alloc] initWithFrame:CGRectMake(0, 0, myScrollView.frame.size.width, myScrollView.contentSize.height)];
    view.delegate = self;
    [myScrollView addSubview:view];
    self.refreshHeaderAndFooterView = view;
    //[myScrollView addSubview:myTableView];
    [myScrollView bringSubviewToFront:myTableView];
    
    [[self myTableView] reloadData];
}
@end
