//
//  FATags.h
//
//  Created by   on 6/26/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface FATags : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *tag;
@property (nonatomic, strong) NSString *source;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
