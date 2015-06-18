//
//  DataModel.m
//
//  Created by chuan kaitong on 15/5/4
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "DataModel.h"
#import "CropDetail.h"


NSString *const kDataModelId = @"id";
NSString *const kDataModelUnit = @"unit";
NSString *const kDataModelCreateDate = @"create_date";
NSString *const kDataModelTableId = @"table_id";
NSString *const kDataModelTableName = @"table_name";
NSString *const kDataModelTableIndeifer = @"table_indeifer";
NSString *const kDataModelLongitude = @"longitude";
NSString *const kDataModelCropDetail = @"cropDetail";
NSString *const kDataModelLatitude = @"latitude";
NSString *const kDataModelFileNumber = @"file_number";
NSString *const kDataModelMakeName = @"make_name";
NSString *const kDataModelTitle = @"title";
NSString *const kDataModelTableCode = @"table_code";
NSString *const kDataModelAdress = @"adress";
NSString *const kDataModelPrincipalName = @"principal_name";
NSString *const kDataModelAccountId = @"account_id";
NSString *const kDataModelDeadline = @"deadline";


@interface DataModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation DataModel

@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize unit = _unit;
@synthesize createDate = _createDate;
@synthesize tableId = _tableId;
@synthesize tableName = _tableName;
@synthesize tableIndeifer = _tableIndeifer;
@synthesize longitude = _longitude;
@synthesize cropDetail = _cropDetail;
@synthesize latitude = _latitude;
@synthesize fileNumber = _fileNumber;
@synthesize makeName = _makeName;
@synthesize title = _title;
@synthesize tableCode = _tableCode;
@synthesize adress = _adress;
@synthesize principalName = _principalName;
@synthesize accountId = _accountId;
@synthesize deadline = _deadline;


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
            self.internalBaseClassIdentifier = [self objectOrNilForKey:kDataModelId fromDictionary:dict];
            self.unit = [self objectOrNilForKey:kDataModelUnit fromDictionary:dict];
            self.createDate = [self objectOrNilForKey:kDataModelCreateDate fromDictionary:dict];
            self.tableId = [self objectOrNilForKey:kDataModelTableId fromDictionary:dict];
            self.tableName = [self objectOrNilForKey:kDataModelTableName fromDictionary:dict];
            self.tableIndeifer = [self objectOrNilForKey:kDataModelTableIndeifer fromDictionary:dict];
            self.longitude = [self objectOrNilForKey:kDataModelLongitude fromDictionary:dict];
    NSObject *receivedCropDetail = [dict objectForKey:kDataModelCropDetail];
    NSMutableArray *parsedCropDetail = [NSMutableArray array];
    if ([receivedCropDetail isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedCropDetail) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedCropDetail addObject:[CropDetail modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedCropDetail isKindOfClass:[NSDictionary class]]) {
       [parsedCropDetail addObject:[CropDetail modelObjectWithDictionary:(NSDictionary *)receivedCropDetail]];
    }

    self.cropDetail = [NSArray arrayWithArray:parsedCropDetail];
            self.latitude = [self objectOrNilForKey:kDataModelLatitude fromDictionary:dict];
            self.fileNumber = [self objectOrNilForKey:kDataModelFileNumber fromDictionary:dict];
            self.makeName = [self objectOrNilForKey:kDataModelMakeName fromDictionary:dict];
            self.title = [self objectOrNilForKey:kDataModelTitle fromDictionary:dict];
            self.tableCode = [self objectOrNilForKey:kDataModelTableCode fromDictionary:dict];
            self.adress = [self objectOrNilForKey:kDataModelAdress fromDictionary:dict];
            self.principalName = [self objectOrNilForKey:kDataModelPrincipalName fromDictionary:dict];
            self.accountId = [self objectOrNilForKey:kDataModelAccountId fromDictionary:dict];
            self.deadline = [self objectOrNilForKey:kDataModelDeadline fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.internalBaseClassIdentifier forKey:kDataModelId];
    [mutableDict setValue:self.unit forKey:kDataModelUnit];
    [mutableDict setValue:self.createDate forKey:kDataModelCreateDate];
    [mutableDict setValue:self.tableId forKey:kDataModelTableId];
    [mutableDict setValue:self.tableName forKey:kDataModelTableName];
    [mutableDict setValue:self.tableIndeifer forKey:kDataModelTableIndeifer];
    [mutableDict setValue:self.longitude forKey:kDataModelLongitude];
    NSMutableArray *tempArrayForCropDetail = [NSMutableArray array];
    for (NSObject *subArrayObject in self.cropDetail) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForCropDetail addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForCropDetail addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForCropDetail] forKey:kDataModelCropDetail];
    [mutableDict setValue:self.latitude forKey:kDataModelLatitude];
    [mutableDict setValue:self.fileNumber forKey:kDataModelFileNumber];
    [mutableDict setValue:self.makeName forKey:kDataModelMakeName];
    [mutableDict setValue:self.title forKey:kDataModelTitle];
    [mutableDict setValue:self.tableCode forKey:kDataModelTableCode];
    [mutableDict setValue:self.adress forKey:kDataModelAdress];
    [mutableDict setValue:self.principalName forKey:kDataModelPrincipalName];
    [mutableDict setValue:self.accountId forKey:kDataModelAccountId];
    [mutableDict setValue:self.deadline forKey:kDataModelDeadline];

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

    self.internalBaseClassIdentifier = [aDecoder decodeObjectForKey:kDataModelId];
    self.unit = [aDecoder decodeObjectForKey:kDataModelUnit];
    self.createDate = [aDecoder decodeObjectForKey:kDataModelCreateDate];
    self.tableId = [aDecoder decodeObjectForKey:kDataModelTableId];
    self.tableName = [aDecoder decodeObjectForKey:kDataModelTableName];
    self.tableIndeifer = [aDecoder decodeObjectForKey:kDataModelTableIndeifer];
    self.longitude = [aDecoder decodeObjectForKey:kDataModelLongitude];
    self.cropDetail = [aDecoder decodeObjectForKey:kDataModelCropDetail];
    self.latitude = [aDecoder decodeObjectForKey:kDataModelLatitude];
    self.fileNumber = [aDecoder decodeObjectForKey:kDataModelFileNumber];
    self.makeName = [aDecoder decodeObjectForKey:kDataModelMakeName];
    self.title = [aDecoder decodeObjectForKey:kDataModelTitle];
    self.tableCode = [aDecoder decodeObjectForKey:kDataModelTableCode];
    self.adress = [aDecoder decodeObjectForKey:kDataModelAdress];
    self.principalName = [aDecoder decodeObjectForKey:kDataModelPrincipalName];
    self.accountId = [aDecoder decodeObjectForKey:kDataModelAccountId];
    self.deadline = [aDecoder decodeObjectForKey:kDataModelDeadline];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_internalBaseClassIdentifier forKey:kDataModelId];
    [aCoder encodeObject:_unit forKey:kDataModelUnit];
    [aCoder encodeObject:_createDate forKey:kDataModelCreateDate];
    [aCoder encodeObject:_tableId forKey:kDataModelTableId];
    [aCoder encodeObject:_tableName forKey:kDataModelTableName];
    [aCoder encodeObject:_tableIndeifer forKey:kDataModelTableIndeifer];
    [aCoder encodeObject:_longitude forKey:kDataModelLongitude];
    [aCoder encodeObject:_cropDetail forKey:kDataModelCropDetail];
    [aCoder encodeObject:_latitude forKey:kDataModelLatitude];
    [aCoder encodeObject:_fileNumber forKey:kDataModelFileNumber];
    [aCoder encodeObject:_makeName forKey:kDataModelMakeName];
    [aCoder encodeObject:_title forKey:kDataModelTitle];
    [aCoder encodeObject:_tableCode forKey:kDataModelTableCode];
    [aCoder encodeObject:_adress forKey:kDataModelAdress];
    [aCoder encodeObject:_principalName forKey:kDataModelPrincipalName];
    [aCoder encodeObject:_accountId forKey:kDataModelAccountId];
    [aCoder encodeObject:_deadline forKey:kDataModelDeadline];
}

- (id)copyWithZone:(NSZone *)zone
{
    DataModel *copy = [[DataModel alloc] init];
    
    if (copy) {

        copy.internalBaseClassIdentifier = [self.internalBaseClassIdentifier copyWithZone:zone];
        copy.unit = [self.unit copyWithZone:zone];
        copy.createDate = [self.createDate copyWithZone:zone];
        copy.tableId = [self.tableId copyWithZone:zone];
        copy.tableName = [self.tableName copyWithZone:zone];
        copy.tableIndeifer = [self.tableIndeifer copyWithZone:zone];
        copy.longitude = [self.longitude copyWithZone:zone];
        copy.cropDetail = [self.cropDetail copyWithZone:zone];
        copy.latitude = [self.latitude copyWithZone:zone];
        copy.fileNumber = [self.fileNumber copyWithZone:zone];
        copy.makeName = [self.makeName copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.tableCode = [self.tableCode copyWithZone:zone];
        copy.adress = [self.adress copyWithZone:zone];
        copy.principalName = [self.principalName copyWithZone:zone];
        copy.accountId = [self.accountId copyWithZone:zone];
        copy.deadline = [self.deadline copyWithZone:zone];
    }
    
    return copy;
}


@end
