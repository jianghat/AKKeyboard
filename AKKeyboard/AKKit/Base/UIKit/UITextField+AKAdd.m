//
//  UITextField+AKAdd.m
//  AKKitDemo
//
//  Created by jianghat on 2017/8/7.
//  Copyright © 2017年 jiangshiquan. All rights reserved.
//

#import "UITextField+AKAdd.h"

@implementation UITextField (AKAdd)

- (CGFloat)leftMargin {
  return self.leftView.frame.size.width;
}

- (void)setLeftMargin:(CGFloat)leftMargin {
  UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, leftMargin, 0.f)];
  self.leftViewMode = UITextFieldViewModeAlways;
  self.leftView = leftView;
}

- (CGFloat)rightMargin {
  return self.leftView.frame.size.width;
}

- (void)setRightMargin:(CGFloat)rightMargin {
  UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, rightMargin, 0.f)];
  self.rightViewMode = UITextFieldViewModeAlways;
  self.rightView = rightView;
}

@end
