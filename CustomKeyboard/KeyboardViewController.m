//
//  KeyboardViewController.m
//  CustomKeyboard
//
//  Created by Ye Jin on 16/3/3.
//  Copyright © 2016年 Ye Jin. All rights reserved.
//

#import "KeyboardViewController.h"

@interface KeyboardViewController ()
@property (nonatomic, strong) UIButton *nextKeyboardButton;
@end

@implementation KeyboardViewController

//大小写切换
//- (void)changeUpOrDown:(UIButton *)shiftKey
//{
//    for(NSArray *buttons in self.allButtons)
//    {
//        for (UIButton button in buttons)
//            {
//                NSString title = [button titleForState:UIControlStateNormal];
//                if (self.isPressShiftKey)
//                {
//                    title = [title uppercaseString];
//                }
//                else
//                {
//                    title = [title lowercaseString];
//                }
//                [button setTitle:title forState:(UIControlStateNormal)];
//            }
//    }
//}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    // Add custom view sizing constraints here
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Perform custom UI setup here
//    self.nextKeyboardButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    
//    [self.nextKeyboardButton setTitle:NSLocalizedString(@"Next Keyboard", @"Title for 'Next Keyboard' button") forState:UIControlStateNormal];
//    [self.nextKeyboardButton sizeToFit];
//    self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = NO;
//    
//    [self.nextKeyboardButton addTarget:self action:@selector(advanceToNextInputMode) forControlEvents:UIControlEventTouchUpInside];
//    
//    [self.view addSubview:self.nextKeyboardButton];
//    
//    NSLayoutConstraint *nextKeyboardButtonLeftSideConstraint = [NSLayoutConstraint constraintWithItem:self.nextKeyboardButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
//    NSLayoutConstraint *nextKeyboardButtonBottomConstraint = [NSLayoutConstraint constraintWithItem:self.nextKeyboardButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
//    [self.view addConstraints:@[nextKeyboardButtonLeftSideConstraint, nextKeyboardButtonBottomConstraint]];
    
    
    
    NSArray *buttonTitles1 = [NSArray arrayWithObjects:@"Q", @"W", @"E", @"R", @"T", @"Y", @"U", @"I", @"O", @"P", nil];
    NSArray *buttonTitles2 = [NSArray  arrayWithObjects:@"A", @"S", @"D", @"F", @"G", @"H", @"J", @"K", @"L", nil];
    NSArray *buttonTitles3 = [NSArray arrayWithObjects:@"CP", @"Z", @"X", @"C", @"V", @"B", @"N", @"M", @"BP", nil];
    NSArray *buttonTitles4 = [NSArray arrayWithObjects:@"CHG", @"SPACE", @"RETURN", nil];
    
    UIView *row1 = [self creatRowOfButtons:buttonTitles1];
    row1.translatesAutoresizingMaskIntoConstraints = NO;
    UIView *row2 = [self creatRowOfButtons:buttonTitles2];
    row2.translatesAutoresizingMaskIntoConstraints = NO;
    UIView *row3 = [self creatRowOfButtons:buttonTitles3];
    row3.translatesAutoresizingMaskIntoConstraints = NO;
    UIView *row4 = [self creatRowOfButtons:buttonTitles4];
    row4.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray *rows = [NSArray arrayWithObjects:row1, row2, row3, row4, nil];
    
    [self.view addSubview:row1];
    [self.view addSubview:row2];
    [self.view addSubview:row3];
    [self.view addSubview:row4];
    
    [self addConstraintsToInputView:self.view withView:rows];
}

//divide and conquered
- (UIView *)creatRowOfButtons:(NSArray *)buttonTitles
{
    NSMutableArray *buttons = [[NSMutableArray alloc] init];
    UIView *keyboardRowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
    for (NSString *buttonTitle in buttonTitles) {
        UIButton *button = [self createButtonWithTitle:buttonTitle];
        [buttons addObject:button];
        [keyboardRowView addSubview:button];
    }
    
    [self addIndividualButtonConstraints:buttons withView:keyboardRowView];
    
    return keyboardRowView;
}

