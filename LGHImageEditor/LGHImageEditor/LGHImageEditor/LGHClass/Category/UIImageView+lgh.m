//
//  UIImageView+lgh.m
//  LGHImageEditor
//
//  Created by lgh on 17/1/6.
//  Copyright © 2017年 RJone. All rights reserved.
//

#import "UIImageView+lgh.h"

@implementation UIImageView (lgh)

- (UIImage *)imageFromImageView{
    
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
