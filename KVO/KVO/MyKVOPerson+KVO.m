//
//  MyKVOPerson+KVO.m
//  KVO
//
//  Created by xiongxianhui on 2019/4/11.
//  Copyright © 2019 xianhui. All rights reserved.
//

#import "MyKVOPerson+KVO.h"
#import <objc/message.h>
@implementation MyKVOPerson (KVO)

- (void)my_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context {
    
    //创建子类
    //创建一个新的类  模仿系统类 NSKVONotifying_MyKVOPerson
    NSString *oldClassName = NSStringFromClass(self.class);
    NSString *newClassName = [@"MYKVONotifying_" stringByAppendingString:oldClassName];
    
    //创建类 并且注册类
    Class myClass = objc_allocateClassPair(self.class, newClassName.UTF8String, 0);
    objc_registerClassPair(myClass);
    
    //重写setName方法 实际是添加一个和父类同名的方法
    class_addMethod(myClass, @selector(setName:), (IMP)setName, "v@:@");
    
    //外部改变isa指针指向
    object_setClass(self, myClass);
    
    //属性绑定  将观察者保存到当前对象 OBJC_ASSOCIATION_ASSIGN weak 防止循环引用
    objc_setAssociatedObject(self, @"Observer", observer, OBJC_ASSOCIATION_ASSIGN);
}

void setName(id self,SEL _cmd,NSString *newName) {
  
    NSLog(@"修改成功");
    //调用父类的setName方法,改变name的值
    Class class = [self class];
    object_setClass(self, class_getSuperclass(class));
    
    ((void(*)(id,SEL,NSString *))objc_msgSend)(self,@selector(setName:),newName);
    
    //拿到观察者
    id observer = objc_getAssociatedObject(self, @"Observer");
    if (observer) {
        //发消息
        ((void (*)(id, SEL,NSString*,id, NSDictionary<NSKeyValueChangeKey,id> *,void *))objc_msgSend)(observer, @selector(observeValueForKeyPath:ofObject:change:context:),@"name",self,@{@"name":newName,@"kind":@1},nil);
    }
    
    //修改为self,改回子类
    object_setClass(self, class);
    
}

@end
