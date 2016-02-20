//
//  Product.h
//  集成支付宝
//
//  Created by xiaomage on 15/8/20.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Product : NSObject

/** 价格 */
@property (nonatomic, assign) CGFloat price;

/** 商品的名称 */
@property (nonatomic, copy) NSString *name;

/** 商品的描述 */
@property (nonatomic, copy) NSString *desc;

- (instancetype)initWithPrice:(CGFloat)price name:(NSString *)name desc:(NSString *)desc;
+ (instancetype)productWithPrice:(CGFloat)price name:(NSString *)name desc:(NSString *)desc;

@end
