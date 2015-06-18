//
//  AccountModel.m
//
//  Created by chuan kaitong on 15/4/24
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "AccountModel.h"


NSString *const kAccountModelUserName = @"userName";
NSString *const kAccountModelPassword = @"password";


@interface AccountModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation AccountModel

@synthesize userName = _userName;
@synthesize password = _password;


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
            self.userName = [self objectOrNilForKey:kAccountModelUserName fromDictionary:dict];
            self.password = [self objectOrNilForKey:kAccountModelPassword fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.userName forKey:kAccountModelUserName];
    [mutableDict setValue:self.password forKey:kAccountModelPassword];

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

    self.userName = [aDecoder decodeObjectForKey:kAccountModelUserName];
    self.password = [aDecoder decodeObjectForKey:kAccountModelPassword];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_userName forKey:kAccountModelUserName];
    [aCoder encodeObject:_password forKey:kAccountModelPassword];
}

- (id)copyWithZone:(NSZone *)zone
{
    AccountModel *copy = [[AccountModel alloc] init];
    
    if (copy) {

        copy.userName = [self.userName copyWithZone:zone];
        copy.password = [self.password copyWithZone:zone];
    }
    
    return copy;
}


@end
