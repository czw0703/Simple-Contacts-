//
//  MyAddViewController.h
//  18_我的通讯录
//
//  Created by wxhl on 16-4-23.
//  Copyright (c) 2016年 wxhl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyMainModel;

typedef void(^MyAddViewControllerBlock)(MyMainModel *myModel);

@interface MyAddViewController : UIViewController
@property (nonatomic, strong)MyAddViewControllerBlock block;
@end
