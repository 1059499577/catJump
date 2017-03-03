//
//  XMNewGround.m
//  模仿8分音符
//
//  Created by RenXiangDong on 17/3/3.
//  Copyright © 2017年 RenXiangDong. All rights reserved.
//

#import "XMNewGround.h"
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface XMNewGround ()
@property (nonatomic, strong) UIView *firstView;
@property (nonatomic, strong) UIView *secondView;
@property (nonatomic, strong) NSMutableArray *firstCliffArray;
@property (nonatomic, strong) NSMutableArray *secondCliffArray;

@end
@implementation XMNewGround

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self reStart];
    }
    return self;
}

- (void)moveWithSpeed:(CGFloat)speed {
    if (self.canMove == NO) {
        return;
    }
    
    if (self.firstView.frame.origin.x > -2.01 * kScreenWidth) {
        [UIView animateWithDuration:0.1 animations:^{
            self.firstView.frame = [self moveLeft:speed withFrame:self.firstView.frame];
            self.secondView.frame = [self moveLeft:speed withFrame:self.secondView.frame];
        }];
    } else {
        UIView *tempView = self.firstView;
        self.firstView = self.secondView;
        self.secondView = tempView;
        self.secondView.frame = CGRectMake(CGRectGetMaxX(self.firstView.frame), 0,2 * kScreenWidth , 128);
        [self clearAllCliffsForView:self.secondView];
        [self addCliffToBgView:self.secondView];
    }
}
/* 第一次开始的时候 */
- (void)addCliffForFirstView:(UIView*)firstView {
    int number = 1 + arc4random() % 3;
    CGFloat averageWidth = 1.5 * kScreenWidth / number;
    for (int i = 0; i < number; i++) {
        CGFloat cliffWidth = 70 + arc4random()%100 * 0.01 * 0.2 *averageWidth;
        CGFloat gap = averageWidth - cliffWidth;
        CGFloat X = gap * (arc4random()%100 * 0.01) +  i * averageWidth + 0.5 * kScreenWidth;
        
        UIView *cliff = [[UIView alloc] initWithFrame:CGRectMake(X, 0, cliffWidth, 128)];
        cliff.backgroundColor = [UIColor whiteColor];
        [firstView addSubview:cliff];
    }
}

- (void)addCliffToBgView:(UIView*)bgView{
    int number = 2 + arc4random() % 5;
    CGFloat averageWidth = 2 * kScreenWidth / number;
    for (int i = 0; i < number; i++) {
        CGFloat cliffWidth = 70 + arc4random()%100 * 0.01 * 0.2 *averageWidth;
        CGFloat gap = averageWidth - cliffWidth;
        CGFloat X = gap * (arc4random()%100 * 0.01) +  i * averageWidth;

        UIView *cliff = [[UIView alloc] initWithFrame:CGRectMake(X, 0, cliffWidth, 128)];
        cliff.backgroundColor = [UIColor whiteColor];
        [bgView addSubview:cliff];
    }
    
}

- (void)clearAllCliffsForView:(UIView*)bgView {
    for (UIView *view in bgView.subviews) {
        [view removeFromSuperview];
    }
}

- (BOOL)fallDownInDistance:(CGFloat)distance {
    CGFloat catWidth = 50;
    for (UIView *cliff in self.firstView.subviews) {
        
        CGFloat cliffMinX = cliff.frame.origin.x + self.firstView.frame.origin.x;
        CGFloat cliffMaxX = cliffMinX + cliff.frame.size.width;
        NSLog(@"%f -- %f",cliffMinX,cliffMaxX);
        if (distance >= cliffMinX && distance <= (cliffMaxX - catWidth)) {
            return YES;
        }
    }
    return  NO;
}
- (CGRect)moveLeft:(CGFloat)left withFrame:(CGRect)frame{
    CGRect rect = CGRectMake(frame.origin.x - left, frame.origin.y, 2 * kScreenWidth, 128);
    return rect;
}
- (void)reStart {
    if (self.firstView) {
        [self.firstView removeFromSuperview];
    }
    if (self.secondView) {
        [self.secondView removeFromSuperview];
    }
    self.canMove = YES;
    self.firstView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,2 * kScreenWidth , 128)];
    self.secondView = [[UIView alloc] initWithFrame:CGRectMake(2 * kScreenWidth, 0,2 * kScreenWidth , 128)];
    
    self.firstView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Icon-40"]];
    self.secondView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Icon-40"]];
    [self addSubview:self.firstView];
    [self addSubview:self.secondView];
    self.firstCliffArray = [[NSMutableArray alloc] init];
    self.secondCliffArray = [[NSMutableArray alloc] init];
    [self addCliffForFirstView:self.firstView];
    [self addCliffToBgView:self.secondView];
}


@end
