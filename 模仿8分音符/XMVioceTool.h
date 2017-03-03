//
//  XMVioceTool.h
//  模仿8分音符
//
//  Created by RenXiangDong on 17/3/1.
//  Copyright © 2017年 RenXiangDong. All rights reserved.
//


#import <Foundation/Foundation.h>

@protocol XMVioceToolDelegate <NSObject>

- (void)moveWithSpeed:(float)speed;

- (void)jumpWithHeight:(float)height;

@end

@interface XMVioceTool : NSObject

@property (nonatomic, assign)id<XMVioceToolDelegate>delegate;

- (void)startRecord;

- (void)stopRecord;

@end
