//
//  MyMainModel.h
//  18_我的通讯录
//
//  Created by wxhl on 16-4-24.
//  Copyright (c) 2016年 wxhl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyMainModel : NSObject<NSCoding>
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *phone;
+(instancetype)contactWithName:(NSString*)names withPhone:(NSString*)phones;
@end
