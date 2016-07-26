//
//  CollectionViewController.m
//  testCustomKeyboard
//
//  Created by Ye Jin on 16/7/22.
//  Copyright © 2016年 Ye Jin. All rights reserved.
//

#import "CollectionViewController.h"
#import "horizontalLayout.h"

@interface CollectionViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    horizontalLayout *Hlayout = [[horizontalLayout alloc] init];
    Hlayout.minimumLineSpacing = 10;
    Hlayout.minimumInteritemSpacing = 10;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 264, [[UIScreen mainScreen] bounds].size.width, 200) collectionViewLayout:Hlayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    //注册cell
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.collectionView];
    
    id target = self.navigationController.interactivePopGestureRecognizer.delegate;
    NSLog(@"%@", self.navigationController.interactivePopGestureRecognizer);
    UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    [self.view addGestureRecognizer:panGR];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell
    if (indexPath.row == 0) {
        cell.backgroundColor = [UIColor magentaColor];
    }
    else if (indexPath.row == 1){
        cell.backgroundColor = [UIColor yellowColor];
    }
    else{
        cell.backgroundColor = [UIColor cyanColor];
    }
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
 }
 
 - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
 }
 
 - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
 }
 */

#pragma mark --UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(200, 200);
}

#pragma mark --UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}

@end
