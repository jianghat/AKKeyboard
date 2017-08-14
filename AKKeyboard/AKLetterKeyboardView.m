//
//  AKLetterKeyboardView.m
//  AKKitDemo
//
//  Created by jianghat on 2017/8/9.
//  Copyright © 2017年 jiangshiquan. All rights reserved.
//

#import "AKLetterKeyboardView.h"
#import "AKKit.h"

@interface AKLetterKeyboardView ()

/** 大小写切换按钮 */
@property (nonatomic, strong) UIButton *trasitionLetterButton;

/** 删除按钮 */
@property (nonatomic, strong) UIButton *deleteButton;

/** 数字键盘切换按钮 */
@property (nonatomic, strong) UIButton *numberButton;

/** 符号键盘切换按钮 */
@property (nonatomic, strong) UIButton *symbolButton;

/** 空格按钮 */
@property (nonatomic, strong) UIButton *spaceButton;

@property (nonatomic, strong) NSMutableArray *buttonArray;
@property (nonatomic, copy) NSArray *lowercaseArray;
@property (nonatomic, copy) NSArray *uppercaseArray;

@end

@implementation AKLetterKeyboardView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self addControl];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  CGFloat margin = 5;
  CGFloat buttonWidth = (self.width - margin * 13) / 10;
  CGFloat buttonHeight = (self.height - margin * 5) / 4;
  CGFloat margin2 = (self.width - 8 * margin - 9 * buttonWidth)/2;
  for (NSInteger index = 0; index < self.buttonArray.count; index++) {
    UIButton *button = self.buttonArray[index];
    button.size = CGSizeMake(buttonWidth, buttonHeight);
    if (index < 10) {
      button.left = margin * 2 + index * (buttonWidth + margin);
      button.top = margin;
    }
    else if (index >= 10 && index < 19) {
      button.left = margin2 + (index - 10) * (buttonWidth + margin);
      button.top = 2 * margin + buttonHeight;
    }
    else if (index >= 19 && index < 26) {
      button.left = margin2 + buttonWidth + margin + (index - 19) * (buttonWidth + margin);
      button.top = margin * 3 + buttonHeight * 2;
      
      if (index == 19) {
        _trasitionLetterButton.left = margin;
        _trasitionLetterButton.top = button.top;
        _trasitionLetterButton.width = button.left - margin * 4;
        _trasitionLetterButton.height = button.height;
        
        _deleteButton.right = self.width - margin - _trasitionLetterButton.width;
        _deleteButton.top = button.top;
        _deleteButton.size = _trasitionLetterButton.size;
      }
    }
    
    _spaceButton.centerX = self.centerX;
    _spaceButton.bottom = self.height - margin;
    _spaceButton.width = buttonWidth * 5 + margin * 4;
    _spaceButton.height = buttonHeight;
    
    _numberButton.left = margin;
    _numberButton.top = _spaceButton.top;
    _numberButton.width = _spaceButton.left - margin * 2;
    _numberButton.height = _spaceButton.height;
    
    _symbolButton.left = self.width - _numberButton.width -  margin;
    _symbolButton.top = _numberButton.top;
    _symbolButton.size = _numberButton.size;
  }
}

