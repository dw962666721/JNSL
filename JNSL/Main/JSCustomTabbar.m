//
//  JSCustomTabbar.m
//  TYLM
//
//  Created by user on 16/8/4.
//  Copyright (c) 2016年 dw962666721. All rights reserved.
//

#import "JSCustomTabbar.h"
#define count 4
@interface JSCustomTabbar()
@property (nonatomic) BOOL needsReloadData;

@end
@implementation JSCustomTabbar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.needsReloadData=YES;
    }
    return self;
}
-(void)layoutSubviews
{
    if (self.needsReloadData)
    {
        [self reloadData];
    }
}
-(void)reloadData
{
    //    self.backgroundColor = [UIColor colorWithRed:35 green:40 blue:50 alpha:1];
    CGFloat width = self.frame.size.width/count;
    CGFloat height = self.frame.size.height;
    for(NSInteger i =0;i<count;i++)
    {
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.borderWidth = 0.3;
        JSCustomTabbarItem *tabbarItem = [JSCustomTabbarItem buttonWithType:UIButtonTypeCustom];
        tabbarItem.frame = CGRectMake(i * width, 0, width, height);
        
        if (i == 1)
        {
            [tabbarItem setCustem];
        }
        tabbarItem.tag = i;
        [tabbarItem setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [tabbarItem setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [tabbarItem addTarget:self action:@selector(tabbarItemClick:) forControlEvents:UIControlEventTouchDown];
        [tabbarItem setTitle:[self.datasource customTabbar:self titleForButtonAtIndex:i] forState:UIControlStateNormal];
        [tabbarItem setImage:[UIImage imageNamed:[self.datasource customTabbar:self imageNormalForButtonAtIndex:i]] forState:UIControlStateNormal];
        [tabbarItem setImage:[UIImage imageNamed:[[self.datasource customTabbar:self imageNormalForButtonAtIndex:i] stringByAppendingString:@"选中"]] forState:UIControlStateSelected];
        if(i==0)
        {
            tabbarItem.selected=YES;
            self.currentSelecteItem = tabbarItem;
        }
        [self addSubview:tabbarItem];
    }
    for (NSInteger j=1; j<count; j++) {
        UIView *lineView = [[UIView alloc] init];
        lineView.frame = CGRectMake(j*width-0.5, 12, 0.5, 25);
        lineView.backgroundColor = [UIColor lightGrayColor];
        //        [self addSubview:lineView];
    }
    self.needsReloadData=NO;
    self.backgroundColor = RGBA(35, 40, 50, 1);
}
//MARK: -- 点击了某个item
-(void)tabbarItemClick:(JSCustomTabbarItem*)tabbarItem
{
    // 1.让当前的item取消选中
    self.currentSelecteItem.selected=NO;
    // 2.让新的item选中
    tabbarItem.selected=YES;
    // 3.让新的item变为当前选中
    self.currentSelecteItem = tabbarItem;
    // 4.调用代理
    [self.delegate tabbarDidSelected:tabbarItem.tag];
}
-(void)tabbarItemClick0:(NSInteger)index
{
    JSCustomTabbarItem *tabbarItem = (JSCustomTabbarItem*)[self viewWithTag:index];
    // 1.让当前的item取消选中
    self.currentSelecteItem.selected=NO;
    // 2.让新的item选中
    tabbarItem.selected=YES;
    // 3.让新的item变为当前选中
    self.currentSelecteItem = tabbarItem;
    // 4.调用代理
    [self.delegate tabbarDidSelected:tabbarItem.tag];
}

@end
