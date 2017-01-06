//
//  LGHImageEditorController.h
//  LGHImageEditor
//
//  Created by lgh on 17/1/3.
//  Copyright © 2017年 RJone. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LGHImageEditorControllerDelegate <NSObject>

- (void)finishWithImageView:(UIImageView *)imageView;

@end

@interface LGHImageEditorController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *editorImageView;

@property (weak, nonatomic) IBOutlet UICollectionView *menuCollectionView;

@property (weak, nonatomic) IBOutlet UICollectionView *funCollectionView;

@property (nonatomic, weak) id<LGHImageEditorControllerDelegate> delegate;


@end
