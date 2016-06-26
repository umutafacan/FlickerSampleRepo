//
//  FAHottags.h
//
//  Created by   on 6/26/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface FAHottags : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double count;
@property (nonatomic, strong) NSString *period;
@property (nonatomic, strong) NSArray *tag;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
