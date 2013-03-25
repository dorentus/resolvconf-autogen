//
//  ApplicationDelegate.m
//  resolvconf-autogen
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

        double delayInSeconds = 3.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            SCDynamicStoreRef ds = SCDynamicStoreCreate(kCFAllocatorDefault, CFSTR("resolvconf-autogen"), NULL, NULL);

            // get PrimaryService for later use
            CFDictionaryRef dr = SCDynamicStoreCopyValue(ds, CFSTR("State:/Network/Global/IPv4"));
            NSDictionary *dict = [NSDictionary dictionaryWithDictionary:(__bridge NSDictionary *)dr];
            CFRelease(dr);

            NSString *primaryService = [dict objectForKey:@"PrimaryService"];

            // retrieve DNS ServerAddresses list
            NSString *SCAddrListPathString = [NSString stringWithFormat:@"State:/Network/Service/%@/DNS", primaryService];
            dr = SCDynamicStoreCopyValue(ds, (__bridge CFStringRef)(SCAddrListPathString));
            NSDictionary *dnsDict = [NSDictionary dictionaryWithDictionary:(__bridge NSDictionary *)dr];
            CFRelease(dr);

            NSArray *dnsServerAddressList = [dnsDict objectForKey:@"ServerAddresses"];
            if (![dnsServerAddressList isKindOfClass:[NSArray class]]) {
                dnsServerAddressList = nil;
            }

            CFRelease(ds);

            NSLog(@"DNS: %@", dnsServerAddressList);

            if (dnsServerAddressList.count > 0) {
                NSMutableString *output = [[NSMutableString alloc] init];
                for (id addr in dnsServerAddressList) {
                    [output appendFormat:@"nameserver %@\n", addr];
                }
                NSError *error;
                BOOL ok = [output writeToURL:_fileURL atomically:YES encoding:NSASCIIStringEncoding error:&error];
                if (!ok) {
                    NSLog(@"Failed write to file %@, error: %@", _fileURL.absoluteString, [error localizedDescription]);
                } else {
                    NSLog(@"wrote to %@:\n%@", _fileURL.absoluteString, output);
                }
            }
        });
    };
    reach.unreachableBlock = ^(Reachability *reach) {
        NSLog(@"link down");
    };
    [reach startNotifier];
}

@end
