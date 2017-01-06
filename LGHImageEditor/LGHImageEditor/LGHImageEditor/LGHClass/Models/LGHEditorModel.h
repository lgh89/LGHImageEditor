//
//  LGHEditorModel.h
//  LGHImageEditor
//
//  Created by lgh on 17/1/5.
//  Copyright © 2017年 RJone. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIImage;

@interface LGHEditorModel : NSObject

@property (nonatomic, copy) NSString *iconName;      //!< icon

@property (nonatomic, copy) NSString *menuTitle;     //!< title

@property (nonatomic, strong) UIImage *image;        //!< image


@end
