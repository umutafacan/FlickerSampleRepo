//
//  FAPhoto.m
//
//  Created by   on 6/26/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "FAPhoto.h"


NSString *const kFAPhotoSecret = @"secret";
NSString *const kFAPhotoOwner = @"owner";
NSString *const kFAPhotoFarm = @"farm";
NSString *const kFAPhotoId = @"id";
NSString *const kFAPhotoServer = @"server";
NSString *const kFAPhotoTitle = @"title";
NSString *const kFAPhotoIsfriend = @"isfriend";
NSString *const kFAPhotoIsfamily = @"isfamily";
NSString *const kFAPhotoIspublic = @"ispublic";


@interface FAPhoto ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation FAPhoto

@synthesize secret = _secret;
@synthesize owner = _owner;
@synthesize farm = _farm;
@synthesize photoIdentifier = _photoIdentifier;
@synthesize server = _server;
@synthesize title = _title;
@synthesize isfriend = _isfriend;
@synthesize isfamily = _isfamily;
@synthesize ispublic = _ispublic;


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
            self.secret = [self objectOrNilForKey:kFAPhotoSecret fromDictionary:dict];
            self.owner = [self objectOrNilForKey:kFAPhotoOwner fromDictionary:dict];
            self.farm = [[self objectOrNilForKey:kFAPhotoFarm fromDictionary:dict] doubleValue];
            self.photoIdentifier = [self objectOrNilForKey:kFAPhotoId fromDictionary:dict];
            self.server = [self objectOrNilForKey:kFAPhotoServer fromDictionary:dict];
            self.title = [self objectOrNilForKey:kFAPhotoTitle fromDictionary:dict];
            self.isfriend = [[self objectOrNilForKey:kFAPhotoIsfriend fromDictionary:dict] doubleValue];
            self.isfamily = [[self objectOrNilForKey:kFAPhotoIsfamily fromDictionary:dict] doubleValue];
            self.ispublic = [[self objectOrNilForKey:kFAPhotoIspublic fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.secret forKey:kFAPhotoSecret];
    [mutableDict setValue:self.owner forKey:kFAPhotoOwner];
    [mutableDict setValue:[NSNumber numberWithDouble:self.farm] forKey:kFAPhotoFarm];
    [mutableDict setValue:self.photoIdentifier forKey:kFAPhotoId];
    [mutableDict setValue:self.server forKey:kFAPhotoServer];
    [mutableDict setValue:self.title forKey:kFAPhotoTitle];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isfriend] forKey:kFAPhotoIsfriend];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isfamily] forKey:kFAPhotoIsfamily];
    [mutableDict setValue:[NSNumber numberWithDouble:self.ispublic] forKey:kFAPhotoIspublic];

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

    self.secret = [aDecoder decodeObjectForKey:kFAPhotoSecret];
    self.owner = [aDecoder decodeObjectForKey:kFAPhotoOwner];
    self.farm = [aDecoder decodeDoubleForKey:kFAPhotoFarm];
    self.photoIdentifier = [aDecoder decodeObjectForKey:kFAPhotoId];
    self.server = [aDecoder decodeObjectForKey:kFAPhotoServer];
    self.title = [aDecoder decodeObjectForKey:kFAPhotoTitle];
    self.isfriend = [aDecoder decodeDoubleForKey:kFAPhotoIsfriend];
    self.isfamily = [aDecoder decodeDoubleForKey:kFAPhotoIsfamily];
    self.ispublic = [aDecoder decodeDoubleForKey:kFAPhotoIspublic];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_secret forKey:kFAPhotoSecret];
    [aCoder encodeObject:_owner forKey:kFAPhotoOwner];
    [aCoder encodeDouble:_farm forKey:kFAPhotoFarm];
    [aCoder encodeObject:_photoIdentifier forKey:kFAPhotoId];
    [aCoder encodeObject:_server forKey:kFAPhotoServer];
    [aCoder encodeObject:_title forKey:kFAPhotoTitle];
    [aCoder encodeDouble:_isfriend forKey:kFAPhotoIsfriend];
    [aCoder encodeDouble:_isfamily forKey:kFAPhotoIsfamily];
    [aCoder encodeDouble:_ispublic forKey:kFAPhotoIspublic];
}

- (id)copyWithZone:(NSZone *)zone
{
    FAPhoto *copy = [[FAPhoto alloc] init];
    
    if (copy) {

        copy.secret = [self.secret copyWithZone:zone];
        copy.owner = [self.owner copyWithZone:zone];
        copy.farm = self.farm;
        copy.photoIdentifier = [self.photoIdentifier copyWithZone:zone];
        copy.server = [self.server copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.isfriend = self.isfriend;
        copy.isfamily = self.isfamily;
        copy.ispublic = self.ispublic;
    }
    
    return copy;
}


@end
