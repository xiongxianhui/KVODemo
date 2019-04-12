//
//  MyKVOViewController.m
//  KVO
//
//  Created by xiongxianhui on 2019/4/11.
//  Copyright © 2019 xianhui. All rights reserved.
//

#import "MyKVOViewController.h"
#import "MyKVOPerson.h"
#import "MyKVOPerson+KVO.h"
#import <objc/message.h>
@interface MyKVOViewController ()
@property(nonatomic,strong)MyKVOPerson *person;
@end

@implementation MyKVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.person = [[MyKVOPerson alloc] init];
    
//    [self.person addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    
//    NSLog(@"注册之前%s", object_getClassName(self.person));
    [self.person my_addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
//    NSLog(@"注册之后%s", object_getClassName(self.person));
    
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
//    id newChange = change[NSKeyValueChangeNewKey];
    NSLog(@"newChange = %@ ",change );
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    self.person.name = @"jack";
    
    
}


- (void)dealloc {
    [self.person removeObserver:self forKeyPath:@"name"];
   
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
