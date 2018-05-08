//
//  SPMiddleCollectionViewCell.m
//  HYSmartPlus
//
//  Created by information on 2018/5/8.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPMiddleCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface  SPMiddleCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation SPMiddleCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setDropowerDetail:(SPDropowerDetail *)dropowerDetail {
    _dropowerDetail = dropowerDetail;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:dropowerDetail.fileRealPath] placeholderImage:nil];
}

@end
