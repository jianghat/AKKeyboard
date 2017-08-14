//
//  AKWeakProxy.m
//  AKKitDemo
//
//  Created by jianghat on 2017/8/8.
//  Copyright © 2017年 jiangshiquan. All rights reserved.
//

#import "AKWeakProxy.h"

@implementation AKWeakProxy

- (instancetype)initWithTarget:(id)target {
  _target = target;
  return self;
}

+ (instancetype)proxyWithTarget:(id)target {
  return [[AKWeakProxy alloc] initWithTarget:target];
}

@end
