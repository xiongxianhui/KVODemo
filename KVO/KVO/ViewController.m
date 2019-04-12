//
//  ViewController.m
//  KVO
//
//  Created by xiongxianhui on 2019/4/11.
//  Copyright © 2019 xianhui. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/message.h>
@interface ViewController ()

@property(nonatomic,strong)Person *person;
@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.person = [[Person alloc] init];
    
    NSLog(@"注册之前%s", object_getClassName(self.person));
    
    //监听属性
    [self.person addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    
    NSLog(@"注册之后%s", object_getClassName(self.person));
    
    //监听对象属性
    [self.person addObserver:self forKeyPath:@"dog" options:NSKeyValueObservingOptionNew context:nil];
    
    //监听容器类
    [self.person addObserver:self forKeyPath:@"array" options:NSKeyValueObservingOptionNew context:nil];
    
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    [self willChangeValueForKey:@"name"];
    id newChange = change[NSKeyValueChangeNewKey];
    [self didChangeValueForKey:@"name"];
    NSLog(@"newChange = %@",newChange);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    self.person.name = @"jack";
    self.person.dog.color = @"棕色";
    
    self.person.name = @"jack";
    self.person.dog.color = @"棕色";
    //该方法无法触发
    [self.person.array  addObject:@"元素"];
    //使用以下方法可以触发
    NSMutableArray *tempArray = [self.person mutableArrayValueForKey:@"array"];
    [tempArray addObject:@"元素"];
    
}


- (void)dealloc {
    [self.person removeObserver:self forKeyPath:@"name"];
    [self.person removeObserver:self forKeyPath:@"dog"];
    [self.person removeObserver:self forKeyPath:@"array"];
}
@end
