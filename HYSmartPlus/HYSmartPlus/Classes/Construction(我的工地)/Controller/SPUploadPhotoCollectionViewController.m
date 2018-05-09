//
//  SPUploadPhotoCollectionViewController.m
//  HYSmartPlus
//
//  Created by information on 2018/5/9.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPUploadPhotoCollectionViewController.h"
#import "TZImagePickerController.h"
#import "UIView+Layout.h"
#import "LxGridViewFlowLayout.h"
#import "TZTestCell.h"

@interface SPUploadPhotoCollectionViewController ()<UIActionSheetDelegate,TZImagePickerControllerDelegate,UIAlertViewDelegate> {
    NSMutableArray *_selectedPhotos;
    NSMutableArray *_selectedAssets;
    BOOL _isSelectOriginalPhoto;
    
    CGFloat _itemWH;
    CGFloat _margin;
}
@property (nonatomic, strong)  UIImagePickerController *imagePickerVc;
@property (nonatomic, strong)  LxGridViewFlowLayout *layout;
@property (strong, nonatomic) CLLocation *location;

//配置项

@property (nonatomic, assign) BOOL allowPickingGif;
@property (nonatomic, assign) BOOL showSheet;  //／< 显示一个sheet,把拍照按钮放在外面

@property (nonatomic, assign) NSInteger maxCountTF; ///< 照片最大可选张数，设置为1即为单选模式
@property (nonatomic, assign) NSInteger columnNumberTF;

@property (nonatomic, assign) BOOL sortAscending; // 按照照片时间排序
@property (nonatomic, assign) BOOL allowCrop;
@property (nonatomic, assign) BOOL needCircleCrop;

@property (nonatomic, assign) BOOL allowPickingOriginalPhoto;
@property (nonatomic, assign) BOOL allowPickingMuitlpleVideo;

@end

@implementation SPUploadPhotoCollectionViewController

static NSString * const reuseIdentifier = @"TZTestCell";

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        if (iOS7Later) {
            _imagePickerVc.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
        }
        _imagePickerVc.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (iOS9Later) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    return _imagePickerVc;
}

- (instancetype)init {
    // 如不需要长按排序效果，将LxGridViewFlowLayout类改成UICollectionViewFlowLayout即可
    LxGridViewFlowLayout *layout = [[LxGridViewFlowLayout alloc] init];
    _margin = 4;
    _itemWH = (ScreenW - 2 * _margin - 4) / 3 - _margin;
    layout.itemSize = CGSizeMake(_itemWH, _itemWH);
    layout.minimumInteritemSpacing = _margin;
    layout.minimumLineSpacing = _margin;
    
    return [super initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    // 1.导航栏等初始化
    [self setupNavBar];
    
    // 2.设置collectionView
    [self setupCollectionView];
}

- (void)setupNavBar {
    self.title = @"图片上传";
    
    _selectedPhotos = [NSMutableArray array];
    _selectedAssets = [NSMutableArray array];
    
    _allowPickingGif = NO;
    _showSheet = YES;  //／< 显示一个sheet,把拍照按钮放在外面
    _maxCountTF = 9; ///< 照片最大可选张数，设置为1即为单选模式
    _columnNumberTF = 4;
    _sortAscending = YES;
    _allowCrop = NO;
    _needCircleCrop = NO;
    _allowPickingOriginalPhoto = YES;
    _allowPickingMuitlpleVideo = NO;
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"uploadPhoto"] withHighLightedImage:[UIImage imageNamed:@"uploadPhoto"] target:self action:@selector(uploadPhoto)];
}

- (void)uploadPhoto {
    
}

- (void)setupCollectionView {
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.backgroundColor = RGB(244, 244, 244);
    self.collectionView.contentInset = UIEdgeInsetsMake(4, 4, 4, 4);
    self.collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.collectionView registerClass:[TZTestCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _selectedPhotos.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZTestCell" forIndexPath:indexPath];
    cell.videoImageView.hidden = YES;
    if (indexPath.row == _selectedPhotos.count) {
        cell.imageView.image = [UIImage imageNamed:@"addImage"];
        cell.deleteBtn.hidden = YES;
        cell.gifLable.hidden = YES;
    } else {
        cell.imageView.image = _selectedPhotos[indexPath.row];
        cell.asset = _selectedAssets[indexPath.row];
        cell.deleteBtn.hidden = NO;
    }
    if (!self.allowPickingGif) {
        cell.gifLable.hidden = YES;
    }
    cell.deleteBtn.tag = indexPath.row;
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == _selectedPhotos.count) {
        BOOL showSheet = self.showSheet;
        if (showSheet) {
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"去相册选择", nil];
            [sheet showInView:self.view];
        }else{
            [self pushTZImagePickerController];
        }
    }
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) { // take photo / 去拍照
        [self takePhoto];
    }else if (buttonIndex == 1) {
        [self pushTZImagePickerController];
    }
}

