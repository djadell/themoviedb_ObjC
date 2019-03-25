//
//  FileManager.m
//  MovieApp
//
//  Created by David Adell on 25/3/19.
//  Copyright © 2019 djadell. All rights reserved.
//

#import "FileManager.h"
#import "Tools.h"

@implementation FileManager

- (void)getImagePath:(NSString*)aImagenURL
{
    if ([Tools isConnectedToInternet]) {
        NSString *sMediaURL = [NSString stringWithFormat:@"%@%@",K_NET_MEDIA_URL,aImagenURL];
        NSURL *url = [NSURL URLWithString:sMediaURL];
        
        NSURLSessionDownloadTask *downloadPhotoTask = [[NSURLSession sharedSession]
                                                       downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                                                           if (location != nil && error == nil)
                                                           {
                                                               [self setImagePath:location];
                                                           }
                                                           else // There was an error
                                                           {
                                                               NSLog(@"[FileManager] Error:\n %ld %@",(long)error.code, error.description);
                                                           }
                                                       }];
        [downloadPhotoTask resume];
    }
}

- (void)setImagePath:(NSURL*)aLocation
{
    if (self.iDelegate &&
        [self.iDelegate conformsToProtocol:@protocol(FileManagerDelegate)]&&
        [self.iDelegate respondsToSelector:@selector(setImagePath:)])
    {
        [self.iDelegate setImagenPath:aLocation];
    }
}

@end
