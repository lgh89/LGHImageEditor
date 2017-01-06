//
//  LGHImageEditorController.m
//  LGHImageEditor
//
//  Created by lgh on 17/1/3.
//  Copyright © 2017年 RJone. All rights reserved.
//

#import "LGHImageEditorController.h"
#import "LGHEditorModel.h"
#import "LGHEditorCell.h"
#import "LGHHeader.h"
#import "LGHCommon.h"
#import "UIView+Frame.h"
#import "UIImage+lgh.h"
#import "UIImage+UIImageExt.h"
#import "ColorMatrix.h"
#import "ImageUtil.h"
#import "UIImageView+lgh.h"

static NSString * const lghEditorCellID = @"LGHEditorCell";

@interface LGHImageEditorController () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *adjustView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *funBottomHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *menuBottomHeight;
@property (nonatomic, weak) UIBarButtonItem *backItem;
@property (nonatomic, weak) UIBarButtonItem *rightItem;

@property (nonatomic, strong) NSMutableArray *menuDataSource;          //!< 菜单数据源
@property (nonatomic, strong) NSMutableArray *stickersDataSource;        //!< 边框数据源


@property (weak, nonatomic) IBOutlet UISlider *brightSlider;
@property (weak, nonatomic) IBOutlet UISlider *contrastSlider;
@property (weak, nonatomic) IBOutlet UISlider *saturationSlider;
@property (nonatomic, strong) UIImage *thumbImage;
@property (nonatomic, strong) UIImageView *stickerImageView;

@property (nonatomic, assign) NSInteger indexFunc;


@end

@implementation LGHImageEditorController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    self.view.backgroundColor = [UIColor whiteColor];
    self.editorImageView.image = [UIImage imageNamed:@"1.png"];

    [self setupUI];
}

- (void)dealloc{
    
    [self.menuDataSource removeAllObjects];
    [self.stickersDataSource removeAllObjects];
    self.thumbImage = nil;
    self.stickerImageView = nil;
}

#pragma mark - helper method

- (void)setupUI{
    
    self.navigationItem.title = @"编辑";
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(clickCancel:)];
    self.backItem = backItem;
    self.navigationItem.leftBarButtonItem = self.backItem;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(clickRight:)];
    self.rightItem = rightItem;
    self.navigationItem.rightBarButtonItem = self.rightItem;
    
    self.funBottomHeight.constant = -80;
    self.adjustView.hidden = YES;

    NSString *path = [[NSBundle mainBundle] pathForResource:@"LGHImageEditor" ofType:@"bundle"];
    NSString *brightPath = [path stringByAppendingPathComponent:@"brightness.png"];
    NSString *contrastPath = [path stringByAppendingPathComponent:@"contrast.png"];
    NSString *saturationPath = [path stringByAppendingPathComponent:@"saturation.png"];
    
    
    
    [self.brightSlider setThumbImage:[UIImage OriginImage:[UIImage imageWithContentsOfFile:brightPath] scaleToSize:CGSizeMake(30, 30)] forState:UIControlStateNormal];
    [self.contrastSlider setThumbImage: [UIImage OriginImage:[UIImage imageWithContentsOfFile:contrastPath] scaleToSize:CGSizeMake(30, 30)]forState:UIControlStateNormal];
    [self.saturationSlider setThumbImage:[UIImage OriginImage:[UIImage imageWithContentsOfFile:saturationPath]scaleToSize:CGSizeMake(30, 30)]forState:UIControlStateNormal];
    
//    self.stickersDataSource;
    
    [self.menuCollectionView registerNib:[UINib nibWithNibName:lghEditorCellID bundle:nil] forCellWithReuseIdentifier:lghEditorCellID];
    [self.funCollectionView registerNib:[UINib nibWithNibName:lghEditorCellID bundle:nil] forCellWithReuseIdentifier:lghEditorCellID];
}

- (void)loadFunData:(NSInteger)i{

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        if (i == 2) {
            
            [self.stickersDataSource removeAllObjects];
            
            NSString *path = [[NSBundle mainBundle] pathForResource:@"LGHImageEditor" ofType:@"bundle"];
            NSString *stickerPath = [path stringByAppendingPathComponent:@"stickers"];
            
            NSArray *nameArr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:stickerPath error:nil];
            [self.stickersDataSource removeAllObjects];
            for (NSString *name in nameArr) {
                
                LGHEditorModel *model = [[LGHEditorModel alloc] init];
                model.iconName = [stickerPath stringByAppendingPathComponent:name];
                model.image = nil;
                [self.stickersDataSource addObject:model];
            }
        }else if (i == 0){
            
            NSArray *arr = [NSArray arrayWithObjects:@"原图",@"LOMO",@"黑白",@"复古",@"哥特",@"锐色",@"淡雅",@"酒红",@"青柠",@"浪漫",@"光晕",@"蓝调",@"梦幻",@"夜色", nil];
            [self.stickersDataSource removeAllObjects];

            for (int i = 0; i < arr.count; i++) {
                
                LGHEditorModel *model = [[LGHEditorModel alloc] init];
                model.iconName = nil;
                model.image = [self imageWithIndex:i];
                model.menuTitle = arr[i];
                [self.stickersDataSource addObject:model];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
           
            [self.funCollectionView reloadData];
            self.funCollectionView.contentOffset = CGPointMake(0, 0);
        });
    });
}


