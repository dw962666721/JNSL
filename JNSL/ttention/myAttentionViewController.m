//
//  myAttentionViewController.m
//  JNSL
//
//  Created by wangjiang on 16/10/1.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "myAttentionViewController.h"

@interface myAttentionViewController ()
 @property  UICollectionView *cillection;
@end

@implementation myAttentionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat screenwid = [UIScreen mainScreen].bounds.size.width;
    //设置背景图片
    UIColor *bgColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
                        [self.view setBackgroundColor:bgColor];
    UICollectionViewFlowLayout * customLayout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为垂直流布局
    customLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //设置每个item的大小为100*100
    customLayout.itemSize = CGSizeMake((screenwid-60)/3, (screenwid-60)/3);
    
     self.cillection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, screenwid, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:customLayout];
    [self.cillection registerClass:[attentionCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    self.cillection.dataSource = self;
    self.cillection.delegate = self;
    self.cillection.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.cillection];
    // Do any additional setup after loading the view.
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    switch (indexPath.row) {
        case 0:
            
             self.totalAmount = [[totalAmountViewController alloc] init];
            
            [self.navigationController pushViewController:self.totalAmount animated:true];
            
            break;
        case 1:
            
            
                self.excessiveWarinng = [[excessiveWarinngViewController alloc] init];
            
            [self.navigationController pushViewController:self.excessiveWarinng animated:true];
            break;
        case 2:
            
            
                self.unusualReport = [[unusualReportViewController alloc] init];
            
            [self.navigationController pushViewController:self.unusualReport animated:true];
            break;
        case 3:
            
            
                self.overproofReport = [[overproofReportViewController alloc] init];
            
            [self.navigationController pushViewController:self.overproofReport animated:true];
            break;
        case 4:
            
            
                self.realtime = [[realtimeViewController alloc] init];
            
            [self.navigationController pushViewController:self.realtime animated:true];
            break;
        case 5:
            self.realTechnologo = [[realTechnologoViewController alloc] init];
            
            [self.navigationController pushViewController:self.realTechnologo animated:true];
            break;
        
            
        default:
            break;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    attentionCollectionViewCell *cell = [self.cillection dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (cell) {
        switch (indexPath.row) {
            case 0:
                cell.img.image = [UIImage imageNamed:@"chaobiaobaogao"];
                break;
            case 1:
                cell.img.image = [UIImage imageNamed:@"chaobiaoyujing"];
                break;
            case 2:
                cell.img.image = [UIImage imageNamed:@"shishibaojing"];
                break;
            case 3:
                cell.img.image = [UIImage imageNamed:@"shishigongyitu"];
                break;
            case 4:
                cell.img.image = [UIImage imageNamed:@"yichangbaogao"];
                break;
            case 5:
                cell.img.image = [UIImage imageNamed:@"zongliangjiankong"];
                break;
                
            default:
                break;
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
    return UIEdgeInsetsMake(30, 10, 20, 10);
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
