//
//  MyEditViewController.h
//  18_我的通讯录
//
//  Created by wxhl on 16-4-24.
//  Copyright (c) 2016年 wxhl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMainModel.h"
@interface MyEditViewController : UIViewController
@property(nonatomic)MyMainModel *data;


@property(nonatomic,strong)void(^block)();//定义block，让点击按钮时调用
@end