- (UIImage *)imageWithIndex:(NSInteger)index{
    
//    UIImage *ImageUtil;
    UIImage *image = self.thumbImage;
//    ImageUtil imagewithima
    switch (index) {
        case 0:
        {
            return image;
        }
            break;
        case 1:
        {
            return [ImageUtil imageWithImage:image withColorMatrix:colormatrix_lomo];
        }
            break;
        case 2:
        {
            return[ImageUtil imageWithImage:image withColorMatrix:colormatrix_heibai];
        }
            break;
        case 3:
        {
            return [ImageUtil imageWithImage:image withColorMatrix:colormatrix_huajiu];
        }
            break;
        case 4:
        {
            return [ImageUtil imageWithImage:image withColorMatrix:colormatrix_gete];
        }
            break;
        case 5:
        {
            return [ImageUtil imageWithImage:image withColorMatrix:colormatrix_ruise];
        }
            break;
        case 6:
        {
            return [ImageUtil imageWithImage:image withColorMatrix:colormatrix_danya];
        }
            break;
        case 7:
        {
            return [ImageUtil imageWithImage:image withColorMatrix:colormatrix_jiuhong];
        }
            break;
        case 8:
        {
            return [ImageUtil imageWithImage:image withColorMatrix:colormatrix_qingning];
        }
            break;
        case 9:
        {
            return [ImageUtil imageWithImage:image withColorMatrix:colormatrix_langman];
        }
            break;
        case 10:
        {
            return [ImageUtil imageWithImage:image withColorMatrix:colormatrix_guangyun];
        }
            break;
        case 11:
        {
            return [ImageUtil imageWithImage:image withColorMatrix:colormatrix_landiao];
            
        }
            break;
        case 12:
        {
            return[ImageUtil imageWithImage:image withColorMatrix:colormatrix_menghuan];
            
        }
            break;
        case 13:
        {
            return [ImageUtil imageWithImage:image withColorMatrix:colormatrix_yese];
            
        }
    }
    return nil;
}

#pragma mark - event handle

- (void)clickCancel:(UIBarButtonItem *)backItem{
    
    if ([backItem.title isEqualToString:@"返回"]) {
        
        //        [self.navigationController popViewControllerAnimated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        
        switch (self.indexFunc) {
            case 0:
                self.editorImageView.image = self.thumbImage;
                break;
            default:
                break;
        }
        [self cancelMethod];
    }
}

- (void)clickRight:(UIBarButtonItem *)rightItem{
    
    if ([rightItem.title isEqualToString:@"确定"]) {
        
        switch (self.indexFunc) {
                
            case 2:
                self.editorImageView.image = [self.editorImageView imageFromImageView];
                [self.stickerImageView removeFromSuperview];
                self.stickerImageView = nil;
                break;
                
            default:
                break;
        }
        
        [self cancelMethod];
    }else{
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(finishWithImageView:)]) {
            
            [self.delegate finishWithImageView:self.editorImageView];
        }
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)cancelMethod{
    
    _backItem.title = @"返回";
    _rightItem.title = @"完成";
    if (self.adjustView.hidden == NO) {
        
        self.brightSlider.value = 0;
        self.contrastSlider.value = 1;
        self.saturationSlider.value = 1;
        
        [UIView animateWithDuration:0.25 animations:^{
            
            self.adjustView.hidden = YES;
            self.menuBottomHeight.constant = 0;
            [self.view layoutIfNeeded];
        }];
    }else{
        
        [UIView animateWithDuration:0.25 animations:^{
            
            self.funBottomHeight.constant = -80;
            [self.view layoutIfNeeded];
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.25 animations:^{
                
                self.menuBottomHeight.constant = 0;
                [self.view layoutIfNeeded];
            }];
        }];
    }
}


- (IBAction)clickSlider:(UISlider *)sender {
    
    static BOOL inProgress = NO;
    
    if(inProgress){ return; }
    inProgress = YES;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *image = [self filteredImage:self.thumbImage];
        [self.editorImageView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:NO];
        inProgress = NO;
    });

}

