//
//  AKKeyboard.m
//  AKKitDemo
//
//  Created by jianghat on 2017/8/9.
//  Copyright © 2017年 jiangshiquan. All rights reserved.
//

#import "AKKeyboardView.h"
#import "AKKeyboardInputAccessoryView.h"
#import "AKNumberKeyboardView.h"
#import "AKLetterKeyboardView.h"
#import "AKSymbolKeyboardView.h"
#import "AKKit.h"

@interface AKKeyboardView () <AKKeyboardViewDelegate>

@end

@implementation AKKeyboardView

- (instancetype)initWithTextInput:(UITextField<UITextInput> *) textInput {
  self = [super initWithFrame:CGRectMake(0.f, 0.f, kScreenWidth, 216)];
  if (self) {
    _textInput = textInput;
    _textInput.inputAccessoryView = [[AKKeyboardInputAccessoryView alloc] init];
  }
  return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
  if (!newSuperview) return;
  
  if (_keyboardType & (AKKeyboardViewTypeInt | AKKeyboardViewTypeFloat | AKKeyboardViewTypeIDCard)) {
    [self keyboardView:nil didClickedNumberSwitchButton:nil];
  }
  else {
    [self keyboardView:nil didClickedTextSwitchButton:nil];
  }
}

#pragma mark - AKKeyboardViewDelegate

- (void)keyboardView:(UIView *)keyboardView didClickedSymbolSwitchButton:(UIButton *)button {
  [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
  AKSymbolKeyboardView *symbolKeyboardView = [[AKSymbolKeyboardView alloc] initWithFrame:self.bounds];
  symbolKeyboardView.keyboardType = _keyboardType;
  symbolKeyboardView.textInput = _textInput;
  symbolKeyboardView.delegate = self;
  symbolKeyboardView.random = _random;
  [self addSubview:symbolKeyboardView];
}

#pragma mark - AKNumberKeyboardDelegate

- (void)keyboardView:(UIView *)keyboardView didClickedTextSwitchButton:(UIButton *)textButton {
  [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
  AKLetterKeyboardView *letterKeyboardView = [[AKLetterKeyboardView alloc] initWithFrame:self.bounds];
  letterKeyboardView.keyboardType = _keyboardType;
  letterKeyboardView.textInput = _textInput;
  letterKeyboardView.delegate = self;
  letterKeyboardView.random = _random;
  [self addSubview:letterKeyboardView];
}

#pragma mark - AKLetterKeyboardViewDelegate

- (void)keyboardView:(UIView *)keyboardView didClickedNumberSwitchButton:(UIButton *)button {
  [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
  AKNumberKeyboardView *numberKeyboardView = [[AKNumberKeyboardView alloc] initWithFrame:self.bounds];
  numberKeyboardView.keyboardType = _keyboardType;
  numberKeyboardView.textInput = _textInput;
  numberKeyboardView.delegate = self;
  numberKeyboardView.random = _random;
  [self addSubview:numberKeyboardView];
}

@end
