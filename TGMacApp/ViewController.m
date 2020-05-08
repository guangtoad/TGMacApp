//
//  ViewController.m
//  TGMacApp
//
//  Created by home on 2018-07-27.
//  Copyright © 2018年 toad. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://192.168.1.130/OCRService/OCR_IF.asmx/OcrInterFace"] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10.0f];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    NSString *bodyStr = [NSString stringWithFormat:@"requestXml=string"];
    NSData *body = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:body];
    NSURLSession *session = [NSURLSession sharedSession];
    //创建数据任务  系统会自动开启一个子线程
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"error:%@",error);
        }
        //data为服务器返回的数据
        NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"response:%@",string);

        //把服务器返回的json数据 直接转成字典
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];

    }];
    //开始任务
    [dataTask resume];
    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
