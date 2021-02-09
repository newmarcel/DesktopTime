//
//  DTILayoutElementController.m
//  DesktopTime
//
//  Created by Marcel Dierkes on 08.02.21.
//

#import "DTILayoutElementController.h"
#import "DTIDefines.h"

@interface DTILayoutElementController ()
@property (nonatomic, readwrite) DTILayoutElement element;
@property (weak, nonatomic, nullable, readwrite) NSTextField *textLabel;
@end

@interface DTIDateTimeLayoutElementController : DTILayoutElementController
@end

@interface DTIBatteryLevelLayoutElementController : DTILayoutElementController
@end

@implementation DTILayoutElementController

@end

@implementation DTIDateTimeLayoutElementController
@end

@implementation DTIBatteryLevelLayoutElementController
@end
