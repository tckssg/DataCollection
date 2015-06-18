//
//  CropDetail.m
//
//  Created by chuan kaitong on 15/5/4
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "CropDetail.h"


NSString *const kCropDetailCode = @"code";
NSString *const kCropDetailId = @"id";
NSString *const kCropDetailCultivarName = @"cultivar_name";
NSString *const kCropDetailAcreage = @"acreage";
NSString *const kCropDetailBelongTable = @"belong_table";


@interface CropDetail ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CropDetail

@synthesize code = _code;
@synthesize cropDetailIdentifier = _cropDetailIdentifier;
@synthesize cultivarName = _cultivarName;
@synthesize acreage = _acreage;
@synthesize belongTable = _belongTable;


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
            self.code = [[self objectOrNilForKey:kCropDetailCode fromDictionary:dict] integerValue];
            self.cropDetailIdentifier = [[self objectOrNilForKey:kCropDetailId fromDictionary:dict] doubleValue];
            self.cultivarName = [self objectOrNilForKey:kCropDetailCultivarName fromDictionary:dict];
            self.acreage = [self objectOrNilForKey:kCropDetailAcreage fromDictionary:dict];
            self.belongTable = [[self objectOrNilForKey:kCropDetailBelongTable fromDictionary:dict] integerValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kCropDetailCode];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cropDetailIdentifier] forKey:kCropDetailId];
    [mutableDict setValue:self.cultivarName forKey:kCropDetailCultivarName];
    [mutableDict setValue:self.acreage forKey:kCropDetailAcreage];
    [mutableDict setValue:[NSNumber numberWithDouble:self.belongTable] forKey:kCropDetailBelongTable];

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

    self.code = [aDecoder decodeDoubleForKey:kCropDetailCode];
    self.cropDetailIdentifier = [aDecoder decodeDoubleForKey:kCropDetailId];
    self.cultivarName = [aDecoder decodeObjectForKey:kCropDetailCultivarName];
    self.acreage = [aDecoder decodeObjectForKey:kCropDetailAcreage];
    self.belongTable = [aDecoder decodeDoubleForKey:kCropDetailBelongTable];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_code forKey:kCropDetailCode];
    [aCoder encodeDouble:_cropDetailIdentifier forKey:kCropDetailId];
    [aCoder encodeObject:_cultivarName forKey:kCropDetailCultivarName];
    [aCoder encodeObject:_acreage forKey:kCropDetailAcreage];
    [aCoder encodeDouble:_belongTable forKey:kCropDetailBelongTable];
}

- (id)copyWithZone:(NSZone *)zone
{
    CropDetail *copy = [[CropDetail alloc] init];
    
    if (copy) {

        copy.code = self.code;
        copy.cropDetailIdentifier = self.cropDetailIdentifier;
        copy.cultivarName = [self.cultivarName copyWithZone:zone];
        copy.acreage = [self.acreage copyWithZone:zone];
        copy.belongTable = self.belongTable;
    }
    
    return copy;
}


@end
