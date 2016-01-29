//
//  Brand.m
//  TableViewEditWH31-32
//
//  Created by Nikolay Berlioz on 28.01.16.
//  Copyright © 2016 Nikolay Berlioz. All rights reserved.
//

#import "Brand.h"

@implementation Brand

static NSString* brandNames[] = {
    @"AlfredSargent", @"Barker", @"Cheaney", @"Church", @"Herring",
    @"JefferyWest", @"Loake", @"Sebago", @"Tricker"
};

static int namesCount = 9;

- (NSString*) randomBrandNameWithArray:(NSMutableArray*)array
{
    NSString *brandName;
    
    BOOL enableRepeat = NO;
    
    do
    {
        enableRepeat = NO;
        
        brandName = brandNames[arc4random() % namesCount];
        
        if ([array count] > 0)
        {
            for (Brand *brand in array)
            {
                if ([brandName isEqualToString:brand.name])
                {
                    enableRepeat = YES;
                }
            }
        }
        
    } while (enableRepeat);
    
    return brandName;
}

@end
