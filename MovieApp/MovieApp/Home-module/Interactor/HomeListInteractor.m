//
//  HomeListInteractor.m
//  MovieApp
//
//  Created by David Adell on 24/3/19.
//  Copyright © 2019 djadell. All rights reserved.
//

#import "HomeListInteractor.h"
#import "Tools.h"

@implementation HomeListInteractor


- (void)getPopularMoviesWithPage:(int)aPage
{
    //Ej URL: https://api.themoviedb.org/3/movie/popular?api_key=93aea0c77bc168d8bbce3918cefefa45&language=es-ES&page=1
    NSString *sIpadLanguage = [Tools getIpadLanguage];
    
    NSString *dataUrl = [NSString stringWithFormat:@"%@://%@/3/movie/popular",K_NET_API_SERVER_PROTOCOL,K_NET_API_SERVER_NAME];
    dataUrl = [dataUrl stringByAppendingString:[NSString stringWithFormat:@"?api_key=%@",K_NET_API_KEY]];
    dataUrl = [dataUrl stringByAppendingString:[NSString stringWithFormat:@"&language=%@",sIpadLanguage]];
    dataUrl = [dataUrl stringByAppendingString:[NSString stringWithFormat:@"&page=/%d",aPage]];
    
    NSURL *url = [NSURL URLWithString:dataUrl];
    
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession]
                                          dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                              
                                              if (data != nil && error == nil)
                                              {
                                                  NSError *errorJSON;
                                                  NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&errorJSON];
                                                  
                                                  [self dataProcessingWithDictionary:dictionary];
                                              }
                                              else // There was an error
                                              {
                                                  NSLog(@"[getData] Error:\n %ld %@",(long)error.code, error.description);
                                              }
                                          }];
    [downloadTask resume];
}

- (void)dataProcessingWithDictionary:(NSDictionary*)dicJSON
{
    int totalPages = 1;
    
    NSNumber *nTotalPages = [dicJSON objectForKey:@"total_pages"];
    NSArray *aResults = [dicJSON objectForKey:@"results"];
    
    for (NSDictionary* dicMovie in aResults) {
        // Must be implemented
    }
    
    //HardCoded Data
    NSArray *outputItems = [[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4", nil];
    
    
    
    if (self.iDelegate &&
        [self.iDelegate conformsToProtocol:@protocol(HomeListInteractorDelegate)]&&
        [self.iDelegate respondsToSelector:@selector(dataFetchingResults:totalPages:)])
    {
        [self.iDelegate dataFetchingResults:outputItems totalPages:totalPages]; ///TODO: change type!
    }
}

@end
