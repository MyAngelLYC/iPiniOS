//
//  iPinMainViewController.h
//  iPin
//
//  Created by 刘亦辰 on 14-6-11.
//  Copyright (c) 2014年 ___iPinStudio___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "iPinLoginViewController.h"
#import "iPinListTableViewCell.h"
#import "iPinListItem.h"
#import "RefreshHeaderAndFooterView.h"
#import "iPinPublishViewController.h"
#import "iPinNearbyViewController.h"
#import "iPinSettingViewController.h"
#import "SGActionView.h"
#import "iPinShareCenter.h"

@interface iPinMainViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,RefreshHeaderAndFooterViewDelegate,MFMessageComposeViewControllerDelegate>
{
    NSMutableArray *listItem;
    bool isFirstShow;
}

@property(nonatomic,weak)RefreshHeaderAndFooterView * refreshHeaderAndFooterView;
@property(nonatomic,assign)BOOL reloading;
@property(nonatomic,weak)UIScrollView *myScrollView;
@property(nonatomic,strong)UITableView *myTableView;
@property(nonatomic,weak)UIView *mainView;
@property(nonatomic,weak)UIView *infoView;
@property(nonatomic,weak)UIView *overlayView;
@property(nonatomic,strong)UIGestureRecognizer *tapGesture;
@property(nonatomic,strong)UIGestureRecognizer *panGesture;
@property(nonatomic)CGPoint mainViewCenter;
@property(nonatomic)BOOL isMainView;
@property(nonatomic)NSInteger mReceivedInfoCount;

- (void)onMyInfoButton;
- (void)tapClose;
- (void)onPublishButton;
- (void)onNearbyButton;
- (void)onShare;
- (void)onSetting;

@end
