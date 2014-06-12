//
//  iPinListTableViewCell.h
//  iPin
//
//  Created by 刘亦辰 on 14-6-11.
//  Copyright (c) 2014年 ___iPinStudio___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iPinListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *backImage;
- (void)changeSex;
@end