- (UIImage*)filteredImage:(UIImage*)image
{
    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    CIFilter *filter = [CIFilter filterWithName:@"CIColorControls" keysAndValues:kCIInputImageKey, ciImage, nil];
    
    [filter setDefaults];
    [filter setValue:[NSNumber numberWithFloat:_saturationSlider.value] forKey:@"inputSaturation"];
    
    filter = [CIFilter filterWithName:@"CIExposureAdjust" keysAndValues:kCIInputImageKey, [filter outputImage], nil];
    [filter setDefaults];
    CGFloat brightness = 2 * self.brightSlider.value;
    [filter setValue:[NSNumber numberWithFloat:brightness] forKey:@"inputEV"];
    
    filter = [CIFilter filterWithName:@"CIGammaAdjust" keysAndValues:kCIInputImageKey, [filter outputImage], nil];
    [filter setDefaults];
    CGFloat contrast   = _contrastSlider.value*_contrastSlider.value;
    [filter setValue:[NSNumber numberWithFloat:contrast] forKey:@"inputPower"];
    
    CIContext *context = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer : @(NO)}];
    CIImage *outputImage = [filter outputImage];
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    
    UIImage *result = [UIImage imageWithCGImage:cgImage];
    
    CGImageRelease(cgImage);
    
    return result;
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (collectionView != self.menuCollectionView) {
        return self.stickersDataSource.count;
    }
    return self.menuDataSource.count;

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LGHEditorCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:lghEditorCellID forIndexPath:indexPath];
    
    if (collectionView == self.menuCollectionView) {
        
        cell.model = self.menuDataSource[indexPath.row];
    }else{
        
        cell.model = self.stickersDataSource[indexPath.row];
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(kItemWidth - 15, kItemWidth);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return kLineSpace;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView == self.menuCollectionView) {
        
        if (indexPath.row == 2) {
            
            [UIView animateWithDuration:3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.navigationItem.title = @"边框";
            } completion:nil];
            
            [UIView animateWithDuration:0.25 animations:^{
                
                self.menuBottomHeight.constant = -80;
                [self.view layoutIfNeeded];
            } completion:^(BOOL finished) {
               
//                [self loadFunData:indexPath.row];
                [UIView animateWithDuration:0.25 animations:^{
                   
                    self.funBottomHeight.constant = -20;
                    [self.view layoutIfNeeded];
                }];
                
            }];
        }else if (indexPath.row == 1){
            
            [UIView animateWithDuration:3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.navigationItem.title = @"调整";
            } completion:nil];
            
            [UIView animateWithDuration:0.25 animations:^{
               
//                [self loadFunData:indexPath.row];
                self.menuBottomHeight.constant = -80;
                self.adjustView.hidden = NO;
                [self.view layoutIfNeeded];
                
            }];
        }else if (indexPath.row == 0){
            
            [UIView animateWithDuration:3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.navigationItem.title = @"滤镜";
            } completion:nil];
            
            [UIView animateWithDuration:0.25 animations:^{
                
                self.menuBottomHeight.constant = -80;
                [self.view layoutIfNeeded];
            } completion:^(BOOL finished) {
                
                //                [self loadFunData:indexPath.row];
                [UIView animateWithDuration:0.25 animations:^{
                    
                    self.funBottomHeight.constant = 0;
                    [self.view layoutIfNeeded];
                }];
                
            }];
        }
        self.backItem.title = @"取消";
        self.rightItem.title = @"确定";
        self.thumbImage = [[UIImage alloc] initWithCGImage:self.editorImageView.image.CGImage];
        self.indexFunc = indexPath.row;
        [self loadFunData:indexPath.row];
        
    }else if (collectionView == self.funCollectionView){
        
        if (self.indexFunc == 0) {
            
            self.editorImageView.image = [self imageWithIndex:indexPath.row];
        }else if (self.indexFunc == 2){
            
            [self.stickerImageView removeFromSuperview];
            
            self.stickerImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[self.stickersDataSource[indexPath.row] iconName]]];
            self.stickerImageView.frame = self.editorImageView.bounds;
            [self.editorImageView addSubview:self.stickerImageView];
        }
    }
}


#pragma mark - Setter & Getter

- (NSMutableArray *)menuDataSource{
    
    if (_menuDataSource == nil) {
        
        _menuDataSource = [[NSMutableArray alloc] init];
        
        NSArray *icon = @[@"filter.png", @"adjustment.png", @"sticker.png", @"text.png"];
        NSArray *title = @[@"滤镜", @"调整", @"边框", @"文本"];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"LGHImageEditor" ofType:@"bundle"];
        
        for (int i = 0; i < icon.count; i++) {
            
            NSString *iconName = [path stringByAppendingPathComponent:icon[i]];
            LGHEditorModel *model = [[LGHEditorModel alloc] init];
            model.menuTitle = title[i];
            model.iconName = iconName;
            [_menuDataSource addObject:model];
        }
    }
    return _menuDataSource;
}

- (NSMutableArray *)stickersDataSource{
    
    if (_stickersDataSource == nil) {
        
        _stickersDataSource = [[NSMutableArray alloc] init];
    }
    return _stickersDataSource;
}

@end






