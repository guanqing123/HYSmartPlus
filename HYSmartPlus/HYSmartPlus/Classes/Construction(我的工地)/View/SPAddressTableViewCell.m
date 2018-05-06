//
//  SPAddressTableViewCell.m
//  HYSmartPlus
//
//  Created by information on 2018/5/4.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPAddressTableViewCell.h"
#import "SPAddressItem.h"

@interface SPAddressTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *selectFlag;
@end

@implementation SPAddressTableViewCell

#pragma mark - 赋值
- (void)setItem:(SPAddressItem *)item {
    _item = item;
    _addressLabel.text = item.name;
    _addressLabel.textColor = item.isSelected ? [UIColor redColor] : [UIColor blackColor];
    _selectFlag.hidden = !item.isSelected;
}

@end
