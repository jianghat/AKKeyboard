//
//  AKKeyboard.m
//  AKKitDemo
//
//  Created by jianghat on 2017/8/9.
//  Copyright © 2017年 jiangshiquan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, AKKeyboardViewType) {
  AKKeyboardViewTypeDefault = 100,
  AKKeyboardViewTypeInt,
  AKKeyboardViewTypeFloat,
  AKKeyboardViewTypeIDCard,
  AKKeyboardViewTypeWord
};

@protocol AKKeyboardViewDelegate <NSObject>

@optional
- (void)keyboardView:(UIView *)keyboardView didClickedTextSwitchButton:(UIButton *)textButton;

- (void)keyboardView:(UIView *)keyboardView didClickedNumberSwitchButton:(UIButton *)button;

- (void)keyboardView:(UIView *)keyboardView didClickedSymbolSwitchButton:(UIButton *)button;

@end
