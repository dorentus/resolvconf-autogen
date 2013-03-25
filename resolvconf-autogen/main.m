//
//  main.m
//  resolvconf-autogen
//
//  Created by Zhang Yi on 13-3-22.
//  Copyright (c) 2013年 Zhang Yi.
//

#import <CoreFoundation/CoreFoundation.h>
#import "ApplicationDelegate.h"
#include <libgen.h>

int main(int argc, const char * argv[])
{
    if (argc != 2) {
        printf("Monitor network change and write current gateway to file (resolv.conf format)\n\nUsage: %s <output-file>", basename((char *)argv[0]));
        return 0;
    }

    @autoreleasepool {
        NSString *filepath = [NSString stringWithCString:argv[1] encoding:NSUTF8StringEncoding];
        NSURL *fileURL = [NSURL fileURLWithPath:filepath];

        if (!EnsureFileExistsAtURL(fileURL)) {
            return -1;
        }

        ApplicationDelegate *delegate = [[ApplicationDelegate alloc] initWithFileURL:fileURL];
        NSApplication *app = [NSApplication sharedApplication];
        [app setDelegate:delegate];
        [app run];
    }

    return 0;
}

