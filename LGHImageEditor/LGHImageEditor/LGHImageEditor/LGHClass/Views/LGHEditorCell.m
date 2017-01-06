//
//  LGHEditorCell.m
//  LGHImageEditor
//
//  Created by lgh on 17/1/3.
//  Copyright © 2017年 RJone. All rights reserved.
//

#import "LGHEditorCell.h"
#import "LGHEditorModel.h"

@interface LGHEditorCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation LGHEditorCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

#pragma mark - Setter & Getter

- (void)setModel:(LGHEditorModel *)model{
    
    _model = model;
    
    if (model.iconName) {
        
        self.imageView.image = [UIImage imageWithContentsOfFile:model.iconName];
    }else if (model.image){
        
        self.imageView.image = model.image;
    }
    
    self.titleLabel.text = model.menuTitle;
}

@end
