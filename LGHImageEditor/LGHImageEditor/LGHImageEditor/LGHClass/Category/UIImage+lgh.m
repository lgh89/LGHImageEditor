//
//  UIImage+lgh.m
//  LGHImageEditor
//
//  Created by lgh on 17/1/5.
//  Copyright © 2017年 RJone. All rights reserved.
//

#import "UIImage+lgh.h"

@implementation UIImage (lgh)


+(UIImage*) OriginImage:(UIImage*)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);//size为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0,0, size.width, size.height)];
    
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;
}


@end
