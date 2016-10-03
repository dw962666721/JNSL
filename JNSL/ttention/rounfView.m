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
        
        
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    CGPoint centerpoint = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    CGFloat radius = self.frame.size.height/2-30;//半径 减去30是因为留地方放字
    UIBezierPath*  aPath = [UIBezierPath bezierPathWithArcCenter:centerpoint radius:radius startAngle:DEGREES_TO_RADIANS(270) endAngle:DEGREES_TO_RADIANS(135) clockwise:YES];
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
    [self addAttr];
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
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width/2)-(self.frame.size.height/2-50), self.frame.size.height/2, self.frame.size.height-100, self.frame.size.height/2-50)];
    lb.font = [UIFont systemFontOfSize:8];
    lb.numberOfLines = 0;
    lb.textColor = [UIColor whiteColor];
    lb.text = @"还宽度和速度回复圣诞节匡扶汉室快递发货时间短发好看舒服";
    [self addSubview:lb];
    [self addImg];
}

-(void)addImg{
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width/2-20, self.frame.size.height/2-2, 100, 5)];
    img.image = [UIImage imageNamed:@"zhinanzhen"];
    [self addSubview:img];
    //旋转图片
    //img.layer.anchorPoint = CGPointMake(0.7, 0.5);
    [self setAnchorPoint:CGPointMake(0.2, 0.5) forView:img];
    
    [UIView animateWithDuration:1.0 animations:^{
        img.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(179));
    }];
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


@end
