//
//  PreferencesController.h
//  MunkiAdmin
//
//  Created by Hannes Juutilainen on 1.6.2010.
//  Copyright 2010. All rights reserved.
//

#import "MAPreferences.h"
#import "MACoreDataManager.h"
#import "MAMunkiAdmin_AppDelegate.h"


@implementation MAPreferences

- (void)awakeFromNib
{
    self.items = [[NSMutableDictionary alloc] init];
    
	NSToolbarItem *generalItem;
    generalItem = [[NSToolbarItem alloc] initWithItemIdentifier:@"General"];
    [generalItem setPaletteLabel:NSLocalizedString(@"General", @"")];
    [generalItem setLabel:NSLocalizedString(@"General", @"")];
    [generalItem setToolTip:NSLocalizedString(@"General preference options.", @"")];
    [generalItem setImage:[NSImage imageNamed:NSImageNamePreferencesGeneral]];
    [generalItem setTarget:self];
    [generalItem setAction:@selector(switchViews:)];
    [self.items setObject:generalItem forKey:@"General"];
	
	
	NSToolbarItem *munkiItem;
	munkiItem = [[NSToolbarItem alloc] initWithItemIdentifier:@"Munki"];
    [munkiItem setPaletteLabel:NSLocalizedString(@"Munki", @"")];
    [munkiItem setLabel:NSLocalizedString(@"Munki", @"")];
    [munkiItem setToolTip:NSLocalizedString(@"Munki preference options.", @"")];
    [munkiItem setImage:[NSImage imageNamed:@"MunkiAdminIcon_32x32"]];
    [munkiItem setTarget:self];
    [munkiItem setAction:@selector(switchViews:)];
    [self.items setObject:munkiItem forKey:@"Munki"];
    
    
    NSToolbarItem *importOptionsItem;
	importOptionsItem = [[NSToolbarItem alloc] initWithItemIdentifier:@"Import Options"];
    [importOptionsItem setPaletteLabel:NSLocalizedString(@"Import Options", @"")];
    [importOptionsItem setLabel:NSLocalizedString(@"Import Options", @"")];
    [importOptionsItem setToolTip:NSLocalizedString(@"Import Options", @"")];
    [importOptionsItem setImage:[NSImage imageNamed:@"packageGroupIcon_32x32"]];
    [importOptionsItem setTarget:self];
    [importOptionsItem setAction:@selector(switchViews:)];
    [self.items setObject:importOptionsItem forKey:@"Import Options"];
    
    
    NSToolbarItem *advancedItem;
	advancedItem = [[NSToolbarItem alloc] initWithItemIdentifier:@"Advanced"];
    [advancedItem setPaletteLabel:NSLocalizedString(@"Advanced", @"")];
    [advancedItem setLabel:NSLocalizedString(@"Advanced", @"")];
    [advancedItem setToolTip:NSLocalizedString(@"Advanced options.", @"")];
    [advancedItem setImage:[NSImage imageNamed:NSImageNameAdvanced]];
    [advancedItem setTarget:self];
    [advancedItem setAction:@selector(switchViews:)];
    [self.items setObject:advancedItem forKey:@"Advanced"];
    
    NSToolbarItem *appearanceItem;
	appearanceItem = [[NSToolbarItem alloc] initWithItemIdentifier:@"Appearance"];
    [appearanceItem setPaletteLabel:NSLocalizedString(@"Appearance", @"")];
    [appearanceItem setLabel:NSLocalizedString(@"Appearance", @"")];
    [appearanceItem setToolTip:NSLocalizedString(@"Appearance options.", @"")];
    [appearanceItem setImage:[NSImage imageNamed:NSImageNameColorPanel]];
    [appearanceItem setTarget:self];
    [appearanceItem setAction:@selector(switchViews:)];
    [self.items setObject:appearanceItem forKey:@"Appearance"];
	
    //any other items you want to add, do so here.
    //after you are done, just do all the toolbar stuff.
    //myWindow is an outlet pointing to the Preferences Window you made to hold all these custom views.
	
    self.toolbar = [[NSToolbar alloc] initWithIdentifier:@"preferencePanes"];
    [self.toolbar setDelegate:self];
    [self.toolbar setAllowsUserCustomization:NO];
    [self.toolbar setAutosavesConfiguration:NO];
    [self.preferencesWindow setToolbar:self.toolbar];
	[self.preferencesWindow setShowsResizeIndicator:NO];
	[self.preferencesWindow setShowsToolbarButton:NO];
    [self.preferencesWindow center];
	[self.preferencesWindow makeKeyAndOrderFront:self];
    [self switchViews:nil];
    
    /*
     Add observers for the sidebar related defaults keys.
     We need to update the sidebar when these change.
     */
    [[NSUserDefaultsController sharedUserDefaultsController] addObserver:self
                                                              forKeyPath:@"values.sidebarInstallerTypesVisible"
                                                                 options:NSKeyValueObservingOptionNew
                                                                 context:NULL];
    [[NSUserDefaultsController sharedUserDefaultsController] addObserver:self
                                                              forKeyPath:@"values.sidebarCategoriesVisible"
                                                                 options:NSKeyValueObservingOptionNew
                                                                 context:NULL];
    [[NSUserDefaultsController sharedUserDefaultsController] addObserver:self
                                                              forKeyPath:@"values.sidebarDevelopersVisible"
                                                                 options:NSKeyValueObservingOptionNew
                                                                 context:NULL];
    [[NSUserDefaultsController sharedUserDefaultsController] addObserver:self
                                                              forKeyPath:@"values.sidebarDirectoriesVisible"
                                                                 options:NSKeyValueObservingOptionNew
                                                                 context:NULL];
    [[NSUserDefaultsController sharedUserDefaultsController] addObserver:self
                                                              forKeyPath:@"values.sidebarDeveloperMinimumNumberOfPackageNames"
                                                                 options:NSKeyValueObservingOptionNew
                                                                 context:NULL];
}

