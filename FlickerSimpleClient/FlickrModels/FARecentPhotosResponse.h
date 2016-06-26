//
//  FARecentPhotosResponse.h
//
//  Created by   on 6/26/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FAPhotos;

@interface FARecentPhotosResponse : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *stat;
@property (nonatomic, strong) FAPhotos *photos;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
