//
//  Cell.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/14/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "Cell.h"
#import "CustomCellBackground.h"

@implementation Cell

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        CustomCellBackground *backView = [[CustomCellBackground alloc] initWithFrame:CGRectZero];
        self.selectedBackgroundView = backView;
    }
    return self;
}

@end
/Users/Stephen/Desktop/Cedarville/Senior Yr/Spring '13/Sys Dev/VisionTrust/VisionTrust.xcodeproj/project.xcworkspace/xcuserdata/Stephen.xcuserdatad/UserInterfaceState.xcuserstate