- (void)switchViews:(NSToolbarItem *)item
{
    NSString *sender;
    if (item == nil) {
        sender = NSLocalizedString(@"General", @"");
        [self.toolbar setSelectedItemIdentifier:sender];
    } else {
        sender = [item label];
    }
	
    NSView *preferencesView;
    [self.preferencesWindow setTitle:sender];
	
    if ([sender isEqualToString:@"General"]) {
        preferencesView = self.generalView;
    } else if ([sender isEqualToString:@"Munki"]) {
        preferencesView = self.munkiView;
    } else if ([sender isEqualToString:@"Import Options"]) {
        preferencesView = self.importOptionsView;
    } else if ([sender isEqualToString:@"Advanced"]) {
        preferencesView = self.advancedView;
    } else if ([sender isEqualToString:@"Appearance"]) {
        preferencesView = self.appearanceView;
    } else {
        preferencesView = self.munkiView;
    }
	
    NSView *tempView = [[NSView alloc] initWithFrame:[[self.preferencesWindow contentView] frame]];
    [self.preferencesWindow setContentView:tempView];
    
    NSRect newFrame = [self.preferencesWindow frame];
    newFrame.size.height = [preferencesView frame].size.height + ([self.preferencesWindow frame].size.height - [[self.preferencesWindow contentView] frame].size.height);
    newFrame.size.width = [preferencesView frame].size.width;
    newFrame.origin.y += ([[self.preferencesWindow contentView] frame].size.height - [preferencesView frame].size.height);
    
    [self.preferencesWindow setShowsResizeIndicator:YES];
    [self.preferencesWindow setFrame:newFrame display:YES animate:YES];
    [self.preferencesWindow setContentView:preferencesView];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    /*
     Reconfigure the package view sidebar if related defaults change
     */
    MACoreDataManager *cdManager = [MACoreDataManager sharedManager];
    NSManagedObjectContext *mainContext = [(MAMunkiAdmin_AppDelegate *)[NSApp delegate] managedObjectContext];
    if ([keyPath isEqualToString:@"values.sidebarInstallerTypesVisible"]) {
        [cdManager configureSourceListInstallerTypesSection:mainContext];
    } else if ([keyPath isEqualToString:@"values.sidebarCategoriesVisible"]) {
        [cdManager configureSourceListCategoriesSection:mainContext];
    } else if ([keyPath isEqualToString:@"values.sidebarDevelopersVisible"]) {
        [cdManager configureSourceListDevelopersSection:mainContext];
    } else if ([keyPath isEqualToString:@"values.sidebarDeveloperMinimumNumberOfPackageNames"]) {
        [cdManager configureSourceListDevelopersSection:mainContext];
    } else if ([keyPath isEqualToString:@"values.sidebarDirectoriesVisible"]) {
        [cdManager configureSourceListDirectoriesSection:mainContext];
    }
    [(MAMunkiAdmin_AppDelegate *)[NSApp delegate] updateSourceList];
}

# pragma mark -
# pragma mark NSToolbar delegate methods

- (NSToolbarItem *)toolbar:(NSToolbar *)toolbar itemForItemIdentifier:(NSString *)itemIdentifier willBeInsertedIntoToolbar:(BOOL)flag
{
    return [self.items objectForKey:itemIdentifier];
}

- (NSArray *)toolbarAllowedItemIdentifiers:(NSToolbar*)theToolbar
{
    return [self toolbarDefaultItemIdentifiers:theToolbar];
}

- (NSArray *)toolbarDefaultItemIdentifiers:(NSToolbar*)theToolbar
{
    return [NSArray arrayWithObjects:@"General", @"Appearance", @"Munki", @"Import Options", @"Advanced", nil];
}

- (NSArray *)toolbarSelectableItemIdentifiers: (NSToolbar *)toolbar
{
    return [self.items allKeys];
}

@end
