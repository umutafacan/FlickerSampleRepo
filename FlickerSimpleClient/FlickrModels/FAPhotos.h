//
//  FAPhotos.h
//
//  Created by   on 6/26/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface FAPhotos : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *total;
@property (nonatomic, assign) double pages;
@property (nonatomic, assign) double page;
@property (nonatomic, strong) NSArray *photo;
@property (nonatomic, assign) double perpage;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
