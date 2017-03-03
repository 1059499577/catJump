//
//  XMNewGround.h
//  模仿8分音符
//
//  Created by RenXiangDong on 17/3/3.
//  Copyright © 2017年 RenXiangDong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMNewGround : UIView
@property (nonatomic, assign) BOOL canMove;

- (void)moveWithSpeed:(CGFloat)speed;

/* 下落位置，返回是否死了 */
- (BOOL)fallDownInDistance:(CGFloat)distance;

- (void)reStart;
@end
