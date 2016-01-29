//
//  MainViewController.m
//  TableViewEditWH31-32
//
//  Created by Nikolay Berlioz on 28.01.16.
//  Copyright © 2016 Nikolay Berlioz. All rights reserved.
//

#import "MainViewController.h"
#import "Brand.h"
#import "Model.h"
#import "WToast.h"

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) UITableView *mainTableView;
@property (strong, nonatomic) NSMutableArray *brandsArray;

@end

@implementation MainViewController

- (void) loadView
{
    [super loadView];
    
    CGRect frame = self.view.bounds;
    frame.origin = CGPointZero;
    
    UITableView *mainTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    mainTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    
    [self.view addSubview:mainTableView];
    
    self.mainTableView = mainTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.brandsArray = [[NSMutableArray alloc] init];
    
//    for (int i = 0; i < 3; i++)
//    {
//        Brand *brand = [[Brand alloc] init];
//        brand.name = [brand randomBrandNameWithArray:self.brandsArray];
//        
//        NSMutableArray *array = [[NSMutableArray alloc] init];
//        
//        for (int j = 0; j < 3; j++)
//        {
//            Model *model = [Model randomModelWithName:brand.name AndArray:array];
//            
//            [array addObject:model];
//        }
//        
//        brand.models = array;
//        [self.brandsArray addObject:brand];
//    }
//    
//    [self.mainTableView reloadData];
    
    //-------------   UINavigationController   -------------------
    
    self.navigationItem.title = @"England shoes";
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                                        target:self
                                                                                        action:@selector(actionEdit:)];
    self.navigationItem.rightBarButtonItem = editButton;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                target:self
                                                                                action:@selector(actionAddSection:)];
    self.navigationItem.leftBarButtonItem = addButton;
    
    
}

#pragma mark - Action

- (void) actionAddSection:(UIBarButtonItem*)sender
{
    if ([self.brandsArray count] < 9)
    {
        Brand *brand = [[Brand alloc] init];
        brand.name = [brand randomBrandNameWithArray:self.brandsArray];
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        
        for (int j = 0; j < 3; j++)
        {
            Model *model = [Model randomModelWithName:brand.name AndArray:array];
            
            [array addObject:model];
        }
        
        brand.models = array;
        
        NSInteger newSectionIndex = 0;
        
        [self.brandsArray insertObject:brand atIndex:newSectionIndex];
        
        NSIndexSet *insertSections = [NSIndexSet indexSetWithIndex:newSectionIndex];
        
        [self.mainTableView beginUpdates];
        
        [self.mainTableView insertSections:insertSections withRowAnimation:UITableViewRowAnimationLeft];
        
        [self.mainTableView endUpdates];
        
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            if ([[UIApplication sharedApplication] isIgnoringInteractionEvents])
            {
                [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            }
        });
    }
    else
    {
        
        [WToast showWithText:@"Presented all brands!" duration:kWTShort roundedCorners:YES];
    }
}

- (void) actionEdit:(UIBarButtonItem*)sender
{
    BOOL isEditing = self.mainTableView.editing;
    
    [self.mainTableView setEditing:!isEditing animated:YES];
    
    UIBarButtonSystemItem item = UIBarButtonSystemItemEdit;
    
    if (self.mainTableView.editing)
    {
        item = UIBarButtonSystemItemDone;
    }
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:item
                                                                                target:self
                                                                                action:@selector(actionEdit:)];
    self.navigationItem.rightBarButtonItem = editButton;
}

#pragma mark - UITableViewDataSource

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        Brand *brand = [self.brandsArray objectAtIndex:indexPath.section];
        Model*model = [brand.models objectAtIndex:indexPath.row - 1];
        
        NSMutableArray *array = [NSMutableArray arrayWithArray:brand.models];
        [array removeObject:model];
        brand.models = array;
        
        [tableView beginUpdates];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
        
        [tableView endUpdates];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.brandsArray count];
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[self.brandsArray objectAtIndex:section] name];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    Brand *brand = [self.brandsArray objectAtIndex:section];
    
    return [brand.models count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        static NSString *addNewModelIdentifier = @"NewModelCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:addNewModelIdentifier];
        
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:addNewModelIdentifier];
            cell.backgroundColor = [UIColor lightGrayColor];
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.textLabel.text = @"Tap to add new model";
            UIImage *image = [UIImage imageNamed:@"add.png"];
            cell.imageView.image = image;
        }
        return cell;
    }
    else
    {
        static NSString *modelIdentifier = @"ModelCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:modelIdentifier];
        
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:modelIdentifier];
        }
        
        Brand *brand = [self.brandsArray objectAtIndex:indexPath.section];
        Model*model = [brand.models objectAtIndex:indexPath.row - 1];
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@", model.itemName];
        
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", model.itemName]];
        cell.imageView.image = image;
        
        return cell;
    }

}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row > 0;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    Brand *sourceBrand = [self.brandsArray objectAtIndex:sourceIndexPath.section];
    Model *model = [sourceBrand.models objectAtIndex:sourceIndexPath.row - 1];
    
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:sourceBrand.models];
    
    if (sourceIndexPath.section == destinationIndexPath.section)
    {
        [tempArray removeObjectAtIndex:sourceIndexPath.row - 1];
        [tempArray insertObject:model atIndex:destinationIndexPath.row - 1];
        sourceBrand.models = tempArray;
    }
    else
    {
        [tempArray removeObject:model];
        sourceBrand.models = tempArray;
        
        Brand *destinationBrand = [self.brandsArray objectAtIndex:destinationIndexPath.section];
        tempArray = [NSMutableArray arrayWithArray:destinationBrand.models];
        [tempArray insertObject:model atIndex:destinationIndexPath.row - 1];
        destinationBrand.models = tempArray;
    }
    
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0)
    {
        Brand *brand = [self.brandsArray objectAtIndex:indexPath.section];
        
        NSMutableArray *array = nil;
        
        if (brand.models)
        {
            array = [NSMutableArray arrayWithArray:brand.models];
        }
        else
        {
            [NSMutableArray array];
        }
        
        if ([array count] < 10)
        {
            Model *model = [Model randomModelWithName:brand.name AndArray:array];
            
            NSInteger newModelIndex = 0;
            [array insertObject:model atIndex:newModelIndex];
            brand.models = array;
            
            NSIndexPath *newIndexPath = [NSIndexPath indexPathForItem:newModelIndex + 1 inSection:indexPath.section];
            
            [self.mainTableView beginUpdates];
            [self.mainTableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
            [self.mainTableView endUpdates];
            
            [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                if ([[UIApplication sharedApplication] isIgnoringInteractionEvents])
                {
                    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                }
            });
        }
        else
        {
            [WToast showWithText:@"All models of this brand!" duration:kWTShort roundedCorners:YES];
        }
       
        
    }
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row == 0 ? UITableViewCellEditingStyleNone : UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    if (proposedDestinationIndexPath.row == 0)
    {
        return sourceIndexPath;
    }
    else
    {
        return proposedDestinationIndexPath;
    }
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"Delete model";
}

@end


















