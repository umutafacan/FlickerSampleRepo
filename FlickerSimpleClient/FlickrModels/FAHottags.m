//
//  FAHottags.m
//
//  Created by   on 6/26/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "FAHottags.h"
#import "FATag.h"


NSString *const kFAHottagsCount = @"count";
NSString *const kFAHottagsPeriod = @"period";
NSString *const kFAHottagsTag = @"tag";


@interface FAHottags ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation FAHottags

@synthesize count = _count;
@synthesize period = _period;
@synthesize tag = _tag;


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
            self.count = [[self objectOrNilForKey:kFAHottagsCount fromDictionary:dict] doubleValue];
            self.period = [self objectOrNilForKey:kFAHottagsPeriod fromDictionary:dict];
    NSObject *receivedFATag = [dict objectForKey:kFAHottagsTag];
    NSMutableArray *parsedFATag = [NSMutableArray array];
    if ([receivedFATag isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedFATag) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedFATag addObject:[FATag modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedFATag isKindOfClass:[NSDictionary class]]) {
       [parsedFATag addObject:[FATag modelObjectWithDictionary:(NSDictionary *)receivedFATag]];
    }

    self.tag = [NSArray arrayWithArray:parsedFATag];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.count] forKey:kFAHottagsCount];
    [mutableDict setValue:self.period forKey:kFAHottagsPeriod];
    NSMutableArray *tempArrayForTag = [NSMutableArray array];
    for (NSObject *subArrayObject in self.tag) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForTag addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForTag addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForTag] forKey:kFAHottagsTag];

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

    self.count = [aDecoder decodeDoubleForKey:kFAHottagsCount];
    self.period = [aDecoder decodeObjectForKey:kFAHottagsPeriod];
    self.tag = [aDecoder decodeObjectForKey:kFAHottagsTag];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_count forKey:kFAHottagsCount];
    [aCoder encodeObject:_period forKey:kFAHottagsPeriod];
    [aCoder encodeObject:_tag forKey:kFAHottagsTag];
}

- (id)copyWithZone:(NSZone *)zone
{
    FAHottags *copy = [[FAHottags alloc] init];
    
    if (copy) {

        copy.count = self.count;
        copy.period = [self.period copyWithZone:zone];
        copy.tag = [self.tag copyWithZone:zone];
    }
    
    return copy;
}


@end
