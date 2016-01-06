//
//  APIClass.h
//  RosAvtoDengi
//
//  Created by Кирилл Ковыршин on 06.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface APIClass : NSObject

-(void) postDataToServerWithParams: (NSDictionary *) params method:(NSString*) method complitionBlock: (void (^) (id response)) compitionBack;
@end
