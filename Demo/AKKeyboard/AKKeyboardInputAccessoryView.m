//
//  AKKeyboardInputAccessoryView.m
//  AKKitDemo
//
//  Created by jianghat on 2017/8/9.
//  Copyright © 2017年 jiangshiquan. All rights reserved.
//

#import "AKKeyboardInputAccessoryView.h"
#import "AKKit.h"

@interface AKKeyboardInputAccessoryView ()

@property (nonatomic, strong) UIButton *doneButton;
// 分割线
@property (nonatomic, strong) UIView *lineView;

@end

@implementation AKKeyboardInputAccessoryView

- (instancetype)init {
  self = [super initWithFrame:CGRectMake(0.f, 0.f, kScreenWidth, 30.f)];
  if (self) {
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.doneButton];
    [self addSubview:self.lineView];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  self.doneButton.right = self.width;
  self.doneButton.size = CGSizeMake(60, self.height);
}

#pragma mark- Custom Access

- (UIButton *)doneButton {
  if (!_doneButton) {
    _doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_doneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_doneButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [_doneButton setTitle:@"完 成" forState:UIControlStateNormal];
    
    @weakify(self);
    [_doneButton setBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
      @strongify(self);
      [self.nextResponder resignFirstResponder];
    }];
  }
  return _doneButton;
}

@end
