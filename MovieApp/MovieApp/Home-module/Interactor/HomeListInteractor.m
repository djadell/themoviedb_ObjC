//
//  HomeListInteractor.m
//  MovieApp
//
//  Created by David Adell on 24/3/19.
//  Copyright © 2019 djadell. All rights reserved.
//

#import "HomeListInteractor.h"
#import "DBMovie.h"
#import "Tools.h"

@interface HomeListInteractor ()

@property (nonatomic,strong)NSURLSessionDataTask *iSearchDataTask;
@end

@implementation HomeListInteractor

//MARK: - get Searched movies
- (void)getMoviesSearchedWithText:(NSString*)aSearchText WithPage:(int)aPage isNext:(BOOL)isNext
{
    if (_iSearchDataTask) {
        [self.iSearchDataTask cancel];
    }
    
    if ([Tools isConnectedToInternet]) {
        NSString *sIpadLanguage = [Tools getIpadLanguage];
        
        NSData *postData = [[NSData alloc] initWithData:[@"{}" dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSString *sDataUrl = [NSString stringWithFormat:@"%@://%@/3/search/movie",K_NET_API_SERVER_PROTOCOL,K_NET_API_SERVER_NAME];
        sDataUrl = [sDataUrl stringByAppendingString:[NSString stringWithFormat:@"?api_key=%@",K_NET_API_KEY]];
        sDataUrl = [sDataUrl stringByAppendingString:[NSString stringWithFormat:@"&language=%@",sIpadLanguage]];
        sDataUrl = [sDataUrl stringByAppendingString:[NSString stringWithFormat:@"&page=%d",aPage]];
        sDataUrl = [sDataUrl stringByAppendingString:[NSString stringWithFormat:@"&query=%@",aSearchText]];
        sDataUrl = [sDataUrl stringByAppendingString:[NSString stringWithFormat:@"&include_adult=%@",@"false"]];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:sDataUrl]
                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                           timeoutInterval:K_NET_API_TIMEOUT_INTERVAL];
        [request setHTTPMethod:@"GET"];
        [request setHTTPBody:postData];
        
        NSURLSession *session = [NSURLSession sharedSession];
        self.iSearchDataTask = [session dataTaskWithRequest:request
                                          completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                {
                                    if (data != nil && error == nil)
                                    {
                                        NSError *errorJSON;
                                        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&errorJSON];
                                        
                                        [self dataProcessingWithDictionary:dictionary isNext:isNext];
                                    }
                                    else // There was an error
                                    {
                                        NSLog(@"[getData] Error:\n %ld %@",(long)error.code, error.description);
                                    }
                                }];
        [self.iSearchDataTask resume];
    }
}

//MARK: - get Popular Movies
- (void)getPopularMoviesWithPage:(int)aPage isNext:(BOOL)isNext
{
    if ([Tools isConnectedToInternet]) {
        NSString *sIpadLanguage = [Tools getIpadLanguage];
        
        NSString *dataUrl = [NSString stringWithFormat:@"%@://%@/3/movie/popular",K_NET_API_SERVER_PROTOCOL,K_NET_API_SERVER_NAME];
        dataUrl = [dataUrl stringByAppendingString:[NSString stringWithFormat:@"?api_key=%@",K_NET_API_KEY]];
        dataUrl = [dataUrl stringByAppendingString:[NSString stringWithFormat:@"&language=%@",sIpadLanguage]];
        dataUrl = [dataUrl stringByAppendingString:[NSString stringWithFormat:@"&page=/%d",aPage]];
        
        NSURL *url = [NSURL URLWithString:dataUrl];
        
        NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession]
                                              dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                              { 
                                                  if (data != nil && error == nil)
                                                  {
                                                      NSError *errorJSON;
                                                      NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&errorJSON];
                                                      
                                                      [self dataProcessingWithDictionary:dictionary isNext:isNext];
                                                  }
                                                  else // There was an error
                                                  {
                                                      NSLog(@"[getData] Error:\n %ld %@",(long)error.code, error.description);
                                                  }
                                              }];
        [downloadTask resume];
    }
}

- (void)dataProcessingWithDictionary:(NSDictionary*)dicJSON isNext:(BOOL)isNext
{
    NSMutableArray *outputItems = [NSMutableArray new];
    
    NSNumber *nTotalPages = [dicJSON objectForKey:@"total_pages"];
    NSArray *aResults = [dicJSON objectForKey:@"results"];
    
    for (NSDictionary* dicMovie in aResults) {
        NSDate *date = [Tools StringToDate:[dicMovie objectForKey:@"release_date"] DateFormat:@"yyyy-MM-dd"];
        DBMovie *iMovie = [[DBMovie alloc] initWithID:[dicMovie objectForKey:@"id"]
                                                Title:[dicMovie objectForKey:@"original_title"]
                                             ImageURL:[dicMovie objectForKey:@"poster_path"]
                                          ReleaseDate:date
                                             Overview:[dicMovie objectForKey:@"overview"]];
        [outputItems addObject:iMovie];
    }
    
    if (self.iDelegate &&
        [self.iDelegate conformsToProtocol:@protocol(HomeListInteractorDelegate)]&&
        [self.iDelegate respondsToSelector:@selector(dataFetchingResults:totalPages:isNext:)])
    {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.iDelegate dataFetchingResults:outputItems totalPages:[nTotalPages floatValue] isNext:isNext];
        });
    }
}



@end
