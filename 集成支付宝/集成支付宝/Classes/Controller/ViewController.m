//
//  ViewController.m
//  集成支付宝
//
//  Created by xiaomage on 15/8/20.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "ViewController.h"
#import "Product.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>

@interface ViewController ()

/** 商品 */
@property (nonatomic, strong) NSArray *products;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    // 1.取出模型
    Product *product = self.products[indexPath.row];
    
    // 2.给Cell设置数据
    cell.textLabel.text = product.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"价格:%.2f", product.price];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.取出模型
    Product *product = self.products[indexPath.row];
    
    // 2.购买商品
    [self buyProduct:product];
}

- (void)buyProduct:(Product *)product
{
    // 1.商户申请时,会获取的内容
    NSString *partner = @"";
    NSString *seller = @"";
    NSString *privateKey = @"";
    
    // 2.生成订单
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = nil; // 订单ID（由商家自行制定）
    order.productName = product.name; //商品标题
    order.productDescription = product.desc; //商品描述
    order.amount = [NSString stringWithFormat:@"%.2f",product.price]; //商品价格
    
    // 填写服务器的回调地址
    order.notifyURL =  @"http://www.xxx.com"; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m"; // 超时时间(在这个时间如果用户没有支付,则该订单直接失效)
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"alipay";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
    
    // 调用对应SDK,打开支付宝客户端,开始支付(如果用户手机安装客户端了,那么打开客户端进行支付.如果用户没有安装客户端,打开网页让用户支付,如果有支付结果,在这里回调)
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        
    }];
}

#pragma mark - 懒加载代码
- (NSArray *)products
{
    if (_products == nil) {
        Product *product = [Product productWithPrice:11500.0 name:@"iPhone 4" desc:@"Phone 4已经绝版了,所有非常贵"];
        Product *product1 = [Product productWithPrice:11500.0 name:@"iMac土豪金" desc:@"土豪金看起来比较帅"];
        Product *product2 = [Product productWithPrice:499.0 name:@"1T硬盘" desc:@"1T硬盘不要998,不要98,只要499"];
        Product *product3= [Product productWithPrice:123000 name:@"iWatch镀金" desc:@"装x必备商品"];
        
        _products = @[product, product1, product2, product3];
    }
    return _products;
}

@end
