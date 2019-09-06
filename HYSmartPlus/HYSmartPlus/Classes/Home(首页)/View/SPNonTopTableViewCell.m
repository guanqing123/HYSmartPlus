//
//  SPNonTopTableViewCell.m
//  HYSmartPlus
//
//  Created by information on 2018/6/12.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPNonTopTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface SPNonTopTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *nonTopImageView;

@property (weak, nonatomic) IBOutlet UILabel *nonTopTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *nonTopTimeLabel;

@property (weak, nonatomic) IBOutlet UIButton *jingpinBtn;

@end

@implementation SPNonTopTableViewCell

static NSString *SPNonTopTableViewCellID = @"SPNonTopTableViewCell";

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    SPNonTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SPNonTopTableViewCellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SPNonTopTableViewCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)setSellActivity:(SPSellActivity *)sellActivity {
    _sellActivity = sellActivity;
    
    [self.nonTopImageView sd_setImageWithURL:[NSURL URLWithString:sellActivity.fileRealPath] placeholderImage:[UIImage imageNamed:@"slide_backgroud_icon"]];
    
    self.nonTopTitleLabel.text = sellActivity.title;
    
    self.nonTopTimeLabel.text = sellActivity.createDate;
    
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
