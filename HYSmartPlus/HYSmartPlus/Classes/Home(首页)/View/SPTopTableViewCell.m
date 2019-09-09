//
//  SPTopTableViewCell.m
//  HYSmartPlus
//
//  Created by information on 2018/6/12.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPTopTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface SPTopTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *topImageView;

@property (weak, nonatomic) IBOutlet UILabel *topTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *topDateLabel;

@property (weak, nonatomic) IBOutlet UIButton *jingpinBtn;

@end

@implementation SPTopTableViewCell

static NSString *SPTopTableViewCellID = @"SPTopTableViewCell";

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    SPTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SPTopTableViewCellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SPTopTableViewCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)setSellActivity:(SPSellActivity *)sellActivity {
    _sellActivity = sellActivity;
    
    [self.topImageView sd_setImageWithURL:[NSURL URLWithString:sellActivity.fileRealPath] placeholderImage:[UIImage imageNamed:@"slide_backgroud_icon"]];
    
    self.topTitleLabel.text = sellActivity.title;
    
    self.topDateLabel.text = sellActivity.createDate;
    
    if (sellActivity.jingpin > 0) {
        self.jingpinBtn.hidden = NO;
    }else{
        self.jingpinBtn.hidden = YES;
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
