//
//  KCInfiniteScrollView.h
//
//
//  
//  Copyright © 2015年 zero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KCInfiniteScrollView : UIView
/** 需要显示的图片数组(要求里面存放UIImage对象) */
@property (nonatomic, strong) NSArray<UIImage *> *imageArray;
@end
