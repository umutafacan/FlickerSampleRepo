//
//  FATags.m
//
//  Created by   on 6/26/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "FATags.h"
#import "FATag.h"


NSString *const kFATagsTag = @"tag";
NSString *const kFATagsSource = @"source";


@interface FATags ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation FATags

@synthesize tag = _tag;
@synthesize source = _source;


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
    NSObject *receivedFATag = [dict objectForKey:kFATagsTag];
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
            self.source = [self objectOrNilForKey:kFATagsSource fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForTag] forKey:kFATagsTag];
    [mutableDict setValue:self.source forKey:kFATagsSource];

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

    self.tag = [aDecoder decodeObjectForKey:kFATagsTag];
    self.source = [aDecoder decodeObjectForKey:kFATagsSource];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_tag forKey:kFATagsTag];
    [aCoder encodeObject:_source forKey:kFATagsSource];
}

- (id)copyWithZone:(NSZone *)zone
{
    FATags *copy = [[FATags alloc] init];
    
    if (copy) {

        copy.tag = [self.tag copyWithZone:zone];
        copy.source = [self.source copyWithZone:zone];
    }
    
    return copy;
}


@end
