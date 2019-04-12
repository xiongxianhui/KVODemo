//
//  Person.m
//  KVO
//
//  Created by xiongxianhui on 2019/4/11.
//  Copyright © 2019 xianhui. All rights reserved.
//

#import "Person.h"

@implementation Person

-(NSMutableArray *)array {
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}

-(instancetype)init {
    
    if (self = [super init]) {
        
        _dog = [[Dog alloc] init];
    }
    return self;
}



/**
 调用模式,是否响应

 @param key KVO观察属性
 @return YES 正常发送通知; NO 不发送通知
 */
+(BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
    
    //监听属性为age时,不发送通知
    if ([key isEqualToString:@"age"]) {
        return NO;
    }
    return YES;
}

//属性依赖
+ (NSSet<NSString *> *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
    
    NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
    
    //dog属性的相关属性发生变化, 避免因为监听dog的多个属性而写多份KVO监听代码
    if ([key isEqualToString:@"dog"]) {
        keyPaths = [NSSet setWithObjects:@"_dog.age",@"_dog.color",nil];
    }
    return keyPaths;
}
@end
