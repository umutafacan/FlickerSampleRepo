//
//  FARecentPhotosResponse.m
//
//  Created by   on 6/26/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "FARecentPhotosResponse.h"
#import "FAPhotos.h"


NSString *const kFARecentPhotosResponseStat = @"stat";
NSString *const kFARecentPhotosResponsePhotos = @"photos";


@interface FARecentPhotosResponse ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation FARecentPhotosResponse

@synthesize stat = _stat;
@synthesize photos = _photos;


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
            self.stat = [self objectOrNilForKey:kFARecentPhotosResponseStat fromDictionary:dict];
            self.photos = [FAPhotos modelObjectWithDictionary:[dict objectForKey:kFARecentPhotosResponsePhotos]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.stat forKey:kFARecentPhotosResponseStat];
    [mutableDict setValue:[self.photos dictionaryRepresentation] forKey:kFARecentPhotosResponsePhotos];

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

    self.stat = [aDecoder decodeObjectForKey:kFARecentPhotosResponseStat];
    self.photos = [aDecoder decodeObjectForKey:kFARecentPhotosResponsePhotos];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_stat forKey:kFARecentPhotosResponseStat];
    [aCoder encodeObject:_photos forKey:kFARecentPhotosResponsePhotos];
}

- (id)copyWithZone:(NSZone *)zone
{
    FARecentPhotosResponse *copy = [[FARecentPhotosResponse alloc] init];
    
    if (copy) {

        copy.stat = [self.stat copyWithZone:zone];
        copy.photos = [self.photos copyWithZone:zone];
    }
    
    return copy;
}


@end
