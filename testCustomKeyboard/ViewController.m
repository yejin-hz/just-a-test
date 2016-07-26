//
//  ViewController.m
//  testCustomKeyboard
//
//  Created by Ye Jin on 16/3/3.
//  Copyright © 2016年 Ye Jin. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewController.h"

@interface ViewController ()<UIGestureRecognizerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    id target = self.navigationController.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    panGR.delegate = self;
    [self.view addGestureRecognizer:panGR];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    self.view.backgroundColor = [UIColor cyanColor];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    btn.backgroundColor = [UIColor yellowColor];
    [btn addTarget:self action:@selector(goToNextVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // Do any additional setup after loading the view, typically from a nib.
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.navigationController.viewControllers.count>1) {
        return YES;
    }
    else{
        return NO;
    }
}

- (void)goToNextVC{
    [self.navigationController pushViewController:[[CollectionViewController alloc] init] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
