//
//  ViewController.m
//  AKKitDemo
//
//  Created by jianghat on 2017/8/7.
//  Copyright © 2017年 jiangshiquan. All rights reserved.
//

#import "ViewController.h"
#import "AKKeyboardView.h"
#import "AKKeyboardInputAccessoryView.h"

@interface ViewController ()

@property (nonatomic, strong) UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  _textField = [[UITextField alloc] initWithFrame:CGRectMake(50, 200, 200, 44)];
  _textField.backgroundColor = [UIColor redColor];
  AKKeyboardView *keyboardView = [[AKKeyboardView alloc] initWithTextInput:self.textField];
  keyboardView.keyboardType = AKKeyboardViewTypeWord;
  keyboardView.textInput = _textField;
  _textField.inputView = keyboardView;
  [self.view addSubview:_textField];
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

@end