- (void)addControl {
  UIImage *normalImage = [[UIImage imageNamed:@"AKKeyboard.bundle/c_charKeyboardButton"] resizableImageWithCapInsets:UIEdgeInsetsMake(14, 14, 14, 14)];
  UIImage *selectedImage = [[UIImage imageNamed:@"AKKeyboard.bundle/c_charKeyboardButtonSel"] resizableImageWithCapInsets:UIEdgeInsetsMake(14, 14, 14, 14)];
  for (NSString *title in self.lowercaseArray) {
    UIButton *button = [self button:title image:normalImage selectedImage:selectedImage];
    [button addTarget:self action:@selector(letterButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    [self.buttonArray addObject:button];
  }
  
  @weakify(self);
  _trasitionLetterButton = [self button:@""
                                  image:[UIImage imageNamed:@"AKKeyboard.bundle/c_charKeyboardShiftButton"]
                          selectedImage:[UIImage imageNamed:@"AKKeyboard.bundle/c_charKeyboardShiftButtonSel"]];
  [_trasitionLetterButton setBackgroundImage:[UIImage imageNamed:@"AKKeyboard.bundle/c_charKeyboardShiftButtonSel"] forState:UIControlStateSelected];
  [_trasitionLetterButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(UIButton *sender) {
    @strongify(self);
    self.trasitionLetterButton.selected = !sender.selected;
    for (NSInteger index = 0; index < self.buttonArray.count; index++) {
      UIButton *button = self.buttonArray[index];
      if (sender.selected) {
        [button setTitle:self.uppercaseArray[index] forState:UIControlStateNormal];
      }
      else {
        [button setTitle:self.lowercaseArray[index] forState:UIControlStateNormal];
      }
    }
  }];
  
  _deleteButton = [self button:@""
                         image:[UIImage imageNamed:@"AKKeyboard.bundle/c_symbol_keyboardDeleteButton"]
                 selectedImage:[UIImage imageNamed:@"AKKeyboard.bundle/c_symbol_keyboardDeleteButtonSel"]];
  [_deleteButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(UIButton *sender) {
    @strongify(self);
    if ([self.delegate respondsToSelector:@selector(keyboardView:didClickedDeleteButton:)]) {
      [self.delegate keyboardView:self didClickedDeleteButton:sender];
    }
  }];
  
  _numberButton = [self button:@"123"
                         image:[UIImage imageNamed:@"AKKeyboard.bundle/c_number_keyboardSwitchButton"]
                 selectedImage:[UIImage imageNamed:@"AKKeyboard.bundle/c_number_keyboardSwitchButtonSel"]];
  [_numberButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(UIButton *sender) {
    @strongify(self);
    if ([self.delegate respondsToSelector:@selector(keyboardView:didClickedNumberSwitchButton:)]) {
      [self.delegate keyboardView:self didClickedNumberSwitchButton:sender];
    }
  }];
  
  _symbolButton = [self button:@"#+="
                         image:[UIImage imageNamed:@"AKKeyboard.bundle/c_number_keyboardSwitchButton"]
                 selectedImage:[UIImage imageNamed:@"AKKeyboard.bundle/c_number_keyboardSwitchButtonSel"]];
  [_symbolButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(UIButton *sender) {
    @strongify(self);
    if ([self.delegate respondsToSelector:@selector(keyboardView:didClickedSymbolSwitchButton:)]) {
      [self.delegate keyboardView:self didClickedSymbolSwitchButton:sender];
    }
  }];
  
  _spaceButton = [self button:@"空 格" image:normalImage selectedImage:selectedImage];
  [_spaceButton addTarget:self action:@selector(letterButtonClicked:) forControlEvents:UIControlEventTouchUpInside];

  [self addSubview:_trasitionLetterButton];
  [self addSubview:_deleteButton];
  [self addSubview:_numberButton];
  [self addSubview:_symbolButton];
  [self addSubview:_spaceButton];
}

- (UIButton *)button:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage {
  UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
  [button setBackgroundImage:image forState:UIControlStateNormal];
  [button setBackgroundImage:selectedImage forState:UIControlStateHighlighted];
  [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  [button setTitle:title forState:UIControlStateNormal];
  return button;
}

- (void)letterButtonClicked:(UIButton *)sender {
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

- (NSArray *)lowercaseArray {
  if (!_lowercaseArray) {
    _lowercaseArray = @[@"q",@"w",@"e",@"r",@"t",@"y",@"u",@"i",@"o",@"p",@"a",@"s",@"d",@"f",@"g",@"h",@"j",@"k",@"l",@"z",@"x",@"c",@"v",@"b",@"n",@"m"];
  }
  return _lowercaseArray;
}

- (NSArray *)uppercaseArray {
  if (!_uppercaseArray) {
    _uppercaseArray = @[@"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"I",@"O",@"P",@"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L",@"Z",@"X",@"C",@"V",@"B",@"N",@"M"];
  }
  return _uppercaseArray;
}

@end
