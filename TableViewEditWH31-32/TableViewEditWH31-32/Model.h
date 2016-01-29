//
//  Model.h
//  TableViewEditWH31-32
//
//  Created by Nikolay Berlioz on 28.01.16.
//  Copyright © 2016 Nikolay Berlioz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject

@property (strong,nonatomic) NSString *itemName;

+ (Model*) randomModelWithName:(NSString*)name AndArray:(NSMutableArray*)array;

@end
