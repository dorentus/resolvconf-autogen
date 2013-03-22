//
//  DRAppDelegate.m
//  gw-monitor
//
//  Created by Zhang Yi on 13-3-22.
//  Copyright (c) 2013年 Zhang Yi.
//

#import "DRAppDelegate.h"
#include "DRHelper.h"

@implementation DRAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)notification
{
    [[NSDistributedNotificationCenter defaultCenter] addObserver:self selector:@selector(onGWUpdate:) name:GW_UPDATE_NOTIFICATION_NAME object:nil];
}

- (void)applicationWillTerminate:(NSNotification *)notification
{
    [[NSDistributedNotificationCenter defaultCenter] removeObserver:self];
}

- (void)onGWUpdate:(NSNotification *)notification
{
    NSLog(@"GW UPDATE: %@", notification.userInfo);

    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        // killall -HUP dnsmasq
        pid_t pid = GetPidForProcessWithName(@"dnsmasq");
        if (pid == -1) {
            NSLog(@"dnsmasq is not running");
            return;
        }

        int result = kill(pid, SIGHUP);
        if (result != 0) {
            NSLog(@"failed sending SIGHUP to process %d", pid);
        } else {
            NSLog(@"successfully sending SIGHUP to process %d", pid);
        }
    });
}

@end
