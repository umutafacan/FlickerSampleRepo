//
//  FAPhotos.m
//
//  Created by   on 6/26/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "FAPhotos.h"
#import "FAPhoto.h"


NSString *const kFAPhotosTotal = @"total";
NSString *const kFAPhotosPages = @"pages";
NSString *const kFAPhotosPage = @"page";
NSString *const kFAPhotosPhoto = @"photo";
NSString *const kFAPhotosPerpage = @"perpage";


@interface FAPhotos ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation FAPhotos

@synthesize total = _total;
@synthesize pages = _pages;
@synthesize page = _page;
@synthesize photo = _photo;
@synthesize perpage = _perpage;


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
            self.total = [self objectOrNilForKey:kFAPhotosTotal fromDictionary:dict];
            self.pages = [[self objectOrNilForKey:kFAPhotosPages fromDictionary:dict] doubleValue];
            self.page = [[self objectOrNilForKey:kFAPhotosPage fromDictionary:dict] doubleValue];
    NSObject *receivedFAPhoto = [dict objectForKey:kFAPhotosPhoto];
    NSMutableArray *parsedFAPhoto = [NSMutableArray array];
    if ([receivedFAPhoto isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedFAPhoto) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedFAPhoto addObject:[FAPhoto modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedFAPhoto isKindOfClass:[NSDictionary class]]) {
       [parsedFAPhoto addObject:[FAPhoto modelObjectWithDictionary:(NSDictionary *)receivedFAPhoto]];
    }

    self.photo = [NSArray arrayWithArray:parsedFAPhoto];
            self.perpage = [[self objectOrNilForKey:kFAPhotosPerpage fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.total forKey:kFAPhotosTotal];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pages] forKey:kFAPhotosPages];
    [mutableDict setValue:[NSNumber numberWithDouble:self.page] forKey:kFAPhotosPage];
    NSMutableArray *tempArrayForPhoto = [NSMutableArray array];
    for (NSObject *subArrayObject in self.photo) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForPhoto addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForPhoto addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForPhoto] forKey:kFAPhotosPhoto];
    [mutableDict setValue:[NSNumber numberWithDouble:self.perpage] forKey:kFAPhotosPerpage];

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

    self.total = [aDecoder decodeObjectForKey:kFAPhotosTotal];
    self.pages = [aDecoder decodeDoubleForKey:kFAPhotosPages];
    self.page = [aDecoder decodeDoubleForKey:kFAPhotosPage];
    self.photo = [aDecoder decodeObjectForKey:kFAPhotosPhoto];
    self.perpage = [aDecoder decodeDoubleForKey:kFAPhotosPerpage];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_total forKey:kFAPhotosTotal];
    [aCoder encodeDouble:_pages forKey:kFAPhotosPages];
    [aCoder encodeDouble:_page forKey:kFAPhotosPage];
    [aCoder encodeObject:_photo forKey:kFAPhotosPhoto];
    [aCoder encodeDouble:_perpage forKey:kFAPhotosPerpage];
}

- (id)copyWithZone:(NSZone *)zone
{
    FAPhotos *copy = [[FAPhotos alloc] init];
    
    if (copy) {

        copy.total = [self.total copyWithZone:zone];
        copy.pages = self.pages;
        copy.page = self.page;
        copy.photo = [self.photo copyWithZone:zone];
        copy.perpage = self.perpage;
    }
    
    return copy;
}


@end
