//
//  HomeListCell.m
//  MovieApp
//
//  Created by David Adell on 23/3/19.
//  Copyright © 2019 djadell. All rights reserved.
//

#import "HomeListCell.h"
#import "FileManager.h"
#import "Tools.h"

@interface HomeListCell () <FileManagerDelegate>
{
    FileManager *iFileManager;
}

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *iProgressIndicator;
@property (weak, nonatomic) IBOutlet UIImageView *iImagenPicture;
@property (weak, nonatomic) IBOutlet UILabel *iLabelTitle;
@property (weak, nonatomic) IBOutlet UILabel *iLabelDate;
@property (weak, nonatomic) IBOutlet UITextView *iTextViewOverview;

@end

@implementation HomeListCell

- (void)setIMovie:(DBMovie *)aMovie
{
    _iMovie = aMovie;
    [_iLabelTitle setText:_iMovie.iTitle.length ? _iMovie.iTitle : [NSString stringWithFormat:@"%f",(float)[_iMovie.iId floatValue]]];
    [_iLabelDate setText:[Tools getYearWithDate:_iMovie.iReleaseDate].length ? [Tools getYearWithDate:_iMovie.iReleaseDate]:@"--"];
    [_iTextViewOverview setText:_iMovie.iOverview.length ? _iMovie.iOverview:@""];
    
    if (!_iMovie.iDownloadedImage) {
        [_iProgressIndicator setHidden:NO];
        [_iProgressIndicator startAnimating];
        [self getImagePath:_iMovie.iImageURL];
    } else {
        [_iProgressIndicator stopAnimating];
        [_iProgressIndicator setHidden:YES];
        [self setPosterImage];
    }
}

/////TODO: fast Testing, pending to move correct location
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
    dispatch_sync(dispatch_get_main_queue(), ^{
        self.iMovie.iImagePathURL = aLocation;
        self.iMovie.iDownloadedImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:aLocation]];
        [self setPosterImage];
    });
}
////////

- (void)setPosterImage
{
    if (self.iMovie.iDownloadedImage) {
        [self.iImagenPicture setImage:self.iMovie.iDownloadedImage];
        [_iProgressIndicator stopAnimating];
        [_iProgressIndicator setHidden:YES];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
