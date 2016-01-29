//
//  Brand.h
//  TableViewEditWH31-32
//
//  Created by Nikolay Berlioz on 28.01.16.
//  Copyright © 2016 Nikolay Berlioz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Brand : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSArray *models;

- (NSString*) randomBrandNameWithArray:(NSMutableArray*)array;

@end
