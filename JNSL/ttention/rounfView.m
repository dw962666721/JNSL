//
//  rounfView.m
//  ImageCorner
//
//  Created by zw on 16/3/22.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "rounfView.h"


#define   kDegreesToRadians(degrees)  ((pi * degrees)/ 180)

@implementation rounfView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.haifrac = 0;
        [self addAttr];
        
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    CGPoint centerpoint = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    CGFloat radius = self.frame.size.height/2-30;//半径 减去30是因为留地方放字
    UIBezierPath*  aPath = [UIBezierPath bezierPathWithArcCenter:centerpoint radius:radius startAngle:DEGREES_TO_RADIANS(270) endAngle:DEGREES_TO_RADIANS(self.haifrac) clockwise:YES];
    [aPath addLineToPoint:centerpoint];
    [aPath closePath];
    [ColorWithRGB(0xa7d393) setFill];
    [ColorWithRGB(0xa7d393) setStroke];
    [aPath stroke];
    [aPath fill];
    [self addPartQurl];//画中心圆
}

-(void)addPartQurl{
    CGPoint centerpoint = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    CGFloat radius = self.frame.size.height/2-50;//半径
    UIBezierPath*  aPath = [UIBezierPath bezierPathWithArcCenter:centerpoint radius:radius startAngle:0 endAngle:DEGREES_TO_RADIANS(360) clockwise:YES];
    [aPath addLineToPoint:centerpoint];
    [aPath closePath];
    [ColorWithRGB(0x1b82f3) setFill];
    [ColorWithRGB(0x1b82f3) setStroke];
    [aPath stroke];
    [aPath fill];
    
}

-(void)addAttr{
    CGFloat threepointX = (self.frame.size.width/2)+(self.frame.size.height/2-30);
    CGFloat threepointY = self.frame.size.height/2 - 15;
    UILabel *threeMonth = [[UILabel alloc] initWithFrame:CGRectMake(threepointX, threepointY, 60, 30)];
    UILabel *sixMonth = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height-30, self.frame.size.width, 30)];
    sixMonth.textAlignment = NSTextAlignmentCenter;
    CGFloat ninepointwidth = (self.frame.size.width/2)-(self.frame.size.height/2-30);
    CGFloat ninepointY = self.frame.size.height/2 - 15;
    UILabel *nineMonth = [[UILabel alloc] initWithFrame:CGRectMake(0, ninepointY, ninepointwidth, 30)];
    nineMonth.textAlignment = NSTextAlignmentRight;
    UILabel *twleMonth = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
    twleMonth.textAlignment = NSTextAlignmentCenter;
    [self addSubview:threeMonth];[self addSubview:sixMonth];
    [self addSubview:nineMonth];[self addSubview:twleMonth];
    threeMonth.text = @"3月";
    sixMonth.text = @"6月";
    nineMonth.text = @"9月";
    twleMonth.text = @"12月";
    threeMonth.font = [UIFont systemFontOfSize:10];
    sixMonth.font = [UIFont systemFontOfSize:10];
    nineMonth.font = [UIFont systemFontOfSize:10];
    twleMonth.font = [UIFont systemFontOfSize:10];
    [self addmes];
}

-(void)addmes{
    self.lb1 = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width/2)-(self.frame.size.height/2-50), self.frame.size.height/2+25, self.frame.size.height-100, self.frame.size.height/2-140)];
    self.lb2 = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width/2)-(self.frame.size.height/2-50), self.frame.size.height/2+40, self.frame.size.height-100, self.frame.size.height/2-140)];
    self.lb3 = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width/2)-(self.frame.size.height/2-50), self.frame.size.height/2+55, self.frame.size.height-100, self.frame.size.height/2-140)];
    self.lb4 = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width/2)-(self.frame.size.height/2-50), self.frame.size.height/2+70, self.frame.size.height-100, self.frame.size.height/2-140)];
    
    self.lb1.font = [UIFont systemFontOfSize:9];
    self.lb2.font = [UIFont systemFontOfSize:9];
    self.lb3.font = [UIFont systemFontOfSize:9];
    self.lb4.font = [UIFont systemFontOfSize:9];
    
    self.lb1.textColor = [UIColor whiteColor];
    self.lb2.textColor = [UIColor whiteColor];
    self.lb3.textColor = [UIColor whiteColor];
    self.lb4.textColor = [UIColor whiteColor];
    
    self.lb1.textAlignment = NSTextAlignmentCenter;
    self.lb2.textAlignment = NSTextAlignmentCenter;
    self.lb3.textAlignment = NSTextAlignmentCenter;
    self.lb4.textAlignment = NSTextAlignmentCenter;
    
    self.lb1.text = @"";
    self.lb2.text = @"";
    self.lb3.text = @"";
    self.lb4.text = @"";
    [self addSubview:self.lb1];
    [self addSubview:self.lb2];
    [self addSubview:self.lb3];
    [self addSubview:self.lb4];
    [self addImg];
}

