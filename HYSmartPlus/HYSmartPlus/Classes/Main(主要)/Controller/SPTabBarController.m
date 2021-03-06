//
//  SPTabBarController.m
//  HYSmartPlus
//
//  Created by information on 2017/9/11.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "SPTabBarController.h"
#import "SPNavigationController.h"
#import "SPTabBar.h"
#import "AFNetworking.h"

@interface SPTabBarController ()<UITabBarControllerDelegate>

@end

@implementation SPTabBarController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /*
    2021.3.23
    if (@available(iOS 13.0,*)) {} else{
        self.delegate = self;
    }
    */
    
    [self setUpTabBar];
    
    [self addSpChildViewController];
}

#pragma mark - 更换系统tabbar
- (void)setUpTabBar {
    /*
     2021.3.23
    if (@available(iOS 13.0,*)) {}else{
        SPTabBar *tabBar = [[SPTabBar alloc] init];
        tabBar.backgroundColor = [UIColor whiteColor];
        //KVC把系统换成自定义
        [self setValue:tabBar forKey:@"tabBar"];
    }*/
    
    if (@available(iOS 13.0, *)) {
        // iOS 13以上
        self.tabBar.tintColor = RGB(20, 200, 197);
        self.tabBar.unselectedItemTintColor = RGB(168, 168, 168);
        UITabBarItem *item = [UITabBarItem appearance];
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:RGB(168, 168, 168),NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:RGB(20, 200, 197),NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    } else {
          [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:RGB(168, 168, 168),NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:RGB(20, 200, 197),NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    }
}

#pragma mark - 添加子控制器
- (void)addSpChildViewController {
    NSArray *childArray = @[
                            @{MallClassKey  : @"SPNewIndexViewController",
                              MallTitleKey  : @"首页",
                              MallImgKey    : @"tabr_1_up",
                              MallSelImgKey : @"tabr_1_down"},
                            
                            @{MallClassKey  : @"SPDesignViewController",
                              MallTitleKey  : @"设计",
                              MallImgKey    : @"tabr_2_up",
                              MallSelImgKey : @"tabr_2_down"},
                            
                            @{MallClassKey  : @"SPServiceViewController",
                              MallTitleKey  : @"服务",
                              MallImgKey    : @"tabr_3_up",
                              MallSelImgKey : @"tabr_3_down"},
                            
                            @{MallClassKey  : @"SPHyShopViewController",
                              MallTitleKey  : @"鸿雁商城",
                              MallImgKey    : @"tabr_4_up",
                              MallSelImgKey : @"tabr_4_down"},
                            
                            @{MallClassKey  : @"SPPersonalCenterViewController",
                              MallTitleKey  : @"我的",
                              MallImgKey    : @"tabr_5_up",
                              MallSelImgKey : @"tabr_5_down"},
                            
                            ];
    [childArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        UIViewController *vc = [NSClassFromString(dict[MallClassKey]) new];
        vc.navigationItem.title = dict[MallTitleKey];
        
        SPNavigationController *nav = [[SPNavigationController alloc] initWithRootViewController:vc];
        UITabBarItem *item = nav.tabBarItem;
        
        item.title = dict[MallTitleKey];
        item.image = [UIImage imageNamed:dict[MallImgKey]];
        item.selectedImage = [[UIImage imageNamed:dict[MallSelImgKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //item.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0); // (当只有图片的时候) 需要自动调整
        [self addChildViewController:nav];
    }];
}

#pragma mark - <UITabBarControllerDelegate>
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    //点击tabBarItem动画
    [self tabBarButtonClick:[self getTabBarButton]];
}

- (UIControl *)getTabBarButton{
    NSMutableArray *tabBarButtons = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]){
            [tabBarButtons addObject:tabBarButton];
        }
    }
    UIControl *tabBarButton = [tabBarButtons objectAtIndex:self.selectedIndex];
    
    return tabBarButton;
}

#pragma mark - 点击动画
- (void)tabBarButtonClick:(UIControl *)tabBarButton {
    
    for (UIView *imageView in tabBarButton.subviews) {
        if ([imageView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
            //需要实现的帧动画,这里根据自己需求改动
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
            animation.keyPath = @"transform.scale";
            animation.values = @[@1.0,@1.1,@0.9,@1.0];
            animation.duration = 0.3;
            animation.calculationMode = kCAAnimationCubic;
            //添加动画
            [imageView.layer addAnimation:animation forKey:nil];
        }
    }
}

#pragma mark - 禁止屏幕旋转
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;//只支持这一个方向(正常的方向)
}
@end
