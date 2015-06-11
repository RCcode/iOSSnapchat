//
//  RCPikerViewTextFiled.h
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/11.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCPikerViewTextFiled : UITextField

//占位文本(编辑不隐藏)
@property (nonatomic, copy) NSString *userPlaceHolder;
//输入文本
@property (nonatomic, copy) NSString *userText;

@end
