//
//  horizontalLayout.m
//  testCustomKeyboard
//
//  Created by Ye Jin on 16/7/22.
//  Copyright © 2016年 Ye Jin. All rights reserved.
//

#import "horizontalLayout.h"

@implementation horizontalLayout

- (void)prepareLayout{
    [super prepareLayout];
    //水平滚动
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置内边框
    CGFloat inset = (self.collectionView.bounds.size.width-200)/2.0;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    //获得super已经计算好的布局属性
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    //计算collectionView最中心点的X值
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width * 0.5;
    
    //在原有布局属性的基础上，进行微调
    for (UICollectionViewLayoutAttributes *attrs in array) {
        //cell的中心点x和collectionView最中心点的x值的间距
        CGFloat delta = fabs(attrs.center.x - centerX);
        
        //根据间距值计算cell的缩放比例
        CGFloat scale = 1 - delta / self.collectionView.bounds.size.width;
        
        //设置缩放比例
//        attrs.transform = CGAffineTransformMakeScale(scale, scale);
        attrs.size = CGSizeMake(attrs.size.width*scale, attrs.size.height*scale);
    }
    
    return array;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    //计算出最终显示的矩形框
    CGRect rect;
    rect.origin.y = 0;
    rect.origin.x = proposedContentOffset.x;
    rect.size = self.collectionView.bounds.size;
    
    //获得super已经计算好的布局属性
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    //计算collectionView最中心点的x值
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    //存放最小的间距值
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        if (fabs(minDelta) > fabs(attrs.center.x - centerX)) {
            minDelta = attrs.center.x - centerX;
        }
    }
    
    //修改原有的偏移量
    proposedContentOffset.x += minDelta;
    return proposedContentOffset;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

@end
