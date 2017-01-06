//
//  UIImage+UIImageExt.h
//  图片处理
//
//  Created by 灿 on 13-10-15.
//  Copyright (c) 2013年 灿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UIImageExt)
- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize;
@end
