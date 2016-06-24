//
//  MyMainModel.m
//  18_我的通讯录
//
//  Created by wxhl on 16-4-24.
//  Copyright (c) 2016年 wxhl. All rights reserved.
//

#import "MyMainModel.h"

@implementation MyMainModel

static NSString *nameKey = @"name";
static NSString *phoneKey = @"phone";

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_name forKey:nameKey];
    [aCoder encodeObject:_phone forKey:phoneKey];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super init]) {
        _name=[aDecoder decodeObjectForKey:nameKey];
        _phone=[aDecoder decodeObjectForKey:phoneKey];
    }
    
    return self;
}

+(instancetype)contactWithName:(NSString*)names withPhone:(NSString*)phones{
    MyMainModel *model=[[self alloc] init];
    
    model.name=names;
    model.phone=phones;
    
    return model;
}

@end
