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
    }else{
        logintype = @"1";
    }
    [self.cillection reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([userInfoJNSL.userId  isEqual: @""]|| userInfoJNSL.userId == nil) {
        logintype = @"0";
    }else{
        logintype = @"1";
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    if ([logintype  isEqual: @"1"]) {
        switch (indexPath.row) {
            case 0:
                self.totalAmount = [[totalAmountViewController alloc] init];
                
                [self.navigationController pushViewController:self.totalAmount animated:YES];
                
                break;
            case 1:
                self.excessiveWarinng = [[excessiveWarinngViewController alloc] init];
                
                [self.navigationController pushViewController:self.excessiveWarinng animated:YES];
                break;
            case 2:
                self.unusualReport = [[unusualReportViewController alloc] init];
                
                [self.navigationController pushViewController:self.unusualReport animated:YES];
                break;
            case 3:
                self.overproofReport = [[overproofReportViewController alloc] init];
                
                [self.navigationController pushViewController:self.overproofReport animated:YES];
                break;
            case 4:
                
                self.realtime = [[realtimeViewController alloc] init];
                
                [self.navigationController pushViewController:self.realtime animated:YES];
                break;
            case 5:
                self.realTechnologo = [[realTechnologoViewController alloc] init];
                
                [self.navigationController pushViewController:self.realTechnologo animated:YES];
                break;
            default:
                break;
        }
    }else{
        [MBProgressHUD showError:@"请先登录,您没有权限"];
    }
   
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([logintype  isEqual: @"1"]) {
         return 6;
    }else{
        return 3;
    }
   
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    attentionCollectionViewCell *cell = [self.cillection dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (cell) {
        if ([logintype  isEqual: @"1"]) {
            switch (indexPath.row) {
                case 0:
                    cell.img.image = [UIImage imageNamed:@"zongliangjiankong"];
                    break;
                case 1:
                    cell.img.image = [UIImage imageNamed:@"chaobiaoyujing"];
                    break;
                case 2:
                    cell.img.image = [UIImage imageNamed:@"yichangbaogao"];
                    break;
                case 3:
                    cell.img.image = [UIImage imageNamed:@"chaobiaobaogao"];
                    break;
                case 4:
                    cell.img.image = [UIImage imageNamed:@"shishibaojing"];
                    break;
                case 5:
                    cell.img.image = [UIImage imageNamed:@"shishigongyitu"];
                    break;
                    
                default:
                    break;
            }
        }else{
            switch (indexPath.row) {
                case 0:
                    cell.img.image = [UIImage imageNamed:@"zongliangjiankong"];
                    break;
                case 1:
                    cell.img.image = [UIImage imageNamed:@"chaobiaobaogao"];
                    break;
                case 2:
                    cell.img.image = [UIImage imageNamed:@"shishibaojing"];
                    break;
                default:
                    break;
            }
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
