//
//  ViewController.m
//  LGHImageEditor
//
//  Created by lgh on 17/1/3.
//  Copyright © 2017年 RJone. All rights reserved.
//

#import "ViewController.h"
#import "LGHImageEditorController.h"

static BOOL flag = 0;

@interface ViewController () <LGHImageEditorControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    flag = 0;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (flag == 0) {
        
        LGHImageEditorController *vc = [[LGHImageEditorController alloc] init];
        vc.delegate = self;
//        vc.editorImageView.image = [UIImage imageNamed:@"1.png"];
        
        UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
        
        [self presentViewController:nvc animated:YES completion:nil];
        flag = 1;
    }
}

- (void)finishWithImageView:(UIImageView *)imageView{
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    imageView1.image = imageView.image;
    [self.view addSubview:imageView1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
