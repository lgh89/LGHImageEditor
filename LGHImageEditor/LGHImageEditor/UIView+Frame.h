//
//  UIView+Frame.h
//  testForCocopod
//
//  Created by lgh on 16/10/30.
//  Copyright © 2016年 ruizi_G. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

/** x */
@property (nonatomic, assign) CGFloat x;
/** y*/
@property (nonatomic, assign) CGFloat y;
/** origin*/
@property (nonatomic, assign) CGPoint origin;
/** size*/
@property (nonatomic, assign) CGSize size;
/** centerX*/
@property (nonatomic, assign) CGFloat centerX;
/** centerY*/
@property (nonatomic, assign) CGFloat centerY;
/** width*/
@property (nonatomic, assign) CGFloat width;
/** height*/
@property (nonatomic, assign) CGFloat height;

@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;

@end
