//
//  UIControl+AKKit.h
//  AKKitDemo
//
//  Created by jianghat on 2017/8/7.
//  Copyright © 2017年 jiangshiquan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (AKAdd)

- (void)setTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

- (void)addBlockForControlEvents:(UIControlEvents)controlEvents block:(void (^)(id sender))block;

- (void)setBlockForControlEvents:(UIControlEvents)controlEvents block:(void (^)(id sender))block;

@end
