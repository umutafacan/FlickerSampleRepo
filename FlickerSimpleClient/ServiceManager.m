//
//  ServiceManager.m
//  FlickerSimpleClient
//
//  Created by umut on 25/06/16.
//  Copyright © 2016 umutafacan. All rights reserved.
//

#import "ServiceManager.h"

@implementation ServiceManager

#pragma  mark - Service URLS
+(NSString *)baseServiceURL
{
    return @"https://api.flickr.com/services/rest/?method=";
}


+(NSString *)apiKeyAndMisc
{
    return 	@"&api_key=88bd5dfe929c6beca0cf0cadf5efc6fe&format=json&nojsoncallback=1";
}


#pragma mark - AFManager Settings
+ (AFSecurityPolicy *)securityPolicy {
    
    return [AFSecurityPolicy defaultPolicy];
    
}

+ (AFHTTPRequestOperationManager *)generateManager {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    manager.requestSerializer = requestSerializer;
    
    return manager;
}


# pragma  mark - Recent Photos
+(NSString *)urlGetRecentPhotos
{
    
    return [NSString stringWithFormat:@"%@%@%@",[self baseServiceURL],@"flickr.photos.getRecent",[self apiKeyAndMisc]];
    
}

+(void)getRecentPhotosWithCompletion:(completionRecentPhotos)completion failure:(failure)failure
{
    AFHTTPRequestOperationManager *manager = [self generateManager];
    
    [manager GET:[self urlGetRecentPhotos] parameters:nil
         success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
             
             FARecentPhotosResponse *result = [[FARecentPhotosResponse alloc]initWithDictionary:(NSDictionary *)responseObject];
             
             if ([result.stat isEqualToString:@"ok"]) {
                 
                 if (completion) {
                     completion(result);
                 }
             }else
             {
                 if (failure) {
                     failure(operation.error);
                 }
                 
             }
         } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
             if (failure) {
                 failure(error);
             }

             
         }];
}

+(NSString *)urlGetRecentPhotosAtPage:(int)page
{
    
    return [NSString stringWithFormat:@"%@%@%@%@",[self baseServiceURL],
            @"flickr.photos.getRecent",
            [NSString stringWithFormat:@"&per_page=75&page=%d",page],
            [self apiKeyAndMisc]];
    
}

+(void)getRecentPhotosAtPage:(int)page withCompletion:(completionRecentPhotos)completion failure:(failure)failure
{
    AFHTTPRequestOperationManager *manager = [self generateManager];
    
    [manager GET:[self urlGetRecentPhotosAtPage:page] parameters:nil
         success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
             
             FARecentPhotosResponse *result = [[FARecentPhotosResponse alloc]initWithDictionary:(NSDictionary *)responseObject];
             
             
             if ([result.stat isEqualToString:@"ok"]) {
                 
                 if (completion) {
                     completion(result);
                 }
             }else
             {
                 if (failure) {
                     failure(operation.error);
                 }
                 
             }
         } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
             if (failure) {
                 failure(error);
             }
             
         }];

}


#pragma mark - Search

+(NSString *)urlGetSearchPhotosAtPage:(int)page withSearchText:(NSString *)text
{
    
    return [NSString stringWithFormat:@"%@%@%@%@%@",[self baseServiceURL],
            @"flickr.photos.search",
            [NSString stringWithFormat:@"&per_page=75&page=%d",page],
            [NSString stringWithFormat:@"&text=%@",text],
            [self apiKeyAndMisc]];
    
}

+(void)getSearchPhotosAtPage:(int)page withSearchText:(NSString*)text withCompletion:(completionSearchPhotos)completion failure:(failure)failure

{
    AFHTTPRequestOperationManager *manager = [self generateManager];
    
    [manager GET:[self urlGetSearchPhotosAtPage:page withSearchText:text] parameters:nil
         success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
             FARecentPhotosResponse *result = [[FARecentPhotosResponse alloc]initWithDictionary:(NSDictionary *)responseObject];
             
             
             if ([result.stat isEqualToString:@"ok"]) {
                 
                 if (completion) {
                     completion(result);
                 }
             }else
             {
                 if (failure) {
                     failure(operation.error);
                 }
                 
             }
         } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
             if (failure) {
                 failure(error);
             }
             
         }];
    
}


#pragma mark - Hot Tags


+(NSString *)urlGetHotTags
{
    
    return [NSString stringWithFormat:@"%@%@%@%@",[self baseServiceURL],
            @"flickr.tags.getHotList",
            @"&count=10",
            [self apiKeyAndMisc]];
    
}

+(void)getHotTagsListWithCompletion:(completionHotTags)completion failure:(failure)failure

{
    AFHTTPRequestOperationManager *manager = [self generateManager];
    
    [manager GET:[self urlGetHotTags] parameters:nil
         success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
             FAHotTagResponse *result = [[FAHotTagResponse alloc]initWithDictionary:(NSDictionary *)responseObject];
             
             
             if ([result.stat isEqualToString:@"ok"]) {
                 
                 if (completion) {
                     completion(result);
                 }
             }else
             {
                 if (failure) {
                     failure(operation.error);
                 }
                 
             }
         } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
             if (failure) {
                 failure(error);
             }
             
         }];
    
}
#pragma mark - Releated Tags


+(NSString *)urlGetReleatedTagsWith:(NSString *)tag
{
    
    return [NSString stringWithFormat:@"%@%@%@%@%@",
            [self baseServiceURL],
            @"flickr.tags.getRelated",
            @"&tag=",
            tag,
            [self apiKeyAndMisc]];
    
}

+(void)getReleatedTagsListWith:(NSString *)tag withCompletion:(completionReleatedTags)completion failure:(failure)failure

{
    AFHTTPRequestOperationManager *manager = [self generateManager];
    
    [manager GET:[self urlGetReleatedTagsWith:tag] parameters:nil
         success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
             FAReleatedTagResponse *result = [[FAReleatedTagResponse alloc]initWithDictionary:(NSDictionary *)responseObject];
             
             if ([result.stat isEqualToString:@"ok"]) {
                 
                 if (completion) {
                     completion(result);
                 }
             }else
             {
                 if (failure) {
                     failure(operation.error);
                 }
                 
             }
             
             
         } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
             if (failure) {
                 failure(error);
             }
             
         }];
    
}

#pragma mark - Helpers

+(NSURL *)urlOfPhoto:(FAPhoto *)photo
{
    /*
     Example URL
     https://farm1.staticflickr.com/2/1418878_1e92283336_m.jpg
    
    farm-id: 1
    server-id: 2
    photo-id: 1418878
    secret: 1e92283336
    size: m
    
    */

    return [NSURL URLWithString:[NSString stringWithFormat:@"https://farm%d.staticflickr.com/%@/%@_%@_q.jpg",(int)photo.farm,photo.server,photo.photoIdentifier,photo.secret]];
    
}




@end
