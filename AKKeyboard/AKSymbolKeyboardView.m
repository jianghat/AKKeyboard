//
//  AKSymbolKeyboardView.m
//  AKKitDemo
//
//  Created by jianghat on 2017/8/9.
//  Copyright © 2017年 jiangshiquan. All rights reserved.
//

#import "AKSymbolKeyboardView.h"
#import "AKKit.h"

@interface AKSymbolKeyboardView ()

/** 删除按钮 */
@property (nonatomic, strong) UIButton *deleteButton;

/** 数字键盘切换按钮 */
@property (nonatomic, strong) UIButton *numberSwitchButton;

/** 字母键盘切换按钮 */
@property (nonatomic, strong) UIButton *letterSwitchButton;

@property (nonatomic, strong) NSMutableArray *buttonArray;
@property (nonatomic, copy) NSArray *symbolArray;

@end

@implementation AKSymbolKeyboardView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self addControl];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  CGFloat margin = 5;
  CGFloat buttonWidth = (self.width - margin * 11) / 10;
  CGFloat buttonHeight = (self.height - margin * 5) / 4;
  for (NSInteger index = 0; index < self.buttonArray.count; index++) {
    UIButton *button = self.buttonArray[index];
    button.size = CGSizeMake(buttonWidth, buttonHeight);
    if (index < 20) {
      CGFloat row = index / 10;
      CGFloat col = index % 10;
      button.left = margin + col * (buttonWidth + margin);
      button.top = margin + row * (buttonHeight + margin);
    }
    else if(index >= 20 && index < 28) {
      button.left = margin + (buttonWidth + margin) * 0.5 + (index - 20) * (buttonWidth + margin);
      button.top = margin + (buttonHeight + margin) * 2;
    }
    else {
      button.left = (margin * 2.5 + buttonWidth * 1.5) + ((index - 28) * (buttonWidth + margin));
      button.top = margin + (buttonHeight + margin) * 3;
    }
  }
  
  _numberSwitchButton.size = CGSizeMake(buttonWidth * 1.5, buttonHeight);
  _numberSwitchButton.left = margin;
  _numberSwitchButton.bottom = self.height - margin;
  
  _letterSwitchButton.size = _numberSwitchButton.size;
  _letterSwitchButton.right = self.width - margin;
  _letterSwitchButton.top = _numberSwitchButton.top;
  
  _deleteButton.size = _letterSwitchButton.size;
  _deleteButton.left = _letterSwitchButton.left;
  _deleteButton.bottom = _letterSwitchButton.top - margin;
}

- (void)addControl {
  UIImage *normalImage = [[UIImage imageNamed:@"AKKeyboard.bundle/c_charKeyboardButton"] resizableImageWithCapInsets:UIEdgeInsetsMake(14, 14, 14, 14)];
  UIImage *selectedImage = [[UIImage imageNamed:@"AKKeyboard.bundle/c_charKeyboardButtonSel"] resizableImageWithCapInsets:UIEdgeInsetsMake(14, 14, 14, 14)];
  for (NSString *title in self.symbolArray) {
    UIButton *button = [self button:title image:normalImage selectedImage:selectedImage];
    [button addTarget:self action:@selector(symbolButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    [self.buttonArray addObject:button];
  }
  
  @weakify(self);
  _deleteButton = [self button:@""
                         image:[UIImage imageNamed:@"AKKeyboard.bundle/c_symbol_keyboardDeleteButton"]
                 selectedImage:[UIImage imageNamed:@"AKKeyboard.bundle/c_symbol_keyboardDeleteButtonSel"]];
  [_deleteButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
    @strongify(self);
    if ([self.delegate respondsToSelector:@selector(keyboardView:didClickedDeleteButton:)]) {
      [self.delegate keyboardView:self didClickedDeleteButton:sender];
    }
  }];
  
  _numberSwitchButton = [self button:@"123"
                               image:[UIImage imageNamed:@"AKKeyboard.bundle/c_number_keyboardSwitchButton"]
                       selectedImage:[UIImage imageNamed:@"AKKeyboard.bundle/c_number_keyboardSwitchButtonSel"]];
  [_numberSwitchButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
    @strongify(self);
    if ([self.delegate respondsToSelector:@selector(keyboardView:didClickedNumberSwitchButton:)]) {
      [self.delegate keyboardView:self didClickedNumberSwitchButton:sender];
    }
  }];
  
  _letterSwitchButton = [self button:@"ABC"
                               image:[UIImage imageNamed:@"AKKeyboard.bundle/c_number_keyboardSwitchButton"]
                       selectedImage:[UIImage imageNamed:@"AKKeyboard.bundle/c_number_keyboardSwitchButtonSel"]];
  [_letterSwitchButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
    @strongify(self);
    if ([self.delegate respondsToSelector:@selector(keyboardView:didClickedTextSwitchButton:)]) {
      [self.delegate keyboardView:self didClickedTextSwitchButton:sender];
    }
  }];
  [self addSubview:_deleteButton];
  [self addSubview:_numberSwitchButton];
  [self addSubview:_letterSwitchButton];
}

- (UIButton *)button:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage {
  UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
  [button setBackgroundImage:image forState:UIControlStateNormal];
  [button setBackgroundImage:selectedImage forState:UIControlStateHighlighted];
  [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  [button setTitle:title forState:UIControlStateNormal];
  return button;
}

- (void)symbolButtonClicked:(UIButton *)sender {
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

- (NSArray *)symbolArray {
  if (!_symbolArray) {
    _symbolArray = @[@"!", @"@", @"#", @"$", @"%", @"^", @"&", @"*", @"(", @")", @"'", @"\"", @"=", @"_", @":", @";", @"?", @"~", @"|", @"•", @"+", @"-", @"\\", @"/", @"[", @"]", @"{", @"}", @",", @".", @"<", @">", @"€", @"£", @"¥"];
  }
  return _symbolArray;
}

@end
