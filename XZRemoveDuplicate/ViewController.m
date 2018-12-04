//
//  ViewController.m
//  XZRemoveDuplicate
//
//  Created by kkxz on 2018/12/4.
//  Copyright © 2018 kkxz. All rights reserved.
//

#import "ViewController.h"
#import "Model.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *originalArray = @[@1, @2, @3, @1, @3];
    //1.无序的去重
    //利用NSDictionary的AllKeys（AllValues）方法
    /*
     可以将NSArray中的元素存入一个字典，然后利用AllKeys或者AllValues取得字典的所有键或值，这些键或值都是去重的
     */
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    for(NSNumber *n in originalArray){
        [dict setObject:n forKey:n];
    }
    NSLog(@"dict result : %@",[dict allValues]);
    
    //利用NSSet特性，放入集合自动去重
    /*
     NSSet的特点：确定性、无序性、互异性
     */
   NSSet * set = [NSSet setWithArray:originalArray];
   NSLog(@"set result: %@", [set allObjects]);
    
  //2.有序去重
  //开辟新的内存空间(使用containsObject：方法)
  /*
   判断是否存在，若不存在则添加到数组中，得到最终结果的顺序不发生变化
   */
    NSMutableArray * resultArray = [NSMutableArray array];
    for(NSString * item in originalArray){
        if(![resultArray containsObject:item]){
            [resultArray addObject:item];
        }
    }
    NSLog(@"contains resultArray : %@",resultArray);
    
    //通过valueForKeyPath (@"@distinctUnionOfObjects.self")
    NSArray * resArray = [originalArray valueForKeyPath:@"@distinctUnionOfObjects.self"];
    NSLog(@"distinct resArray : %@",resArray);
    
    //3.模型对象去重
    //创建model类对象
    Model *model1 = [[Model alloc]init];
    model1.ID = @"1";
    Model *model2 = [[Model alloc]init];
    model1.ID = @"2";
    Model *model3 = [[Model alloc]init];
    model1.ID = @"3";
    Model *model4 = [[Model alloc]init];
    model1.ID = @"1";
    Model *model5 = [[Model alloc]init];
    model1.ID = @"3";
    //添加到数组中
    NSMutableArray * originalArr = [NSMutableArray arrayWithArray:@[model1,model2,model3,model4,model5]];
    NSMutableArray *resultArr = [NSMutableArray arrayWithArray:originalArr];
    //去重
    for (int x = 0; x < originalArr.count; x++) {
        for (int y = x+1;y < originalArr.count; y++) {
            Model *tempModel = originalArr[x];
            Model *model = originalArr[y];
            if ([tempModel.ID isEqualToString:model.ID]) {
                [resultArr removeObject:model];
            }
        }
    }
    NSLog(@"model result: %@", resultArray);
    
}


@end
