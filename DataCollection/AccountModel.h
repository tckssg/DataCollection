//
//  AccountModel.h
//
//  Created by chuan kaitong on 15/4/24
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface AccountModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *password;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
