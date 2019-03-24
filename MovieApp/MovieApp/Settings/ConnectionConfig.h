//
//  ConnectionConfig.h
//  MovieApp
//
//  Created by David Adell on 23/3/19.
//  Copyright © 2019 djadell. All rights reserved.
//

#ifndef ConnectionConfig_h
#define ConnectionConfig_h

#import "Reachability.h"

/********************************************/
//MARK: - API Values
/*
 IMPORTANT
 The application must be registered in The Movie Database (TMDb) https://www.themoviedb.org/settings/api
 If you need more information: https://developers.themoviedb.org/3/getting-started/introduction
 */
/********************************************/

#define K_NET_API_SERVER_PROTOCOL   @"https"
#define K_NET_API_SERVER_NAME       @"api.themoviedb.org"
#define K_NET_API_KEY               @"93aea0c77bc168d8bbce3918cefefa45"

#endif /* ConnectionConfig_h */
