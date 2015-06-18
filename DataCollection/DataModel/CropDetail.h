//
//  CropDetail.h
//
//  Created by chuan kaitong on 15/5/4
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CropDetail : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) NSInteger code;
@property (nonatomic, assign) double cropDetailIdentifier;
@property (nonatomic, strong) NSString *cultivarName;
@property (nonatomic, strong) NSString *acreage;
@property (nonatomic, assign) NSInteger belongTable;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
