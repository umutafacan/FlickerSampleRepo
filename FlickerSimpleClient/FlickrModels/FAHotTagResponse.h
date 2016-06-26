//
//  FAHotTagResponse.h
//
//  Created by   on 6/26/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FAHottags;

@interface FAHotTagResponse : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) FAHottags *hottags;
@property (nonatomic, strong) NSString *stat;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
