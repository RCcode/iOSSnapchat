//
//  ScrrenshotToolBar.m
//  FilterGrid
//
//  Created by herui on 5/9/14.
//  Copyright (c) 2014年 rcplatform. All rights reserved.
//

#import "ScrrenshotToolBar.h"
#import "ToolBarItem.h"

@interface ScrrenshotToolBar()
{
    UIButton *_currItem;
}
@end

@implementation ScrrenshotToolBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = colorWithHexString(@"#1f1f1f");
        
        NSArray *titles = @[@"1:1", @"3:4", @"4:3", @"9:16", @"16:9"];
        
        CGFloat itemH = frame.size.height;
        CGFloat itemW = frame.size.width / kAspectRatioTotalNumber;
        for (AspectRatio i=kAspectRatio1_1; i<kAspectRatioTotalNumber; i++) {
            CGFloat itemX = i * itemW;
            UIButton *item = [[ToolBarItem alloc] initWithFrame:CGRectMake(itemX, 0, itemW, itemH)];
            [self addSubview:item];
            item.tag = i;
            [item addTarget:self action:@selector(itemOnClick:) forControlEvents:UIControlEventTouchUpInside];
            [item setTitle:titles[i] forState:UIControlStateNormal];
            [item setTitleColor:colorWithHexString(@"#ffffff") forState:UIControlStateSelected];
            [item setTitleColor:colorWithHexString(@"#878787") forState:UIControlStateNormal];

            if(i == 0){
                [self itemOnClick:item];
            }
        }
        
    }
    return self;
}

- (void)itemOnClick:(UIButton *)item{
//    NSLog(@"itemOnClick, %d", item.tag);
    
    _currItem.selected = NO;
    item.selected = YES;
    _currItem = item;
    
    if([_delegate respondsToSelector:@selector(scrrenshotToolBar:ItemOnClick:)]){
        [_delegate scrrenshotToolBar:self ItemOnClick:(AspectRatio)item.tag];
    }
}

@end
