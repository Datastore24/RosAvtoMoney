//
//  APIClass.m
//  RosAvtoDengi
//
//  Created by Кирилл Ковыршин on 06.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "APIClass.h"


@implementation APIClass
#define MAIN_URL @"http://itdolgopa.ru/ios/RosAvtoDengi/api.php"
#define API_KEY @"R6tYkBhREgYp6ioXDx7gAkzHfCZnGfnfFSEgkbEhjlMr05lii9MF6"

//Запрос на сервер
-(void) postDataToServerWithParams: (NSDictionary *) params method:(NSString*) method complitionBlock: (void (^) (id response)) compitionBack{
    NSString * url = [NSString stringWithFormat:@"%@?%@&api_key=%@",MAIN_URL,method,API_KEY];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    
    //Запрос
    [manager POST: url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //Вызов блока
        compitionBack (responseObject);
        
        
        //Ошибки
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}

@end
