//
//  JFPublishViewController.m
//  JustFresh
//
//  Created by hgdq on 2016/12/30.
//  Copyright © 2016年 hgdq. All rights reserved.
//

#import "JFPublishViewController.h"
#import "PYPhotosView.h"
#import "PYPhotosPreviewController.h"
#import "ZLDefine.h"

@interface JFPublishViewController () <PYPhotosViewDelegate>

/** 即将发布的图片存储的photosView */
@property (nonatomic, weak) PYPhotosView *publishPhotosView;
@property (nonatomic,strong) NSMutableArray *imagesArray;
@property (nonatomic, strong) NSArray<ZLSelectPhotoModel *> *lastSelectMoldels;

@end

@implementation JFPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imagesArray = [NSMutableArray array];
    // 初始化
    [self setup];
    
    // 1. 常见一个发布图片时的photosView
    PYPhotosView *publishPhotosView = [PYPhotosView photosView];
    // 2. 添加本地图片
    UIImage *image = [UIImage imageNamed:@"avatar"];
    NSMutableArray *imagesM = [NSMutableArray array];
    for (int i = 0; i < arc4random_uniform(4) + 1; i++) {
        [imagesM addObject:image];
    }
    publishPhotosView.py_x = PYMargin * 5;
    publishPhotosView.py_y = PYMargin * 2 + 64;
    // 2.1 设置本地图片
    publishPhotosView.images = imagesM;
    // 3. 设置代理
    publishPhotosView.delegate = self;
    
    // 4. 添加photosView
    [self.view addSubview:publishPhotosView];
    self.publishPhotosView = publishPhotosView;
    
    // Do any additional setup after loading the view.
}

// 初始化
- (void)setup
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.title = @"发布控制器";
}

// 点击发送
- (void)send
{
    NSLog(@"发送 --- 共有%zd张图片", self.publishPhotosView.images.count);
}

// 点击返回
- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - PYPhotosViewDelegate
- (void)photosView:(PYPhotosView *)photosView didAddImageClickedWithImages:(NSMutableArray *)images
{
    NSLog(@"点击了添加图片按钮 --- 添加前有%zd张图片", images.count);
    
    ZLPhotoActionSheet *actionSheet = [[ZLPhotoActionSheet alloc] init];
    //设置照片最大选择数
    actionSheet.maxSelectCount = 5;
    [actionSheet showPhotoLibraryWithSender:self lastSelectPhotoModels:self.lastSelectMoldels completion:^(NSArray<UIImage *> * _Nonnull selectPhotos, NSArray<ZLSelectPhotoModel *> * _Nonnull selectPhotoModels) {
        JFLog(@"%@", selectPhotos);
        [selectPhotos enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [images addObject:obj];
            [photosView reloadDataWithImages:images];
            NSLog(@"添加图片 --- 添加后有%zd张图片", photosView.images.count);
        }];
    }];
    
    
//    ZLOnePhoto *one = [ZLOnePhoto shareInstance];
//    [one presentPicker:PickerType_Camera photoCut:PhotoCutType_YES target:self callBackBlock:^(UIImage *image, BOOL isCancel) {
//        if (isCancel != YES) {
//            [images addObject:image];
//            [photosView reloadDataWithImages:images];
//            NSLog(@"添加图片 --- 添加后有%zd张图片", photosView.images.count);
//        }
//    }];

    // 在这里做当点击添加图片按钮时，你想做的事。
    // 这里我利用导入的图片，模拟从相册选图片或者拍照。(这里默认最多导入9张，超过时取前九张)
//    for (int i = 0; i < arc4random_uniform(6) + 1; i++) {
//        [images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%02d", arc4random_uniform(9) + 1]]];
//    }
    // 刷新
//    [photosView reloadDataWithImages:images];
//    NSLog(@"添加图片 --- 添加后有%zd张图片", photosView.images.count);
}



// 进入预览图片时调用, 可以在此获得预览控制器，实现对导航栏的自定义
- (void)photosView:(PYPhotosView *)photosView didPreviewImagesWithPreviewControlelr:(PYPhotosPreviewController *)previewControlelr
{
    NSLog(@"进入预览图片");
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
