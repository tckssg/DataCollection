//
//  DataModel.h
//
//  Created by chuan kaitong on 15/5/4
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface DataModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *internalBaseClassIdentifier;
@property (nonatomic, strong) NSString *unit;
@property (nonatomic, strong) NSString *createDate;
@property (nonatomic, strong) NSString *tableId;
@property (nonatomic, strong) NSString *tableName;
@property (nonatomic, strong) NSString *tableIndeifer;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSArray *cropDetail;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *fileNumber;
@property (nonatomic, strong) NSString *makeName;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *tableCode;
@property (nonatomic, strong) NSString *adress;
@property (nonatomic, strong) NSString *principalName;
@property (nonatomic, strong) NSString *accountId;
@property (nonatomic, strong) NSString *deadline;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
