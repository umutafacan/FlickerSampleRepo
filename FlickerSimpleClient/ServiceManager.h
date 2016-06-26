//
//  ServiceManager.h
//  FlickerSimpleClient
//
//  Created by umut on 25/06/16.
//  Copyright © 2016 umutafacan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

#pragma mark - Blocks
typedef  void (^completion) (void);
typedef void (^completionRecentPhotos) (FARecentPhotosResponse *response);
typedef void (^completionSearchPhotos) (FARecentPhotosResponse *response);
typedef void  (^completionReleatedTags)(FAReleatedTagResponse *response);
typedef void  (^completionHotTags)(FAHotTagResponse *response);

typedef void  (^failure)(NSError *error);


@interface ServiceManager : NSObject

#pragma mark - Public Methods

//get the recent photos at first page
+(void)getRecentPhotosWithCompletion:(completionRecentPhotos)completion failure:(failure)failure;

//gets the recent photos at the page number which given as parameter
+(void)getRecentPhotosAtPage:(int)page withCompletion:(completionRecentPhotos)completion failure:(failure)failure;

//searches by a given text and gets photos at the page number which given as parameter
+(void)getSearchPhotosAtPage:(int)page withSearchText:(NSString*)text withCompletion:(completionSearchPhotos)completion failure:(failure)failure;

//gets hottest tags at currently on flickr
+(void)getHotTagsListWithCompletion:(completionHotTags)completion failure:(failure)failure;

//gets releated tags with the given tag as parameter
+(void)getReleatedTagsListWith:(NSString *)tag withCompletion:(completionReleatedTags)completion failure:(failure)failure;

//returns a url from photo object
+(NSURL *)urlOfPhoto:(FAPhoto *)photo;




@end
