//
//  lineChartView.m
//  ImageCorner
//
//  Created by zw on 16/3/22.
//  Copyright © 2016年 zw. All rights reserved.
//

#import "lineChartView.h"

@implementation lineChartView

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
        self.vh = self.frame.size.height;
        self.vw = self.frame.size.width;
        self.heiunit = self.vh/8-1;
        self.widunit = self.vw/6-1;
        
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    //画竖线
    UIBezierPath *pathlineOne = [UIBezierPath bezierPath];
    [pathlineOne moveToPoint:CGPointMake(0, self.vh)];
    [pathlineOne addLineToPoint:CGPointMake(0, 0)];
    pathlineOne.lineWidth = 0.1;
    [ColorWithRGB(0x9d9d9d) setFill];
    [pathlineOne stroke];
    //画横线
    [pathlineOne moveToPoint:CGPointMake(0, self.vh)];
    [pathlineOne addLineToPoint:CGPointMake(self.vw, self.vh)];
    pathlineOne.lineWidth = 0.1;
    [ColorWithRGB(0x9d9d9d) setFill];
    [pathlineOne stroke];
    [self drawPoint];
    [self addPoint];
    
}



-(void)drawPoint{
UIBezierPath *pathlineOne = [UIBezierPath bezierPath];
    for (int i=1; i<7; i++){
        CGFloat xPosition = self.widunit * i;
        [pathlineOne moveToPoint:CGPointMake(xPosition, self.vh)];
        [pathlineOne addLineToPoint:CGPointMake(xPosition, self.vh-5)];
        pathlineOne.lineWidth = 0.1;
        [ColorWithRGB(0x9d9d9d) setFill];
        [pathlineOne stroke];
    }
    for (int i=1; i<9; i++){
        CGFloat yPosition = self.vh - self.heiunit * i;
        [pathlineOne moveToPoint:CGPointMake(0, yPosition)];
        [pathlineOne addLineToPoint:CGPointMake(self.vw, yPosition)];
        pathlineOne.lineWidth = 0.1;
        [ColorWithRGB(0x9d9d9d) setFill];
        [pathlineOne stroke];
    }
}

//横的7个点 竖的9个点 竖的从下到上依次为0..8 横的为0..6
-(void)addPoint{
    if (self.arr != nil) {
        NSMutableArray *pointArr = [[NSMutableArray alloc] init];
         UIBezierPath *pathlineOne = [UIBezierPath bezierPath];
        for (int i=0; i<self.arr.count; i++) {
             NSValue *value = self.arr[i];
            CGPoint point2 = [value CGPointValue];
            CGFloat xx =  point2.x*self.widunit;
            CGFloat yy = self.vh - point2.y *self.heiunit;
            if (i==0) {
                [pathlineOne moveToPoint:CGPointMake(xx, yy)];
            }else{
                [pathlineOne addLineToPoint:CGPointMake(xx, yy)];
            }
            [pointArr addObject:[NSValue valueWithCGPoint:CGPointMake(xx, yy)]];
        }
        pathlineOne.lineWidth = 0.5;
        [ColorWithRGB(0x7d007c) setFill];
        [ColorWithRGB(0x7d007c) setStroke];
        [pathlineOne stroke];
        //在这个点上面画一个圆
        [self addRict:pointArr];
    }
}

-(void)addRict:(NSMutableArray *)pointArr{
    for (int i = 0; i<pointArr.count; i++) {
        NSValue *value = pointArr[i];
        CGPoint centerpoint = [value CGPointValue];
        CGFloat radius = 2;//半径
        UIBezierPath*  aPath = [UIBezierPath bezierPathWithArcCenter:centerpoint radius:radius startAngle:0 endAngle:DEGREES_TO_RADIANS(360) clockwise:YES];
        [aPath addLineToPoint:centerpoint];
        aPath.lineWidth = 0.1;
        [aPath closePath];
        [[UIColor whiteColor] setFill];
        [ColorWithRGB(0x8de9fb) setStroke];
        [aPath stroke];
        [aPath fill];
    }
}

@end
