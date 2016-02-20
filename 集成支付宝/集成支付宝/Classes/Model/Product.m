//
//  Product.m
//  集成支付宝
//
//  Created by xiaomage on 15/8/20.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "Product.h"

@implementation Product

- (instancetype)initWithPrice:(CGFloat)price name:(NSString *)name desc:(NSString *)desc
{
    if (self = [super init]) {
        self.price = price;
        self.name = name;
        self.desc = desc;
    }
    return self;
}

+ (instancetype)productWithPrice:(CGFloat)price name:(NSString *)name desc:(NSString *)desc
{
    return [[self alloc] initWithPrice:price name:name desc:desc];
}

@end
