//
//  Common.h
//  FilterGrid
//
//  Created by herui on 4/9/14.
//  Copyright (c) 2014年 rcplatform. All rights reserved.
//

#ifndef FilterGrid_Common_h
#define FilterGrid_Common_h

//宽高比
typedef enum{
    kAspectRatio1_1 = 0,
    kAspectRatio3_4,
    kAspectRatio4_3,
    kAspectRatio9_16,
    kAspectRatio16_9,
    
    kAspectRatioTotalNumber
}AspectRatio;

//调整图片参数
typedef struct{
    CGFloat brightness;        //亮度      -1 ~ 1     0
    CGFloat contrast;          //对比度   0.5 ~ 1.5    1
    CGFloat saturation;        //饱和度     0 ~ 2      1
    CGFloat colorTemperature;  //色温     0.5 ~ 2     1
    CGFloat sharpening;        //锐化       0 ~ 2     0
}AdjustImageParam;

#endif
