//
//  AKNumberKeyboard.m
//  AKKitDemo
//
//  Created by jianghat on 2017/8/9.
//  Copyright © 2017年 jiangshiquan. All rights reserved.
//

#import "AKNumberKeyboardView.h"
#import "AKKit.h"

@interface AKNumberKeyboardView ()

/** 删除按钮 */
@property (nonatomic, strong) UIButton *deleteButton;

/** 符号按钮 */
@property (nonatomic, strong) UIButton *symbolButton;

/** ABC 文字按钮 */
@property (nonatomic, strong) UIButton *textButton;

/** . 按钮 */
@property (nonatomic, strong) UIButton *decimalButton;

@property (nonatomic, strong) NSMutableArray *buttonArray;
@property (nonatomic, copy) NSArray *defaultArray;
@property (nonatomic, copy) NSArray *numberArray;

@end

@implementation AKNumberKeyboardView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self addControl];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  NSInteger count = self.numberArray.count;
  if (_random) {
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = 0 ; i < count; i++) {
      uint32_t j = arc4random_uniform((uint32_t)count);
      NSString *numberString = self.numberArray[j];
      if ([array containsObject:numberString]) {
        i--;
        continue;
      }
      [array addObject:numberString];
    }
    for (NSInteger i = 0; i < count; i++) {
      UIButton *button = self.buttonArray[i];
      [button setTitle:array[i] forState:UIControlStateNormal];
    }
  }
  
  CGFloat margin = 5;
  CGFloat buttonWidth = (self.width - 4 * margin) / 3;
  CGFloat buttonHeight = (self.height - 5 * margin) / 4;
  
  for (NSInteger index = 0; index < count; index++) {
    UIButton *button = self.buttonArray[index];
    button.size = CGSizeMake(buttonWidth, buttonHeight);
    if (index == 0) {
      button.centerX = self.centerX;
      button.centerY = self.height - margin - button.height * 0.5;
      
      self.textButton.left = margin;
      self.textButton.top = button.top;
      self.textButton.width = (button.width - margin)/2.0;
      self.textButton.height = button.height;
      
      self.symbolButton.left = self.textButton.right + margin;
      self.symbolButton.top = self.textButton.top;
      self.symbolButton.size = self.textButton.size;
      
      self.decimalButton.left = margin;
      self.decimalButton.top = button.top;
      self.decimalButton.size = button.size;
      
      self.deleteButton.left = button.right + margin;
      self.deleteButton.top = button.top;
      self.deleteButton.size = button.size;
    }
    else {
      CGFloat row = (index - 1) / 3;
      CGFloat col = (index - 1) % 3;
      button.left = margin + col * (buttonWidth + margin);
      button.top = margin + row * (buttonHeight + margin);
    }
  }
}

