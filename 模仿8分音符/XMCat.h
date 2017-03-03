//
//  XMCat.h
//  模仿8分音符
//
//  Created by RenXiangDong on 17/3/1.
//  Copyright © 2017年 RenXiangDong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XMCatDelegate <NSObject>

- (void)catTouchTheGround;
- (void)catFallDownFinishd;


@end

@interface XMCat : UIView

@property (nonatomic, assign) BOOL isAlive;


@property (nonatomic,assign) id<XMCatDelegate>delegate;

@property (nonatomic, assign) BOOL isInSky;

- (void)jumpWithHeight:(CGFloat)height;

- (void)fallDown;

- (void)reStart;

@end
