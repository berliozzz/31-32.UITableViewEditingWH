//
//  Model.m
//  TableViewEditWH31-32
//
//  Created by Nikolay Berlioz on 28.01.16.
//  Copyright © 2016 Nikolay Berlioz. All rights reserved.
//

#import "Model.h"

@implementation Model

static NSString* AlfredSargentNames[] = {
    @"Scott", @"Shackleton", @"Alfred II brogue", @"Charles II", @"Drake",
    @"Edward II", @"Fiennes brogue", @"Henry II brogue", @"James", @"Richard"
};

static NSString* BarkerNames[] = {
    @"Albert brogue", @"Clive brogue", @"Northcote monk shoe", @"Tunstall monk shoe", @"Adrian",
    @"Alfred", @"Andrew brogue", @"Arnold", @"Banbury", @"Bath brogue"
};

static NSString* CheaneyNames[] = {
    @"Attlee monk shoe", @"Chamberlain", @"Fencote brogue", @"Asquith monk shoe", @"Baldwin II",
    @"Bodmin II brogue", @"Cranmere monk shoe", @"Jasper monk shoe", @"Montpellier", @"Thatcher brogue"
};

static NSString* ChurchNames[] = {
    @"Consul", @"Diplomat", @"Grafton brogue", @"Shannon", @"Alastair",
    @"Burwood brogue", @"Chetwynd brogue", @"Darwin", @"Keats 450", @"Sahara Leather"
};

static NSString* HerringNames[] = {
    @"Scott", @"Shackleton", @"Drake", @"Fiennes brogue", @"Attlee monk shoe",
    @"Chamberlain", @"Exmoor brogue", @"Fencote brogue", @"Alfred II brogue", @"Edward II"
};

static NSString* JefferyWestNames[] = {
    @"Bay brogue", @"Dazed brogue", @"Dread brogue", @"Harry monk shoe", @"Laurance",
    @"Masuka", @"Moser monk shoe", @"Novikov brogue", @"1034JW brogue", @"J305 brogue"
};

static NSString* LoakeNames[] = {
    @"Aldwych", @"Buckingham brogue", @"Cannon monk shoe", @"Kempton (Rubber Sole)", @"Ashby brogue",
    @"Badminton 2 brogue", @"Beaufort brogue", @"Burford brogue", @"Highgate", @"Wolf"
};

static NSString* SebagoNames[] = {
    @"Classic", @"Docksides", @"Endeavor", @"Schooner", @"Clovehitch",
    @"Gibraltar", @"Ketch", @"Sloop", @"Spinnaker", @"Triton"
};

static NSString* TrickerNames[] = {
    @"Bourton brogue", @"Stow brogue", @"Stow (Rubber) brogue", @"Bourton (Rubber) brogue", @"Ilkley brogue",
    @"Kendal", @"Keswick brogue", @"Keswick (rubber) brogue", @"Mayfair monk shoe", @"Kensington"
};

static int namesCount = 10;


+ (Model*) randomModelWithName:(NSString*)name AndArray:(NSMutableArray*)array
{
    Model *model = [[Model alloc] init];
    
    BOOL enableRepeat = false;
    
    do {
        enableRepeat = false;
        
        if ([name isEqualToString:@"AlfredSargent"])
        {
            model.itemName = AlfredSargentNames[arc4random() % namesCount];
        }
        else if ([name isEqualToString:@"Barker"])
        {
            model.itemName = BarkerNames[arc4random() % namesCount];
        }
        else if ([name isEqualToString:@"Cheaney"])
        {
            model.itemName = CheaneyNames[arc4random() % namesCount];
        }
        else if ([name isEqualToString:@"Church"])
        {
            model.itemName = ChurchNames[arc4random() % namesCount];
        }
        else if ([name isEqualToString:@"Herring"])
        {
            model.itemName = HerringNames[arc4random() % namesCount];
        }
        else if ([name isEqualToString:@"JefferyWest"])
        {
            model.itemName = JefferyWestNames[arc4random() % namesCount];
        }
        else if ([name isEqualToString:@"Loake"])
        {
            model.itemName = LoakeNames[arc4random() % namesCount];
        }
        else if ([name isEqualToString:@"Sebago"])
        {
            model.itemName = SebagoNames[arc4random() % namesCount];
        }
        else if ([name isEqualToString:@"Tricker"])
        {
            model.itemName = TrickerNames[arc4random() % namesCount];
        }
        
        if ([array count] > 0)
        {
            for (Model *obj in array)
            {
                if ([obj.itemName isEqualToString:model.itemName])
                {
                    enableRepeat = YES;
                }
            }
        }
        
        
    } while (enableRepeat);
    
    return model;
}

@end
