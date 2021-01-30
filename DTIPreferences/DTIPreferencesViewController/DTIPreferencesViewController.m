//
//  DTIPreferencesViewController.m
//  DesktopTime Preferences
//
//  Created by Marcel Dierkes on 30.01.21.
//

#import "DTIPreferencesViewController.h"
#import "DTIDefines.h"
#import "DTIPreferenceItem.h"
#import "DTIPreferencesChildViewControllers.h"

static const NSUserInterfaceItemIdentifier DTIHeaderCellIdentifier = @"HeaderCell";
static const NSUserInterfaceItemIdentifier DTIDataCellIdentifier = @"DataCell";

@interface DTIPreferencesViewController ()
@property (nonatomic) NSArray<DTIPreferenceItem *> *preferenceItems;
@property (nonatomic, readonly) NSSplitViewController *splitViewController;
@end

@implementation DTIPreferencesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configurePreferenceItems];
    
    [self.outlineView reloadData];
    
    [self expandAllGroups];
    [self selectFirstItem];
}

- (NSSplitViewController *)splitViewController
{
    return (NSSplitViewController *)self.parentViewController;
}

- (void)configurePreferenceItems
{
    Auto layoutItem = [[DTIPreferenceItem alloc] initWithUUID:[NSUUID UUID]
                                                         name:NSLocalizedString(@"Layout", @"Layout")];
    layoutItem.image = [NSImage imageWithSystemSymbolName:@"dock.rectangle"
                                 accessibilityDescription:nil];
    layoutItem.representedObject = DTILayoutPreferencesViewController.identifier;
    Auto dateItem = [[DTIPreferenceItem alloc] initWithUUID:[NSUUID UUID]
                                                       name:NSLocalizedString(@"Date & Time", @"Date & Time")];
    dateItem.image = [NSImage imageWithSystemSymbolName:@"calendar.badge.clock"
                               accessibilityDescription:nil];
    dateItem.representedObject = DTIDateTimePreferencesViewController.identifier;
    Auto batteryItem = [[DTIPreferenceItem alloc] initWithUUID:[NSUUID UUID]
                                                          name:NSLocalizedString(@"Battery", @"Battery")];
    batteryItem.image = [NSImage imageWithSystemSymbolName:@"battery.100.bolt"
                                  accessibilityDescription:nil];
    batteryItem.representedObject = DTIBatteryPreferencesViewController.identifier;
    
    self.preferenceItems = @[
        [[DTIPreferenceItem alloc] initWithUUID:[NSUUID UUID]
                                     headerName:NSLocalizedString(@"Preferences", @"Preferences")
                                          image:nil
                                       children:@[layoutItem, dateItem, batteryItem]]
    ];
}

- (void)expandAllGroups
{
    for(DTIPreferenceItem *header in self.preferenceItems)
    {
        [self.outlineView expandItem:header];
    }
}

- (void)selectFirstItem
{
    Auto outlineView = self.outlineView;
    Auto firstItem = self.preferenceItems.firstObject.children.firstObject;
    Auto row = [outlineView rowForItem:firstItem];
    [outlineView selectRowIndexes:[NSIndexSet indexSetWithIndex:row]
             byExtendingSelection:NO];
}

- (void)showDetailsForPreferenceItem:(DTIPreferenceItem *)preferenceItem
{
    NSParameterAssert(preferenceItem);

    Auto split = self.splitViewController;
    Auto detailItem = split.splitViewItems.lastObject;

    NSUserInterfaceItemIdentifier identifier = preferenceItem.representedObject;
    if(identifier != nil)
    {
        Auto controller = (NSViewController *)[self.storyboard instantiateControllerWithIdentifier:identifier];
        if(![detailItem.viewController isKindOfClass:[controller class]])
        {
            [self setSplitDetailViewController:controller];
        }
    }
}

- (void)setSplitDetailViewController:(__kindof NSViewController *)controller
{
    NSAssert(self.view.window != nil, @"The view must be attached to a window.");
    
    Auto split = self.splitViewController;
    Auto sidebarItem = split.splitViewItems.firstObject;
    Auto detailItem = [NSSplitViewItem splitViewItemWithViewController:controller];
    detailItem.titlebarSeparatorStyle = NSTitlebarSeparatorStyleLine;

    split.splitViewItems = @[sidebarItem, detailItem];
}

#pragma mark - NSOutlineViewDataSource

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item
{
    // Root
    if(item == nil) { return self.preferenceItems[index]; }

    Auto preferenceItem = (DTIPreferenceItem *)item;
    return  preferenceItem.children[index];
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item
{
    // Root
    if(item == nil) { return YES; }

    Auto preferenceItem = (DTIPreferenceItem *)item;
    return [preferenceItem isHeader];
}

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item
{
    // Root
    if(item == nil) { return self.preferenceItems.count; }

    Auto preferenceItem = (DTIPreferenceItem *)item;
    return preferenceItem.children.count;
}

#pragma mark - NSOutlineViewDelegate

- (NSView *)outlineView:(NSOutlineView *)outlineView viewForTableColumn:(NSTableColumn *)tableColumn item:(id)item
{
    Auto preferenceItem = (DTIPreferenceItem *)item;
    if([preferenceItem isHeader])
    {
        Auto header = [outlineView makeViewWithIdentifier:DTIHeaderCellIdentifier owner:self];
        Auto textField = (NSTextField *)header.subviews.firstObject;
        textField.stringValue = preferenceItem.name;
        return header;
    }
    else
    {
        Auto cell = [outlineView makeViewWithIdentifier:DTIDataCellIdentifier owner:self];
        Auto imageView = (NSImageView *)cell.subviews.firstObject;
        imageView.image = preferenceItem.image;
        Auto textField = (NSTextField *)cell.subviews.lastObject;
        textField.stringValue = preferenceItem.name;
        return cell;
    }
}

- (BOOL)outlineView:(NSOutlineView *)outlineView shouldSelectItem:(id)item
{
    Auto preferenceItem = (DTIPreferenceItem *)item;
    return ![preferenceItem isHeader];
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isGroupItem:(id)item
{
    Auto preferenceItem = (DTIPreferenceItem *)item;
    return [preferenceItem isHeader];
}

- (NSTintConfiguration *)outlineView:(NSOutlineView *)outlineView tintConfigurationForItem:(id)item
{
    Auto preferenceItem = (DTIPreferenceItem *)item;
    return preferenceItem.tintConfiguration;
}

- (void)outlineViewSelectionDidChange:(NSNotification *)notification
{
    Auto outlineView = (NSOutlineView *)notification.object;

    Auto row = outlineView.selectedRow;
    Auto preferenceItem = (DTIPreferenceItem *)[outlineView itemAtRow:row];
    if(preferenceItem != nil)
    {
        [self showDetailsForPreferenceItem:preferenceItem];
    }
}

@end
