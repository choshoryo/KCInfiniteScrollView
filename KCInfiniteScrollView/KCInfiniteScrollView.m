//
//  KCInfiniteScrollView.m
//  
//
//
//  Copyright © 2015年 zero. All rights reserved.
//

#import "KCInfiniteScrollView.h"

static NSInteger const kItemCount = 20;
static NSString * const kCollectionCellID = @"KCCollectionCellID";

/************** KCImageCell begin **************/
@interface KCImageCell : UICollectionViewCell
/** image */
@property (nonatomic, strong) UIImage *image;
@end

@implementation KCImageCell
- (void)setImage:(UIImage *)image
{
    _image = image;
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    imageV.image = image;
    [self addSubview:imageV];
}
@end
/************** KCImageCell begin **************/

/************** KCInfiniteScrollView begin **************/
@interface KCInfiniteScrollView ()<UICollectionViewDataSource, UICollectionViewDelegate>
/** timer */
@property (nonatomic, strong) NSTimer *timer;
/** collectionView */
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation KCInfiniteScrollView

#pragma mark - 构造方法
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 设置流水布局
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        layout.itemSize = CGSizeMake(collectionViewW, collectionViewH);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal; // default is UICollectionViewScrollDirectionVertical
        layout.minimumLineSpacing = 0;
        
        // 创建collectionView
        UICollectionView *collectionV = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        collectionV.showsHorizontalScrollIndicator = NO;
        collectionV.showsVerticalScrollIndicator = NO;
        collectionV.dataSource = self;
        collectionV.delegate = self;
        collectionV.pagingEnabled = YES;
        [collectionV registerClass:[KCImageCell class] forCellWithReuseIdentifier:kCollectionCellID];
        [self addSubview:collectionV];
        
        self.collectionView = collectionV;
    }
    return self;
}

#pragma mark - 属性方法
- (void)setImageArray:(NSArray<UIImage *> *)imageArray
{
    _imageArray = imageArray;
    
    // 延迟执行计时器，防止起始定位第0个item
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 设置默认显示最中间的图片
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:kItemCount * self.imageArray.count / 2 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    
        [self startTimer];
    });
}

#pragma mark - 布局子控件
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 布局layout
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.itemSize = self.bounds.size;
    
    // 布局collectionView
    self.collectionView.frame = self.bounds;
}

#pragma mark - 定时器
- (void)startTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

- (void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)nextPage
{
    CGPoint offset = self.collectionView.contentOffset;
    offset.x += self.collectionView.bounds.size.width;
    [self.collectionView setContentOffset:offset animated:YES];
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return kItemCount * self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    KCImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionCellID forIndexPath:indexPath];
    cell.image = self.imageArray[indexPath.item % self.imageArray.count];
    
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}

/**
 *  scrollView滚动完毕的时候调用（通过setContentOffset:animated:滚动）
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self resetPosition];
}

/**
 *  scrollView滚动完毕的时候调用（人为拖拽滚动）
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self resetPosition];
}

#pragma mark - Other
- (void)resetPosition
{
    // 显示最中间的cell
    NSInteger oldItem = self.collectionView.contentOffset.x / self.collectionView.frame.size.width;
    NSInteger newItem = (kItemCount * self.imageArray.count / 2) + (oldItem % self.imageArray.count);
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:newItem inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

@end
/************** KCInfiniteScrollView begin **************/