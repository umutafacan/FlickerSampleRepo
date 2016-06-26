//
//  FAPhoto.h
//
//  Created by   on 6/26/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface FAPhoto : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *secret;
@property (nonatomic, strong) NSString *owner;
@property (nonatomic, assign) double farm;
@property (nonatomic, strong) NSString *photoIdentifier;
@property (nonatomic, strong) NSString *server;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) double isfriend;
@property (nonatomic, assign) double isfamily;
@property (nonatomic, assign) double ispublic;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
