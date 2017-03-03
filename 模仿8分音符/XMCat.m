//
//  XMCat.m
//  模仿8分音符
//
//  Created by RenXiangDong on 17/3/1.
//  Copyright © 2017年 RenXiangDong. All rights reserved.
//



#import "XMCat.h"
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface XMCat ()
@property (nonatomic, strong) UIDynamicAnimator *anim;
@end

@implementation XMCat

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor blueColor];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.isAlive = YES;
    }
    return self;
}

- (void)jumpWithHeight:(CGFloat)height {
    if (self.isAlive == NO) {
        return;
    }
    self.isInSky = YES;
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y - height*10, 50, 50);
        
    } completion:^(BOOL finished) {
//        _anim = [[UIDynamicAnimator alloc] initWithReferenceView:self];
//        UIGravityBehavior * gravity = [[UIGravityBehavior alloc] initWithItems:@[self]];
//        CGVector gravityDircetion = {0,1};
//        [gravity setGravityDirection:gravityDircetion];
//        [_anim addBehavior:gravity];
        [UIView animateWithDuration:0.5 animations:^{
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y + height*10, 50, 50);
        } completion:^(BOOL finished) {
            if ([self.delegate respondsToSelector:@selector(catTouchTheGround)]) {
                [self.delegate catTouchTheGround];
                self.isInSky = NO;
            }
        }];
    }];
  
}

- (void)fallDown {
    self.isAlive = NO;
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(self.frame.origin.x, kScreenHeight, 50, 50);
    } completion:^(BOOL finished) {
        if ([self.delegate respondsToSelector:@selector(catFallDownFinishd)]) {
            [self.delegate catFallDownFinishd];
        }
    }];
}

- (void)reStart {
    self.frame = CGRectMake(self.frame.origin.x, kScreenHeight - 128 - 50 , 50, 50);
    self.isAlive = YES;
}

@end
