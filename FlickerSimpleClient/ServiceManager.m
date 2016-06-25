//
//  ServiceManager.m
//  FlickerSimpleClient
//
//  Created by umut on 25/06/16.
//  Copyright © 2016 umutafacan. All rights reserved.
//

#import "ServiceManager.h"

@implementation ServiceManager

#pragma  mark - Service URL
+(NSString *)baseServiceURL
{
    return @"https://api.flickr.com/services/rest/?method=";
}



+(NSString *)urlGetRecentPhotos
{

    return [NSString stringWithFormat:@"%@%@",[self baseServiceURL],@"/"]
}


@end
