//
//  ViewController.m
//  KCInfiniteScrollViewDemo
//
//  Created by Kevin Cheung on 16/5/11.
//  Copyright © 2016年 zero. All rights reserved.
//

#import "ViewController.h"
#import "KCInfiniteScrollView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    KCInfiniteScrollView *scrollView = [[KCInfiniteScrollView alloc] init];
    scrollView.imageArray = @[
                          [UIImage imageNamed:@"img_00"],
                          [UIImage imageNamed:@"img_01"],
                          [UIImage imageNamed:@"img_02"],
                          ];
    scrollView.frame = CGRectMake(0, 20, self.view.frame.size.width, 200);
    [self.view addSubview:scrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
