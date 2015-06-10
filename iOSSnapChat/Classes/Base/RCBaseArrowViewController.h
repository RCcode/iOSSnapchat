//
//  RCBaseArrowViewController.h
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/10.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCBaseArrowViewController : UIViewController

//在基类控制器设置箭头右边的文本
@property (nonatomic, copy) NSString *arrowTitle;
//基类控制器实现此方法实现Return
- (void)arrowBackDidClicked;

@end
