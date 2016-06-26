//
//  FAReleatedTagResponse.m
//
//  Created by   on 6/26/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "FAReleatedTagResponse.h"
#import "FATags.h"


NSString *const kFAReleatedTagResponseTags = @"tags";
NSString *const kFAReleatedTagResponseStat = @"stat";


@interface FAReleatedTagResponse ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation FAReleatedTagResponse

@synthesize tags = _tags;
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
            self.tags = [FATags modelObjectWithDictionary:[dict objectForKey:kFAReleatedTagResponseTags]];
            self.stat = [self objectOrNilForKey:kFAReleatedTagResponseStat fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.tags dictionaryRepresentation] forKey:kFAReleatedTagResponseTags];
    [mutableDict setValue:self.stat forKey:kFAReleatedTagResponseStat];

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

    self.tags = [aDecoder decodeObjectForKey:kFAReleatedTagResponseTags];
    self.stat = [aDecoder decodeObjectForKey:kFAReleatedTagResponseStat];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_tags forKey:kFAReleatedTagResponseTags];
    [aCoder encodeObject:_stat forKey:kFAReleatedTagResponseStat];
}

- (id)copyWithZone:(NSZone *)zone
{
    FAReleatedTagResponse *copy = [[FAReleatedTagResponse alloc] init];
    
    if (copy) {

        copy.tags = [self.tags copyWithZone:zone];
        copy.stat = [self.stat copyWithZone:zone];
    }
    
    return copy;
}


@end
