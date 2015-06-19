//
//  RCMainLikeTableViewCell.h
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/19.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCMainLikeTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImage *showIcon;
@property (nonatomic, copy) NSString *showTitle;
@property (nonatomic, copy) NSString *moreTitle;
@property (nonatomic, assign) BOOL isMore;

@end