-(void)addImg{
    self.img = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width/2-20, self.frame.size.height/2-2, 100, 3)];
    self.img.layer.shouldRasterize = YES ;
    self.img.backgroundColor = ColorWithRGB(0x31e5ff);
    //self.img.image = [UIImage imageNamed:@"zhinanzhen"];
    [self addSubview:self.img];
    //旋转图片
    //img.layer.anchorPoint = CGPointMake(0.7, 0.5);
    [self setAnchorPoint:CGPointMake(0.2, 0.5) forView:self.img];
    
//    [UIView animateWithDuration:1.0 animations:^{
//        self.img.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(340));
//    }];
    
    //添加原点
    CGPoint centerpoint = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    UIView *yaundianview = [[UIView alloc] initWithFrame:CGRectMake(centerpoint.x, centerpoint.y, 10, 10)];
    yaundianview.layer.masksToBounds = true;
    yaundianview.layer.cornerRadius = 10;
    yaundianview.backgroundColor = ColorWithRGB(0x03ff00);
    [self addSubview:yaundianview];
    yaundianview.center = centerpoint;
}

- (void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view
{
    CGPoint oldOrigin = view.frame.origin;
    view.layer.anchorPoint = anchorPoint;
    CGPoint newOrigin = view.frame.origin;
    
    CGPoint transition;
    transition.x = newOrigin.x - oldOrigin.x;
    transition.y = newOrigin.y - oldOrigin.y;
    
    view.center = CGPointMake (view.center.x - transition.x, view.center.y - transition.y);
}

-(int)getjidu{
    NSDate *currentdate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:currentdate];
    NSInteger month=[components month];
    NSLog(@"month");
    NSLog([[NSString alloc] initWithFormat:@"%d",month]);
    switch (month) {
        case 1:
            return 1;
            break;
        case 2:
            return 1;
            break;
        case 3:
            return 1;
            break;
        case 4:
            return 2;
            break;
        case 5:
            return 2;
            break;
        case 6:
            return 2;
            break;
        case 7:
            return 3;
            break;
        case 8:
            return 3;
            break;
        case 9:
            return 3;
            break;
        case 10:
            return 4;
            break;
        case 11:
            return 4;
            break;
        case 12:
            return 4;
            break;
        default:
            return 1;
            break;
    }
}

-(void)setText:(NSDictionary *)data{
    NSString *num1 = [data objectForKey:@"num"];
    NSString *num2 = [data objectForKey:@"warning"];
    NSString *num3 = [data objectForKey:@"total"];
    NSString *num4 = [data objectForKey:@"surplus"];
    
    self.lb1.text = [[NSString alloc] initWithFormat:@"%@%@",@"当前排放量",[data objectForKey:@"num"]];
    self.lb2.text = [[NSString alloc] initWithFormat:@"%@%@",@"当季预警排放量",[data objectForKey:@"warning"]];
    self.lb3.text = [[NSString alloc] initWithFormat:@"%@%@",@"当季许可排放量",[data objectForKey:@"total"]];
    self.lb4.text = [[NSString alloc] initWithFormat:@"%@%@",@"当季剩余排放量",[data objectForKey:@"surplus"]];
    //计算指南针的位置
    double allValue = [num3 floatValue]*4;
    double currentValue = [num1 floatValue];
    double currentDushu = currentValue*360/allValue;
    self.zhinanzhen = currentDushu-90;
    if (self.zhinanzhen < 0) {
        self.zhinanzhen = 360+self.zhinanzhen;
    }
    //计算出来的度数要减去90
    self.img.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(self.zhinanzhen));
    //计算半圆的范围
    double yujingvalue = [num2 floatValue]*[self getjidu];
    double yujingvaluePercent = yujingvalue*360/allValue;
    self.haifrac = yujingvaluePercent - 90;
    if (self.haifrac < 0) {
        self.haifrac = 360+self.haifrac;
    }
    [self setNeedsDisplay];
}


@end