#pragma mark - takePhoto
- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) && iOS7Later) {
        // 无相机权限 做一个友好的提示
        if (iOS8Later) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
            [alert show];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
        if (iOS7Later) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self takePhoto];
                    });
                }
            }];
        } else {
            [self takePhoto];
        }
        // 拍照之前还需要检查相册权限
    } else if ([TZImageManager authorizationStatus] == 2) { // 已被拒绝,没有相册权限,将无法保存拍的照片
        if (iOS8Later) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
            [alert show];
        } else {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
    } else if ([TZImageManager authorizationStatus] == 0) { // 未请求过相册权限
        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
            [self takePhoto];
        }];
    } else {
        [self pushImagePickerController];
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) { // 去设置界面，开启相机访问权限
        if (iOS8Later) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }
    }
}

#pragma mark - pushImagePickerController
// 调用相机
- (void)pushImagePickerController {
    // 提前定位
    __weak typeof(self) weakSelf = self;
    [[TZLocationManager manager] startLocationWithSuccessBlock:^(NSArray<CLLocation *> *locations) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.location = [locations firstObject];
    } failureBlock:^(NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.location = nil;
    }];
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVc.sourceType = sourceType;
        if(iOS8Later) {
            _imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        }
        [self presentViewController:_imagePickerVc animated:YES completion:nil];
    } else {
        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}

#pragma mark - pushTZImagePickerController
- (void)pushTZImagePickerController {
    if (self.maxCountTF <= 0) {
        return;
    }
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:self.maxCountTF columnNumber:self.columnNumberTF delegate:self pushPhotoPickerVc:YES];
    
#pragma mark - 五类个性化设置，这些参数都可以不传，此时会走默认设置
    imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
    
    if (self.maxCountTF > 1) {
        // 1.设置目前已经选中的图片数组
        imagePickerVc.selectedAssets = _selectedAssets; //目前已经选中的图片数组
    }
    imagePickerVc.allowTakePicture = YES; // 在内部显示拍照按钮
    imagePickerVc.allowTakeVideo = NO;   // 在内部显示拍视频按
    imagePickerVc.videoMaximumDuration = 10; // 视频最大拍摄时间
    
    // imagePickerVc.photoWidth = 1000;
    
    // 2. Set the appearance
    // 2. 在这里设置imagePickerVc的外观
    // if (iOS7Later) {
    // imagePickerVc.navigationBar.barTintColor = [UIColor greenColor];
    // }
    // imagePickerVc.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
    // imagePickerVc.oKButtonTitleColorNormal = [UIColor greenColor];
    // imagePickerVc.navigationBar.translucent = NO;
    
    // 3. Set allow picking video & photo & originalPhoto or not
    // 3. 设置是否可以选择视频/图片/原图
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowPickingOriginalPhoto = YES;
    imagePickerVc.allowPickingGif = self.allowPickingGif;
    imagePickerVc.allowPickingMultipleVideo = NO; // 是否可以多选视频
    
    // 4.照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = self.sortAscending;
    
    // 5. 单选模式,maxImagesCount为1时才生效
    imagePickerVc.showSelectBtn = NO;
    imagePickerVc.allowCrop = self.allowCrop;
    imagePickerVc.needCircleCrop = self.needCircleCrop;
    imagePickerVc.needCircleCrop = 100;
    // 设置竖屏下的裁剪尺寸
    NSInteger left = 30;
    NSInteger widthHeight = self.view.tz_width - 2 * left;
    NSInteger top = (self.view.tz_height - widthHeight) / 2;
    imagePickerVc.cropRect = CGRectMake(left, top, widthHeight, widthHeight);
    imagePickerVc.statusBarStyle = UIStatusBarStyleLightContent;
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

@end
