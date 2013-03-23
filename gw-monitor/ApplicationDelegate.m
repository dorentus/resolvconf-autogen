//
//  ApplicationDelegate.m
//  gw-monitor
//
//  Created by Zhang Yi on 13-3-22.
//  Copyright (c) 2013年 Zhang Yi.
//

#import "ApplicationDelegate.h"
#import "Reachability.h"

@interface ApplicationDelegate ()

@property (nonatomic, strong) NSURL *fileURL;

@end

@implementation ApplicationDelegate

- (id)initWithFileURL:(NSURL *)url
{
    if (self = [super init]) {
        _fileURL = url;
    }
    return self;
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification
{
    Reachability* reach = [Reachability reachabilityWithHostname:@"baidu.com"];
    reach.reachableBlock = ^(Reachability *reach) {
        NSLog(@"link up");

        SCDynamicStoreRef ds = SCDynamicStoreCreate(kCFAllocatorDefault, CFSTR("myapp"), NULL, NULL);
        CFDictionaryRef dr = SCDynamicStoreCopyValue(ds, CFSTR("State:/Network/Global/IPv4"));
        CFStringRef router = CFDictionaryGetValue(dr, CFSTR("Router"));
        NSString *routerString = [NSString stringWithString:(__bridge NSString *)router];
        CFRelease(dr);
        CFRelease(ds);

        if (routerString.length > 0) {
            NSString *output = [NSString stringWithFormat:@"nameserver %@", routerString];
            NSError *error;
            BOOL ok = [output writeToURL:_fileURL atomically:YES encoding:NSASCIIStringEncoding error:&error];
            if (!ok) {
                NSLog(@"Failed write to file %@, error: %@", _fileURL.absoluteString, [error localizedDescription]);
            }
        }
        NSLog(@"router: %@", routerString);
    };
    reach.unreachableBlock = ^(Reachability *reach) {
        NSLog(@"link down");
    };
    [reach startNotifier];
}

@end
