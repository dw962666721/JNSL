//
//  JSCustomTabbarItem.m
//  TYLM
//
//  Created by user on 16/8/4.
//  Copyright (c) 2016年 dw962666721. All rights reserved.
//

#import "JSCustomTabbarItem.h"
@interface JSCustomTabbarItem()

@property (nonatomic) BOOL isCustem;

@end
@implementation JSCustomTabbarItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.highlighted = super.highlighted;
        // 1.设置文字属性
        self.titleLabel.textAlignment = NSTextAlignmentCenter; // 文字居中
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        // 2.设置图片属性
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.adjustsImageWhenHighlighted = false;
        // 3.设置选中时的背景
        //        self.setBackgroundImage(UIImage(named: "tabbar_slider.png"), forState: UIControlState.Selected)
    }
    return self;
}

-(void)setCustem
{
    self.isCustem=true;
}
//返回是按钮内部UIImageView的边框
-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    if (self.isCustem)
    {
        return CGRectMake(-3, 4.5, contentRect.size.width+6, contentRect.size.height * kImageRatio +1);
    }
    else
    {
        return CGRectMake(0, 5, contentRect.size.width, contentRect.size.height*kImageRatio);
    }
}
//// 返回是按钮内部UILabel的边框
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height * kImageRatio + 3;
    CGFloat titleHeight = contentRect.size.height-titleY;
    return CGRectMake(0, titleY, contentRect.size.width, titleHeight);
}

@end
