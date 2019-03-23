//
//  Tools.m
//  MovieApp
//
//  Created by David Adell on 23/3/19.
//  Copyright © 2019 djadell. All rights reserved.
//

#import "Tools.h"


@implementation Tools

//MARK: - Network
+ (BOOL)isConnectedToInternet
{
    Reachability *rHost = [Reachability reachabilityWithHostName:K_NET_API_SERVER_NAME];
    NetworkStatus nsHost = [rHost currentReachabilityStatus];
    if (nsHost == ReachableViaWiFi)
    {
        NSLog(@"******************************************");
        NSLog(@"Device is connected to the internet [WiFi]");
        NSLog(@"******************************************");
        return YES;
    }
    else if (nsHost == ReachableViaWWAN)
    {
        NSLog(@"************************************************");
        NSLog(@"Device is connected to the internet [WWAN/3G/4G]");
        NSLog(@"************************************************");
        return YES;
    }
    else //NotReachable
    {   NSLog(@"***************************************");
        NSLog(@"Device is not connected to the internet");
        NSLog(@"***************************************");
        return NO;
    }
}

@end