- (void)addControl {
  UIImage *normalImage = [[UIImage imageNamed:@"AKKeyboard.bundle/c_charKeyboardButton"] resizableImageWithCapInsets:UIEdgeInsetsMake(14, 14, 14, 14)];
  UIImage *selectedImage = [[UIImage imageNamed:@"AKKeyboard.bundle/c_charKeyboardButtonSel"] resizableImageWithCapInsets:UIEdgeInsetsMake(14, 14, 14, 14)];
  for (NSString *title in self.numberArray) {
    UIButton *button = [self button:title image:normalImage selectedImage:selectedImage];
    [button addTarget:self action:@selector(numberButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    [self.buttonArray addObject:button];
  }
  
  _decimalButton = [self button:@"." image:normalImage selectedImage:selectedImage];
  [_decimalButton setBackgroundImage:[[UIImage imageNamed:@"AKKeyboard.bundle/c_number_keyboardSwitchButton"] resizableImageWithCapInsets:UIEdgeInsetsMake(14, 14, 14, 14)]
                            forState:UIControlStateDisabled];
  [_decimalButton addTarget:self action:@selector(numberButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
  
  @weakify(self);
  _deleteButton = [self button:nil
                         image:[UIImage imageNamed:@"AKKeyboard.bundle/c_number_keyboardDeleteButton"]
                 selectedImage:[UIImage imageNamed:@"AKKeyboard.bundle/c_number_keyboardDeleteButton"]];
  [_deleteButton addBlockForControlEvents:UIControlEventTouchDown block:^(id sender) {
    @strongify(self);
    if ([self.delegate respondsToSelector:@selector(keyboardView:didClickedDeleteButton:)]) {
      [self.delegate keyboardView:self didClickedDeleteButton:self.deleteButton];
    }
  }];
  
  _symbolButton = [self button:@"#+="
                         image:[UIImage imageNamed:@"AKKeyboard.bundle/c_number_keyboardSwitchButton"]
                 selectedImage:[UIImage imageNamed:@"AKKeyboard.bundle/c_number_keyboardSwitchButtonSel"]];
  [_symbolButton setBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
    @strongify(self);
    if ([self.delegate respondsToSelector:@selector(keyboardView:didClickedSymbolSwitchButton:)]) {
      [self.delegate keyboardView:self didClickedSymbolSwitchButton:self.symbolButton];
    }
  }];
  
  _textButton = [self button:@"ABC"
                       image:[UIImage imageNamed:@"AKKeyboard.bundle/c_number_keyboardSwitchButton"]
               selectedImage:[UIImage imageNamed:@"AKKeyboard.bundle/c_number_keyboardSwitchButtonSel"]];
  [_textButton setBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
    @strongify(self);
    if ([self.delegate respondsToSelector:@selector(keyboardView:didClickedTextSwitchButton:)]) {
      [self.delegate keyboardView:self didClickedTextSwitchButton:self.textButton];
    }
  }];
  [self addSubview:_decimalButton];
  [self addSubview:_deleteButton];
  [self addSubview:_symbolButton];
  [self addSubview:_textButton];
}

- (UIButton *)button:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage {
  UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
  [button setBackgroundImage:image forState:UIControlStateNormal];
  [button setBackgroundImage:selectedImage forState:UIControlStateHighlighted];
  [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  [button setTitle:title forState:UIControlStateNormal];
  return button;
}

- (void)numberButtonClicked:(id)sender {
  if ([self.delegate respondsToSelector:@selector(keyboardView:didClickedTextButton:)]) {
    [self.delegate keyboardView:self didClickedTextButton:sender];
  }
}

#pragma mark - Custom Access

- (NSMutableArray *)buttonArray {
  if (!_buttonArray) {
    _buttonArray = [NSMutableArray new];
  }
  return _buttonArray;
}

- (NSArray *)numberArray {
  if (!_numberArray) {
    _numberArray = @[@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9"];
  }
  return _numberArray;
}

- (void)setKeyboardType:(AKKeyboardViewType)keyboardType {
  _keyboardType = keyboardType;
  if (_keyboardType == AKKeyboardViewTypeInt || _keyboardType == AKKeyboardViewTypeFloat || _keyboardType == AKKeyboardViewTypeIDCard) {
    self.symbolButton.hidden = YES;
    self.textButton.hidden = YES;
    self.decimalButton.enabled = YES;
    if (_keyboardType == AKKeyboardViewTypeInt) {
      self.decimalButton.enabled = NO;
    }
    else if (_keyboardType == AKKeyboardViewTypeFloat) {
      [self.decimalButton setTitle:@"." forState:UIControlStateNormal];
      self.decimalButton.hidden = NO;
    }
    else if (_keyboardType == AKKeyboardViewTypeIDCard) {
      [self.decimalButton setTitle:@"X" forState:UIControlStateNormal];
      self.decimalButton.hidden = NO;
    }
  }
  else {
    self.decimalButton.hidden = YES;
    self.symbolButton.hidden = NO;
    self.textButton.hidden = NO;
  }
}

@end
