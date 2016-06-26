//
//  FAHotTagResponse.m
//
//  Created by   on 6/26/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "FAHotTagResponse.h"
#import "FAHottags.h"


NSString *const kFAHotTagResponseHottags = @"hottags";
NSString *const kFAHotTagResponseStat = @"stat";


@interface FAHotTagResponse ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation FAHotTagResponse

@synthesize hottags = _hottags;
@synthesize stat = _stat;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.hottags = [FAHottags modelObjectWithDictionary:[dict objectForKey:kFAHotTagResponseHottags]];
            self.stat = [self objectOrNilForKey:kFAHotTagResponseStat fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.hottags dictionaryRepresentation] forKey:kFAHotTagResponseHottags];
    [mutableDict setValue:self.stat forKey:kFAHotTagResponseStat];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.hottags = [aDecoder decodeObjectForKey:kFAHotTagResponseHottags];
    self.stat = [aDecoder decodeObjectForKey:kFAHotTagResponseStat];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_hottags forKey:kFAHotTagResponseHottags];
    [aCoder encodeObject:_stat forKey:kFAHotTagResponseStat];
}

- (id)copyWithZone:(NSZone *)zone
{
    FAHotTagResponse *copy = [[FAHotTagResponse alloc] init];
    
    if (copy) {

        copy.hottags = [self.hottags copyWithZone:zone];
        copy.stat = [self.stat copyWithZone:zone];
    }
    
    return copy;
}


@end
