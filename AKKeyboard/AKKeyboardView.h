//
//  AKKeyboard.h
//  AKKitDemo
//
//  Created by jianghat on 2017/8/9.
//  Copyright © 2017年 jiangshiquan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AKKeyboard.h"

@interface AKKeyboardView : UIView

@property (nonatomic, weak) UITextField<UITextInput> *textInput;
@property (nonatomic) AKKeyboardViewType keyboardType;
@property (nonatomic) BOOL random;

- (instancetype)initWithTextInput:(UITextField<UITextInput> *) textInput;
- (instancetype)initWithFrame:(CGRect)frame UNAVAILABLE_ATTRIBUTE;
- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

@end
