//
//  main.m
//  dnsmasq-reloader
//
//  Created by Zhang Yi on 13-3-22.
//  Copyright (c) 2013年 Zhang Yi. All rights reserved.
//

#import <CoreFoundation/CoreFoundation.h>
#import "DRAppDelegate.h"

int main(int argc, const char * argv[])
{
    @autoreleasepool {
        DRAppDelegate *delegate = [[DRAppDelegate alloc] init];
        NSApplication *app = [NSApplication sharedApplication];
        [app setDelegate:delegate];
        [app run];
    }
    return 0;
}

