//
//  SPUploadPhotoCollectionViewController.h
//  HYSmartPlus
//
//  Created by information on 2018/5/9.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPDropower.h"

@interface SPUploadPhotoCollectionViewController : UICollectionViewController

@property (nonatomic, copy) dispatch_block_t finishPhotoUpload;

@property (nonatomic, strong)  SPDropower *dropower;

@end
