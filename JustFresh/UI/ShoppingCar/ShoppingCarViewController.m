//
//  ShoppingCarViewController.m
//  JustFresh
//
//  Created by hgdq on 2016/12/27.
//  Copyright © 2016年 hgdq. All rights reserved.
//

#import "ShoppingCarViewController.h"
#import "JFSPTableViewCell.h"
#import "PurchaseCarAnimationTool.h"


@interface ShoppingCarViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign)NSInteger count;

@end

@implementation ShoppingCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];

    [self setTableView];
    
    // Do any additional setup after loading the view.
}
- (void)setTableView {
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerNib:[UINib nibWithNibName:@"JFSPTableViewCell" bundle:nil] forCellReuseIdentifier:@"JFSPTableViewCell"];
    [self.view addSubview:tableView];
}

#pragma mark -- Delegate and DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JFSPTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"JFSPTableViewCell"];
    
    cell.clickCars = ^(UIImageView *imageView){
        _count ++ ;
        CGRect rect = [tableView rectForRowAtIndexPath:indexPath];
        //获取当前cell 相对于self.view 当前的坐标
        rect.origin.y = rect.origin.y - [tableView contentOffset].y;
        CGRect imageViewRect = imageView.frame;
        imageViewRect.origin.y = rect.origin.y+imageViewRect.origin.y;
        [[PurchaseCarAnimationTool shareTool]startAnimationandView:imageView andRect:imageViewRect andFinisnRect:CGPointMake(ScreenWidth/4*2.5, ScreenHeight-49) andFinishBlock:^(BOOL finisn){
            
            UIView *tabbarBtn = self.tabBarController.tabBar.subviews[4];
            [PurchaseCarAnimationTool shakeAnimation:tabbarBtn];
            self.navigationController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld",(long)_count];
        }];
        
    };
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 114;
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
