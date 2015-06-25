//
//  RCMainLikeMessageTableViewCell.h
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/25.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCMainLikeMessageTableViewCell : UITableViewCell

@property (nonatomic, strong) NSURL *showIconURL;
@property (nonatomic, copy) NSString *showTitle;
@property (nonatomic, assign) BOOL isMore;

@end
