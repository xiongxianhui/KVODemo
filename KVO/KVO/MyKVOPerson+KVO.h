//
//  MyKVOPerson+KVO.h
//  KVO
//
//  Created by xiongxianhui on 2019/4/11.
//  Copyright © 2019 xianhui. All rights reserved.
//

#import "MyKVOPerson.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyKVOPerson (KVO)

- (void)my_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;

@end

NS_ASSUME_NONNULL_END
