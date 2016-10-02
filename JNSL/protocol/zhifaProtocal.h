//
//  zhifaProtocal.h
//  JNSL
//
//  Created by wangjiang on 16/10/2.
//  Copyright © 2016年 zw. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol zhifaProtocal <NSObject>
-(void)cellClick:(NSInteger)index withUrl:(NSString *)url withName:(NSString *)filename withindexpath:(NSIndexPath *)indexpath;
-(void)cellSee:(NSInteger)index withfilename:(NSString *)filename;
@end
