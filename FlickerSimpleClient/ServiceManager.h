//
//  ServiceManager.h
//  FlickerSimpleClient
//
//  Created by umut on 25/06/16.
//  Copyright © 2016 umutafacan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>


typedef  void (^completion) (void);
typedef void (^completionRecentPhotos) (FARecentPhotosResponse *response);
typedef void (^completionSearchPhotos) (FARecentPhotosResponse *response);
typedef void  (^completionReleatedTags)(FAReleatedTagResponse *response);
typedef void  (^completionHotTags)(FAHotTagResponse *response);

typedef void  (^failure)(NSError *error);


@interface ServiceManager : NSObject



@end
