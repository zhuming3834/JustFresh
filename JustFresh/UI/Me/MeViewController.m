//
//  MeViewController.m
//  JustFresh
//
//  Created by hgdq on 2016/12/27.
//  Copyright © 2016年 hgdq. All rights reserved.
//

#import "MeViewController.h"
#import "PYPhotosView.h"
#import "PYPhotoBrowseView.h"
#import "JFPublishViewController.h"

@interface MeViewController ()

@property (nonatomic,strong) NSArray *thumbnailImageUrls;

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    
    
    self.thumbnailImageUrls = @[@"http://s.image.hnol.net/x/246x0/auto/http://image.hnol.net/c/2016-12/30/11/201612301121168991-4217076.jpg",@"http://s.image.hnol.net/x/246x0/auto/http://image.hnol.net/c/2016-12/30/11/201612301124259861-4217076.jpg",@"http://s.image.hnol.net/x/246x0/auto/http://image.hnol.net/c/2016-12/30/11/201612301130333561-4761447.jpg",@"http://s.image.hnol.net/x/246x0/auto/http://image.hnol.net/c/2016-12/30/11/201612301119552771-4761447.jpg",@"http://m.xxxiao.com/wp-content/uploads/sites/3/2016/12/m.xxxiao.com_48711944b071f6fa6528eff02707cf41-683x1024.jpg",@"http://m.xxxiao.com/wp-content/uploads/sites/3/2016/12/m.xxxiao.com_332cc6ed745a465fbca2373f26fcd646-683x1024.jpg",@"http://m.xxxiao.com/wp-content/uploads/sites/3/2016/12/m.xxxiao.com_40bb1fbda8bd5f19743e6c78eb9a5245-683x1024.jpg"];
    

    // 2.1 创建一个流水布局photosView(默认为流水布局)
    PYPhotosView *flowPhotosView = [PYPhotosView photosView];
    // 设置缩略图数组
    flowPhotosView.thumbnailUrls = self.thumbnailImageUrls;
    // 设置原图地址
    flowPhotosView.originalUrls = self.thumbnailImageUrls;
    // 设置分页指示类型
    flowPhotosView.pageType = PYPhotosViewPageTypeLabel;
    flowPhotosView.py_centerX = self.view.py_centerX;
    flowPhotosView.py_y = 20 + 64;
    
    // 2.2创建线性布局
    PYPhotosView *linePhotosView = [PYPhotosView photosViewWithThumbnailUrls:self.thumbnailImageUrls originalUrls:self.thumbnailImageUrls layoutType:PYPhotosViewLayoutTypeLine];
    // 设置Frame
    linePhotosView.py_y = CGRectGetMaxY(flowPhotosView.frame) + PYMargin * 2;
    linePhotosView.py_x = PYMargin;
    linePhotosView.py_width = self.view.py_width - linePhotosView.py_x * 2;
    
    // 3. 添加到指定视图中
    [self.view addSubview:flowPhotosView];
    [self.view addSubview:linePhotosView];
    
    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake(100, 400, 100, 44);
    button.backgroundColor = [UIColor blueColor];
    [button setTitle:@"发布" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(publishDidCicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    // Do any additional setup after loading the view.
}

#pragma mark publishDidCicked
// 点击发布时调用
- (void)publishDidCicked
{
    JFPublishViewController *publishVc = [[JFPublishViewController alloc] init];
    publishVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:publishVc animated:YES];
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