- (UIButton *)createButtonWithTitle:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, 0, 0);
    [button setTitle:title forState:UIControlStateNormal];
    [button sizeToFit];
    [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:1.0]];
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)didTapButton:(UIButton *)sender
{
    UIButton *button = sender;
    NSString *title = [button titleForState:UIControlStateNormal];
    id proxy = self.textDocumentProxy;
//    [proxy insertText:title];
    if ([title isEqualToString:@"CP"]) {
        //大小写切换，有空写;
    }
    else if ([title isEqualToString:@"BP"]) {
        [proxy deleteBackward];
    }
    else if ([title isEqualToString:@"RETURN"]){
        [proxy insertText:@"\n"];
    }
    else if ([title isEqualToString:@"SPACE"]){
        [proxy insertText:@" "];
    }
    else if ([title isEqualToString:@"CHG"]){
        [self advanceToNextInputMode];
    }
    else{
        [proxy insertText:title];
    }
}

- (void)addIndividualButtonConstraints:(NSMutableArray *)buttons withView:(UIView *)mainView
{
    for (UIButton *button in buttons) {
        NSInteger index = [buttons indexOfObject:button];
        NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:mainView attribute:NSLayoutAttributeTop multiplier:1.0 constant:1];
        NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:mainView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-1];
        NSLayoutConstraint *rightConstraint = [[NSLayoutConstraint alloc]init];
        if (index == buttons.count-1) {
            rightConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:mainView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-1];
        }
        else{
            UIButton *nextButton = [buttons objectAtIndex:index+1];
            rightConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:nextButton attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-1];
        }
        NSLayoutConstraint *leftConstraint = [[NSLayoutConstraint alloc] init];
        if (index == 0) {
            leftConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:mainView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:1];
        }
        else{
            UIButton *pervtButton = [buttons objectAtIndex:index-1];
            leftConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:pervtButton attribute:NSLayoutAttributeRight multiplier:1.0 constant:1];
            
            UIButton *firstButton = [buttons objectAtIndex:0];
            NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:firstButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:button attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
            
            [mainView addConstraint:widthConstraint];
        }
        
        [mainView addConstraint:topConstraint];
        [mainView addConstraint:bottomConstraint];
        [mainView addConstraint:rightConstraint];
        [mainView addConstraint:leftConstraint];
    }
}

- (void)addConstraintsToInputView:(UIView *)mainView withView:(NSArray *)rows
{
    for (UIView *row in rows) {
        NSInteger index = [rows indexOfObject:row];
        NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:row attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:mainView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:1];
        NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:row attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:mainView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-1];
        NSLayoutConstraint *bottomContraint = [[NSLayoutConstraint alloc] init];
        if (index == [rows count]-1) {
            bottomContraint = [NSLayoutConstraint constraintWithItem:row attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:mainView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-1];
        }
        else{
            UIView *nextRow = [rows objectAtIndex:index+1];
            bottomContraint = [NSLayoutConstraint constraintWithItem:row attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:nextRow attribute:NSLayoutAttributeTop multiplier:1.0 constant:-1];
        }
        NSLayoutConstraint *topContraint = [[NSLayoutConstraint alloc] init];
        if (index == 0) {
            topContraint = [NSLayoutConstraint constraintWithItem:row attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:mainView attribute:NSLayoutAttributeTop multiplier:1.0 constant:1];
        }
        else{
            UIView *pervtOrw = [rows objectAtIndex:index-1];
            topContraint = [NSLayoutConstraint constraintWithItem:row attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:pervtOrw attribute:NSLayoutAttributeBottom multiplier:1.0 constant:1];
            
            UIView *firstRow = [rows objectAtIndex:0];
            NSLayoutConstraint *heightContraint = [NSLayoutConstraint constraintWithItem:firstRow attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:row attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
            [mainView addConstraint:heightContraint];
        }
        
        [mainView addConstraint:leftConstraint];
        [mainView addConstraint:rightConstraint];
        [mainView addConstraint:bottomContraint];
        [mainView addConstraint:topContraint];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
}

- (void)textWillChange:(id<UITextInput>)textInput {
    // The app is about to change the document's contents. Perform any preparation here.
}

- (void)textDidChange:(id<UITextInput>)textInput {
    // The app has just changed the document's contents, the document context has been updated.
    
    UIColor *textColor = nil;
    if (self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearanceDark) {
        textColor = [UIColor whiteColor];
    } else {
        textColor = [UIColor blackColor];
    }
    [self.nextKeyboardButton setTitleColor:textColor forState:UIControlStateNormal];
}

@end
