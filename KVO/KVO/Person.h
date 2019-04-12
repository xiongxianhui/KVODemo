//
//  Person.h
//  KVO
//
//  Created by xiongxianhui on 2019/4/11.
//  Copyright © 2019 xianhui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dog.h"
NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property(nonatomic,copy)NSString *name;
@property(nonatomic,assign)NSInteger age;

@property(nonatomic,strong)Dog *dog;

@property(nonatomic,strong)NSMutableArray *array;
@end

NS_ASSUME_NONNULL_END
