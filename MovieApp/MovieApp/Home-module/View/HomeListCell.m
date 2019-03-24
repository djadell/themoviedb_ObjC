//
//  HomeListCell.m
//  MovieApp
//
//  Created by David Adell on 23/3/19.
//  Copyright © 2019 djadell. All rights reserved.
//

#import "HomeListCell.h"
#import "Tools.h"

@interface HomeListCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iImagenPicture;
@property (weak, nonatomic) IBOutlet UILabel *iLabelTitle;
@property (weak, nonatomic) IBOutlet UILabel *iLabelDate;
@property (weak, nonatomic) IBOutlet UITextView *iTextViewOverview;

@end

@implementation HomeListCell

- (void)setIMovie:(DBMovie *)iMovie
{
    [_iLabelTitle setText:iMovie.iTitle.length ? iMovie.iTitle : iMovie.iId];
    [_iLabelDate setText:[Tools getYearWithDate:iMovie.iDate].length ? [Tools getYearWithDate:iMovie.iDate]:@"--"];
    [_iTextViewOverview setText:iMovie.iOverview.length ? iMovie.iOverview:@""];
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
