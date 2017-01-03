//
//  TextViewController.m
//  JustFresh
//
//  Created by hgdq on 2016/12/28.
//  Copyright © 2016年 hgdq. All rights reserved.
//

#import "TextViewController.h"
#import "ZLDefine.h"
#import "JFBaiduMap.h"
#import "JFPay.h"
#import "JFLoginViewController.h"
#import "SGScanningQRCodeVC.h"

@interface TextViewController ()

@property (nonatomic, strong) NSArray<ZLSelectPhotoModel *> *lastSelectMoldels;

@property (nonatomic,strong) NSArray *imagesArray;

@end

@implementation TextViewController
//http://b.app.ydm01.com/ydmappweb/getMerchantListByPhone.do?loginName=18664309864&password=123456
//
//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    [[BaiduMobStat defaultStat] pageviewStartWithName:@"1"];
//}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear: animated];
//    [[BaiduMobStat defaultStat] pageviewEndWithName:@"1"];
    [[JFBaiduMap shareInstance] removeJfMap];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"ceshi";
    
    self.imagesArray = @[@"http://s.image.hnol.net/x/246x0/auto/http://image.hnol.net/c/2016-12/30/11/201612301121168991-4217076.jpg",@"http://s.image.hnol.net/x/246x0/auto/http://image.hnol.net/c/2016-12/30/11/201612301124259861-4217076.jpg",@"http://s.image.hnol.net/x/246x0/auto/http://image.hnol.net/c/2016-12/30/11/201612301130333561-4761447.jpg",@"http://s.image.hnol.net/x/246x0/auto/http://image.hnol.net/c/2016-12/30/11/201612301119552771-4761447.jpg"];
    // Do any additional setup after loading the view.
}

- (IBAction)btnClick:(UIButton *)sender {
    NSInteger btnTag = sender.tag;
    switch (btnTag) {
        case 1:
            [self getData];
            break;
        case 2:
            [self btnSelectPhotoLibrary];
            break;
        case 3:
            [self btnSelectPhotosLibrary];
            break;
        case 4:
            [self btnSelectPhotoCamere];
            break;
        case 5:
            [[JFBaiduMap shareInstance] bmkMapServiceJFMapType:JFMapType_POISearch locationCallBackBlock:^(BMKAddressComponent *result) {
                JFLog(@"定位成功 = %@",result.district);
            } poiKeyword:@"学校" poiSearchCallBackBlock:^(NSArray *poiInfoLists) {
                [poiInfoLists enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    BMKPoiInfo *info = (BMKPoiInfo *)obj;
                    JFLog(@"name = %@",info.name);
                    JFLog(@"address = %@",info.address);
                }];
            }];
            break;
        case 6:
            [JFPay JFPayWithAlipay:nil AlipayCallBack:^(JFPayStatus payStatus,NSDictionary *resultDic) {
                switch (payStatus) {
                    case AlipayStatusSuccess:
                        NSLog(@"AlipayStatusSuccess");
                        break;
                    case AlipayStatusFail:
                        NSLog(@"AlipayStatusFail");
                        break;
                    case AlipayStatusDoing:
                        NSLog(@"AlipayStatusDoing");
                        break;
                    case AlipayStatusCancel:
                        NSLog(@"AlipayStatusCancel");
                        break;
                    case AlipayStatusNetError:
                        NSLog(@"AlipayStatusNetError");
                        break;
                    default:
                        break;
                }
                NSLog(@"支付宝支付结果:resultDic = %@",resultDic);
            }];

            break;
        case 7:
            [JFPay JFPayWithWXPayCallBack:^(JFPayStatus payStatus) {
                JFLog(@"payStatus = %ld",(long)payStatus);
            }];
            break;
        case 8:
            [self readQRCode];
            break;
        case 9:
            [JFLoginViewController login:self loginType:JFLoginType_Root];
            break;
        case 10:
           
            break;
        default:
            break;
    }
    
}
// 测试网络
- (void)getData{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:@"18664309864" forKey:@"loginName"];
    [dic setValue:@"123456" forKey:@"password"];
    
    [JFNetwork getWithURLString:JFURLString(GETMER_TEST) parameters:dic neterror:^{
        [JFMessageManager showToastOnCenterInView:self.view andMessage:@"网络错误！"];
    } netstart:^{
        [self showLoading];
    } success:^(id json) {
        [self dismissLoading];
        JFLog(@"%@",json);
    } fail:^(NSError *error) {
        [self dismissLoading];
        [JFMessageManager showToastOnCenterInView:self.view andMessage:@"网络请求失败！"];
    }];
    
}
// 相册单选
- (void)btnSelectPhotoLibrary{
    ZLOnePhoto *one = [ZLOnePhoto shareInstance];
    [one presentPicker:PickerType_Photo photoCut:PhotoCutType_YES target:self callBackBlock:^(UIImage *image, BOOL isCancel) {
        ;
    }];
}

// 测试相册多选
- (void)btnSelectPhotosLibrary{
    ZLPhotoActionSheet *actionSheet = [[ZLPhotoActionSheet alloc] init];
    //设置照片最大选择数
    actionSheet.maxSelectCount = 5;
    [actionSheet showPhotoLibraryWithSender:self lastSelectPhotoModels:self.lastSelectMoldels completion:^(NSArray<UIImage *> * _Nonnull selectPhotos, NSArray<ZLSelectPhotoModel *> * _Nonnull selectPhotoModels) {
        JFLog(@"%@", selectPhotos);
    }];
}
- (void)btnSelectPhotoCamere{
    ZLOnePhoto *one = [ZLOnePhoto shareInstance];
    [one presentPicker:PickerType_Camera photoCut:PhotoCutType_YES target:self callBackBlock:^(UIImage *image, BOOL isCancel) {
        ;
    }];
}
- (void)readQRCode {
    SGScanningQRCodeVC *scanningQRCodeVC = [[SGScanningQRCodeVC alloc] init];
    [self.navigationController pushViewController:scanningQRCodeVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
     [[NSNotificationCenter defaultCenter] postNotificationName:@"badgeValue" object:nil];
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

