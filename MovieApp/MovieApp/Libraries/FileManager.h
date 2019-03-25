//
//  FileManager.h
//  MovieApp
//
//  Created by David Adell on 25/3/19.
//  Copyright © 2019 djadell. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FileManagerDelegate <NSObject>
@required

@optional
- (void)setImagenPath:(NSURL*)aImagenPath;
@end


NS_ASSUME_NONNULL_BEGIN

@interface FileManager : NSObject

@property (nonatomic, assign) id<FileManagerDelegate> iDelegate;

- (void)getImagePath:(NSString*)aImagenURL;

@end

NS_ASSUME_NONNULL_END
