//
//  AddItemsWindow.h
//  MunkiAdmin
//
//  Created by Juutilainen Hannes on 19.10.2011.
//

#import <Cocoa/Cocoa.h>
#import "PackageArrayController.h"
#import "MAApplicationsArrayController.h"

@interface MASelectPkginfoItemsWindow : NSWindowController <NSTextFieldDelegate> {
    BOOL shouldHideAddedItems;
}

@property (weak) IBOutlet NSSearchField *groupedSearchField;
@property (weak) IBOutlet NSSearchField *individualSearchField;
@property (weak) IBOutlet NSTableView *individualTableView;
@property (weak) IBOutlet NSTableView *groupedTableView;
@property (strong) NSPredicate *hideAddedPredicate;
@property (strong) NSPredicate *hideGroupedAppleUpdatesPredicate;
@property (strong) NSPredicate *hideIndividualAppleUpdatesPredicate;
@property BOOL shouldHideAddedItems;
@property (weak) IBOutlet PackageArrayController *individualPkgsArrayController;
@property (weak) IBOutlet MAApplicationsArrayController *groupedPkgsArrayController;
@property (weak) IBOutlet NSTabView *tabView;
@property NSInteger currentMode;
@property (weak) IBOutlet NSTextField *customValueTextField;
@property (weak) IBOutlet NSView *indSearchBgView;
@property (weak) IBOutlet NSView *groupSearchBgView;
@property (weak) IBOutlet NSView *customBgView;

- (NSArray *)selectionAsStringObjects;
- (void)updateGroupedSearchPredicate;
- (void)updateIndividualSearchPredicate;

@end
