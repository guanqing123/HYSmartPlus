//
//  SPH5BrowseViewController.h
//  HYSmartPlus
//
//  Created by information on 2021/3/25.
//  Copyright © 2021 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SPH5BrowseViewController : UIViewController

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) dispatch_block_t h5BrowseVcBlock;

- (instancetype)initWithUrl:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
