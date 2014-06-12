//
//  iPinMainViewController.h
//  iPin
//
//  Created by 刘亦辰 on 14-6-11.
//  Copyright (c) 2014年 ___iPinStudio___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iPinListTableViewCell.h"
#import "iPinListItem.h"
#import "RefreshHeaderAndFooterView.h"

@interface iPinMainViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,RefreshHeaderAndFooterViewDelegate>
{
    NSMutableArray *listItem;
}

@property(nonatomic,strong)RefreshHeaderAndFooterView * refreshHeaderAndFooterView;
@property(nonatomic,assign)BOOL reloading;
@property(nonatomic,weak)UIScrollView *myScrollView;
@property(nonatomic,strong)UITableView *myTableView;

@end
