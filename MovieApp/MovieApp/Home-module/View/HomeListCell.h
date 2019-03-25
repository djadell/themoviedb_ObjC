//
//  HomeListCell.h
//  MovieApp
//
//  Created by David Adell on 23/3/19.
//  Copyright © 2019 djadell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewsConfig.h"
#import "DBMovie.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeListCell : UITableViewCell

@property (strong,nonatomic) DBMovie *iMovie;

@end

NS_ASSUME_NONNULL_END
