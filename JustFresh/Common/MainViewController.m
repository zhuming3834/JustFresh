//
//  MainViewController.m
//  JustFresh
//
//  Created by hgdq on 2016/12/27.
//  Copyright © 2016年 hgdq. All rights reserved.
//

#import "MainViewController.h"
#include "HomeViewController.h"
#include "ClassViewController.h"
#include "FindViewController.h"
#include "ShoppingCarViewController.h"
#include "MeViewController.h"

@interface MainViewController () <UITabBarControllerDelegate>

@property (nonatomic,strong)UINavigationController *homeNavController;
@property (nonatomic,strong)UINavigationController *classNavController;
@property (nonatomic,strong)UINavigationController *findNavController;
@property (nonatomic,strong)UINavigationController *shoppingCarNavController;
@property (nonatomic,strong)UINavigationController *meNavController;




@end

@implementation MainViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadViewControllers];
    self.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeBadgeValue) name:@"badgeValue" object:nil];
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)loadViewControllers {
    UIImage *image = [[UIImage imageNamed:@"tabbar_ic_found_prs"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *imageSelect = [[UIImage imageNamed:@"tabbar_ic_found"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    HomeViewController *homeViewController = [[HomeViewController alloc] init];
    self.homeNavController = [[UINavigationController alloc] initWithRootViewController:homeViewController];
    self.homeNavController.tabBarItem.title = @"首页";
    self.homeNavController.tabBarItem.image =  image;
    self.homeNavController.tabBarItem.selectedImage = imageSelect;
    self.homeNavController.tabBarItem.tag = 0;
    self.homeNavController.tabBarItem.badgeValue = @"1";
    
    ClassViewController *classViewController = [[ClassViewController alloc] init];
    self.classNavController = [[UINavigationController alloc] initWithRootViewController:classViewController];
    self.classNavController.tabBarItem.title = @"分类";
    self.classNavController.tabBarItem.tag = 1;
    self.classNavController.tabBarItem.image =  image;
    self.classNavController.tabBarItem.selectedImage = imageSelect;
    
    FindViewController *findViewController = [[FindViewController alloc] init];
    self.findNavController = [[UINavigationController alloc] initWithRootViewController:findViewController];
    self.findNavController.tabBarItem.title = @"发现";
    self.findNavController.tabBarItem.tag = 2;
    self.findNavController.tabBarItem.image =  image;
    self.findNavController.tabBarItem.selectedImage = imageSelect;
    
    
    ShoppingCarViewController *shoppingCarViewController = [[ShoppingCarViewController alloc] init];
    self.shoppingCarNavController = [[UINavigationController alloc] initWithRootViewController:shoppingCarViewController];
    self.shoppingCarNavController.tabBarItem.title = @"购物车";
    self.shoppingCarNavController.tabBarItem.tag = 3;
    self.shoppingCarNavController.tabBarItem.image =  image;
    self.shoppingCarNavController.tabBarItem.selectedImage = imageSelect;
    
    MeViewController *meViewController = [[MeViewController alloc] init];
    self.meNavController = [[UINavigationController alloc] initWithRootViewController:meViewController];
    self.meNavController.tabBarItem.title = @"我的";
    self.meNavController.tabBarItem.tag = 4;
    self.meNavController.tabBarItem.image =  image;
    self.meNavController.tabBarItem.selectedImage = imageSelect;
    
    NSArray *viewControllerArray = @[self.homeNavController,self.classNavController,self.findNavController,self.shoppingCarNavController,self.meNavController];
    
    self.viewControllers = viewControllerArray;
    
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    JFLog(@"222");
}

- (void)changeBadgeValue {
    self.meNavController.tabBarItem.badgeValue = @"2";
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
