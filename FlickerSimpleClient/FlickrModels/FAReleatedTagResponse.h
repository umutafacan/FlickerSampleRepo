//
//  FAReleatedTagResponse.h
//
//  Created by   on 6/26/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FATags;

@interface FAReleatedTagResponse : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) FATags *tags;
@property (nonatomic, strong) NSString *stat;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
