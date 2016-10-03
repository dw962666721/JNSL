//
//  totalAmountViewController.m
//  JNSL
//
//  Created by wangjiang on 16/10/3.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "totalAmountViewController.h"

@interface totalAmountViewController ()

@end

@implementation totalAmountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imgview = [[UIImageView alloc ] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight-65)];
    imgview.image = [UIImage imageNamed:@"home_bg"];
    [self.view addSubview:imgview];
    [self addorvlView];
    [self addLineView];
    // Do any additional setup after loading the view.
}

-(void)addorvlView{
    rounfView *orvl = [[rounfView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 200)];
    orvl.backgroundColor = [UIColor clearColor];
    [self.view addSubview:orvl];
    
}

-(void)addLineView{
    lineChartView *view = [[lineChartView alloc] initWithFrame:CGRectMake(30, 250, screenWidth-40, 150)];
    view.backgroundColor = [UIColor clearColor];
    NSArray *points = [NSArray arrayWithObjects: [NSValue valueWithCGPoint:CGPointMake(0, 0)], [NSValue valueWithCGPoint:CGPointMake(1, 4.5)],[NSValue valueWithCGPoint:CGPointMake(2, 2)],[NSValue valueWithCGPoint:CGPointMake(3, 6.5)],[NSValue valueWithCGPoint:CGPointMake(4, 8)],[NSValue valueWithCGPoint:CGPointMake(5, 2)],[NSValue valueWithCGPoint:CGPointMake(6, 5)], nil];
    view.arr = points;
    [view setNeedsDisplay];
    [self.view addSubview:view];
    //添加横坐标的标注
    CGFloat hengunit = (screenWidth-40)/6-1;
    CGFloat shuunit = 150/8;
    int initdate = 22;
    for (int i=0; i<7; i++) {
        CGFloat w = hengunit * i;
       int thedate = initdate + i;
        NSString *datestr = [NSString stringWithFormat:@"%d%@",thedate,@"日"];
        UILabel * lb = [[UILabel alloc] initWithFrame:CGRectMake(30-hengunit/2+w, 400, hengunit, 20)];
        lb.font = [UIFont systemFontOfSize:12];
        lb.textAlignment = NSTextAlignmentCenter;
        lb.text = datestr;
        [self.view addSubview:lb];
    }
    //添加竖的标注
    CGFloat initshu = 400-shuunit/2;//默认为400
    for (int i=0; i<9; i++) {
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, initshu-shuunit*i, 30, 15)];
        //lb.backgroundColor = [UIColor redColor];
        lb.font = [UIFont systemFontOfSize:8];
        lb.text = @"0.0007";
        [self.view addSubview:lb];
    }
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
