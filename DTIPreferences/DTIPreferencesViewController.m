//
//  DTIPreferencesViewController.m
//  DesktopTime Preferences
//
//  Created by Marcel Dierkes on 30.01.21.
//

#import "DTIPreferencesViewController.h"
#import "DTIDefines.h"
#import "DTIPreferenceItemViewModel.h"
#import "DTILayoutPreferencesViewController.h"
#import "DTIDateTimePreferencesViewController.h"
#import "DTIBatteryPreferencesViewController.h"

static const NSUserInterfaceItemIdentifier DTIHeaderCellIdentifier = @"HeaderCell";
static const NSUserInterfaceItemIdentifier DTIDataCellIdentifier = @"DataCell";

@interface DTIPreferencesViewController ()
@property (nonatomic) NSArray<DTIPreferenceItemViewModel *> *itemViewModels;
@property (nonatomic, readonly) NSSplitViewController *splitViewController;
@end

@implementation DTIPreferencesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configureItemViewModels];
    
    [self.outlineView reloadData];
    
    [self expandAllGroups];
    [self selectFirstItem];
}

- (NSSplitViewController *)splitViewController
{
    return (NSSplitViewController *)self.parentViewController;
}

- (void)configureItemViewModels
{
    Auto layoutItem = [[DTIPreferenceItemViewModel alloc] initWithUUID:[NSUUID UUID]
                                                                  name:NSLocalizedString(@"Layout", @"Layout")];
    layoutItem.image = [NSImage imageWithSystemSymbolName:@"dock.rectangle"
                                 accessibilityDescription:nil];
    layoutItem.representedObject = DTILayoutPreferencesViewController.identifier;
    Auto dateItem = [[DTIPreferenceItemViewModel alloc] initWithUUID:[NSUUID UUID]
                                                                name:NSLocalizedString(@"Date & Time", @"Date & Time")];
    dateItem.image = [NSImage imageWithSystemSymbolName:@"calendar.badge.clock"
                               accessibilityDescription:nil];
    dateItem.representedObject = DTIDateTimePreferencesViewController.identifier;
    Auto batteryItem = [[DTIPreferenceItemViewModel alloc] initWithUUID:[NSUUID UUID]
                                                                   name:NSLocalizedString(@"Battery", @"Battery")];
    batteryItem.image = [NSImage imageWithSystemSymbolName:@"battery.100.bolt"
                                  accessibilityDescription:nil];
    batteryItem.representedObject = DTIBatteryPreferencesViewController.identifier;
    
    self.itemViewModels = @[
        [[DTIPreferenceItemViewModel alloc] initWithUUID:[NSUUID UUID]
                                              headerName:NSLocalizedString(@"Preferences", @"Preferences")
                                                   image:nil
                                                children:@[layoutItem, dateItem, batteryItem]]
    ];
}

- (void)expandAllGroups
{
    for(DTIPreferenceItemViewModel *header in self.itemViewModels)
    {
        [self.outlineView expandItem:header];
    }
}

- (void)selectFirstItem
{
    Auto outlineView = self.outlineView;
    Auto firstModel = self.itemViewModels.firstObject.children.firstObject;
    Auto row = [outlineView rowForItem:firstModel];
    [outlineView selectRowIndexes:[NSIndexSet indexSetWithIndex:row]
             byExtendingSelection:NO];
}

- (void)showDetailsForViewModel:(DTIPreferenceItemViewModel *)model
{
    NSParameterAssert(model);

    Auto split = self.splitViewController;
    Auto detailItem = split.splitViewItems.lastObject;

    NSUserInterfaceItemIdentifier modelIdentifier = model.representedObject;
    if(modelIdentifier != nil)
    {
        Auto controller = (NSViewController *)[self.storyboard instantiateControllerWithIdentifier:modelIdentifier];
        if(![detailItem.viewController isKindOfClass:[controller class]])
        {
            [self setSplitDetailViewController:controller];
        }
    }
}

- (void)setSplitDetailViewController:(__kindof NSViewController *)controller
{
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
    if(item == nil) { return self.itemViewModels[index]; }

    Auto model = (DTIPreferenceItemViewModel *)item;
    return  model.children[index];
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item
{
    // Root
    if(item == nil) { return YES; }

    Auto model = (DTIPreferenceItemViewModel *)item;
    return [model isHeader];
}

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item
{
    // Root
    if(item == nil) { return self.itemViewModels.count; }

    Auto model = (DTIPreferenceItemViewModel *)item;
    return model.children.count;
}

#pragma mark - NSOutlineViewDelegate

- (NSView *)outlineView:(NSOutlineView *)outlineView viewForTableColumn:(NSTableColumn *)tableColumn item:(id)item
{
    Auto model = (DTIPreferenceItemViewModel *)item;
    if([model isHeader])
    {
        Auto header = [outlineView makeViewWithIdentifier:DTIHeaderCellIdentifier owner:self];
        Auto textField = (NSTextField *)header.subviews.firstObject;
        textField.stringValue = model.name;
        return header;
    }
    else
    {
        Auto cell = [outlineView makeViewWithIdentifier:DTIDataCellIdentifier owner:self];
        Auto imageView = (NSImageView *)cell.subviews.firstObject;
        imageView.image = model.image;
        Auto textField = (NSTextField *)cell.subviews.lastObject;
        textField.stringValue = model.name;
        return cell;
    }
}

- (BOOL)outlineView:(NSOutlineView *)outlineView shouldSelectItem:(id)item
{
    Auto model = (DTIPreferenceItemViewModel *)item;
    return ![model isHeader];
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isGroupItem:(id)item
{
    Auto model = (DTIPreferenceItemViewModel *)item;
    return [model isHeader];
}

- (NSTintConfiguration *)outlineView:(NSOutlineView *)outlineView tintConfigurationForItem:(id)item
{
    Auto model = (DTIPreferenceItemViewModel *)item;
    return model.tintConfiguration;
}

- (void)outlineViewSelectionDidChange:(NSNotification *)notification
{
    Auto outlineView = (NSOutlineView *)notification.object;

    Auto row = outlineView.selectedRow;
    Auto model = (DTIPreferenceItemViewModel *)[outlineView itemAtRow:row];
    if(model != nil)
    {
        [self showDetailsForViewModel:model];
    }
}

@end
