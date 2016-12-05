//
//  myAttentionViewController.m
//  JNSL
//
//  Created by wangjiang on 16/10/1.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "myAttentionViewController.h"

@interface myAttentionViewController ()
{
    NSString *logintype;
}
@property  UICollectionView *cillection;

@end

@implementation myAttentionViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refresuserdata];
    //[self.navigationController setNavigationBarHidden:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //    [self.navigationController setNavigationBarHidden:NO];
}

-(void)refresuserdata{
    if (userInfoJNSL.userId == nil || [userInfoJNSL.userId  isEqual: @""]) {
        NSLog(@"weidenglu");
        logintype = @"0";
        self.dataarr = [[NSMutableArray alloc] init];
        [self.dataarr addObject:[NSDictionary dictionaryWithObject:@"gn_0003" forKey:@"afr_id"]];
        [self.dataarr addObject:[NSDictionary dictionaryWithObject:@"gn_0004" forKey:@"afr_id"]];
        [self.dataarr addObject:[NSDictionary dictionaryWithObject:@"gn_0010" forKey:@"afr_id"]];
        [self.cillection reloadData];
    }else{
        logintype = @"1";
        //下载权限
        [self getuserProvide:userInfoJNSL.userId];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataarr = [[NSMutableArray alloc] init];
    
    if ([userInfoJNSL.userId  isEqual: @""]|| userInfoJNSL.userId == nil) {
        logintype = @"0";
    }else{
        logintype = @"1";
        //下载权限
        [self getuserProvide:userInfoJNSL.userId];
        
    }
    
    CGFloat screenwid = [UIScreen mainScreen].bounds.size.width;
    //设置背景图片
    UIColor *bgColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    [self.view setBackgroundColor:bgColor];
    UICollectionViewFlowLayout * customLayout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为垂直流布局
    customLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //设置每个item的大小为100*100
    if (IPHONE6||IPHONE6PLUS) {
        customLayout.itemSize = CGSizeMake((screenwid-150)/3, (screenwid-150)/3);
    }
    else
    {
        customLayout.itemSize = CGSizeMake((screenwid-120)/3, (screenwid-120)/3);
    }
    
    self.cillection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, screenwid, screenHeight-65) collectionViewLayout:customLayout];
    [self.cillection registerClass:[attentionCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    self.cillection.dataSource = self;
    self.cillection.delegate = self;
    self.cillection.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.cillection];
    // Do any additional setup after loading the view.
}

-(void)getuserProvide:(NSString *)userid{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    dict[@"userId"] = userid;
    [AFNetworkTool postJSONWithUrl:[NSString stringWithFormat:@"%@%@",userInfoJNSL.ip,gongnengquanxianURL] parameters:dict success:^(id responseObject) {
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSString *result = [json objectForKey:@"resultCode"];
        if ([result isEqual:@"true"]) {
            NSDictionary* resultdic = [json objectForKey:@"resultEntity"];
            
            NSMutableArray *resultEntityArray = [[NSMutableArray alloc] initWithArray:resultdic[@"function"]];
            if (resultEntityArray.count>0) {
                NSArray *resultArray = resultEntityArray;
                self.dataarr = [[NSMutableArray alloc] initWithArray:resultArray];
                [self.cillection reloadData];
            }
        }
        
    } fail:^{
        
    }];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    NSDictionary *dic = self.dataarr[indexPath.row];
    NSString *ID = dic[@"afr_id"];
    if([ID  isEqual: @"gn_0009"]){
        self.overproofReport = [[overproofReportViewController alloc] init];
        [self.navigationController pushViewController:self.overproofReport animated:YES];
    }
    if([ID  isEqual: @"gn_0011"]){
        self.realTechnologo = [[realTechnologoViewController alloc] init];
        [self.navigationController pushViewController:self.realTechnologo animated:YES];
    }
    if([ID  isEqual: @"gn_0010"]){
        self.realtime = [[realtimeViewController alloc] init];
        [self.navigationController pushViewController:self.realtime animated:YES];
    }
    if([ID  isEqual: @"gn_0001"]){
        self.productionReport = [[ProductionReportViewController alloc] init];
        [self.navigationController pushViewController:self.productionReport animated:YES];
    }
    if([ID  isEqual: @"gn_0003"]){
        self.totalAmount = [[totalAmountViewController alloc] init];
        [self.navigationController pushViewController:self.totalAmount animated:YES];
    }
    if([ID  isEqual: @"gn_0004"]){
        self.excessiveWarinng = [[excessiveWarinngViewController alloc] init];
        [self.navigationController pushViewController:self.excessiveWarinng animated:YES];
    }
    if([ID  isEqual: @"gn_0008"]){
        self.unusualReport = [[unusualReportViewController alloc] init];
        [self.navigationController pushViewController:self.unusualReport animated:YES];
    }
    
    
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataarr.count;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    attentionCollectionViewCell *cell = [self.cillection dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (cell) {
        NSDictionary *dic = self.dataarr[indexPath.row];
        NSString *ID = dic[@"afr_id"];
        if([ID  isEqual: @"gn_0009"]){
            cell.img.image = [UIImage imageNamed:@"chaobiaobaogao"];
        }
        if([ID  isEqual: @"gn_0011"]){
            cell.img.image = [UIImage imageNamed:@"shishigongyitu"];
        }
        if([ID  isEqual: @"gn_0010"]){
            cell.img.image = [UIImage imageNamed:@"shishibaojing"];
        }
        if([ID  isEqual: @"gn_0001"]){
            cell.img.image = [UIImage imageNamed:@"shengchanbaobiao"];
        }
        if([ID  isEqual: @"gn_0003"]){
            cell.img.image = [UIImage imageNamed:@"zongliangjiankong"];
        }
        if([ID  isEqual: @"gn_0004"]){
            cell.img.image = [UIImage imageNamed:@"chaobiaoyujing"];
        }
        if([ID  isEqual: @"gn_0008"]){
            cell.img.image = [UIImage imageNamed:@"yichangbaogao"];
        }
    }
    
    return cell;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//cell的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 30;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(30, 30, 20, 30);
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
