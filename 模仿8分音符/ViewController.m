//
//  ViewController.m
//  模仿8分音符
//
//  Created by RenXiangDong on 17/3/1.
//  Copyright © 2017年 RenXiangDong. All rights reserved.
//

#import "ViewController.h"
#import "XMVioceTool.h"
#import "XMCat.h"
#import "XMNewGround.h"

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface ViewController ()<XMVioceToolDelegate,XMCatDelegate,UIAlertViewDelegate>
@property (nonatomic, strong) XMVioceTool *voiceTool;
@property (nonatomic, strong) XMCat *cat;
@property (nonatomic, strong) XMNewGround *ground;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.voiceTool = [[XMVioceTool alloc] init];
    self.voiceTool.delegate = self;
    [self.voiceTool startRecord];
    self.cat = [[XMCat alloc] init];
    self.cat.frame = CGRectMake(100, kScreenHeight - 128 - 50, 50, 50);
    self.cat.delegate = self;
    
    self.ground = [[XMNewGround alloc] initWithFrame:CGRectMake(0, kScreenHeight - 128, kScreenWidth, 128)];
    [self.view addSubview:self.ground];
    [self.view addSubview:self.cat];
    
}

- (void)moveWithSpeed:(float)speed{
//    NSLog(@"移动速度为：%f",speed);
    [self.ground moveWithSpeed:speed];
    if (self.cat.isInSky == NO && self.cat.isAlive == YES) {
        BOOL isFall = [self.ground fallDownInDistance:100];
        if (isFall) {
            self.ground.canMove = NO;
            [self.cat fallDown];
        }
    }
    
}

- (void)jumpWithHeight:(float)height {
//    NSLog(@"跳跃高度为：%f",height);
    [self.cat jumpWithHeight:height];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)catTouchTheGround {
    
    BOOL isFall = [self.ground fallDownInDistance:100];
    if (isFall) {
        self.ground.canMove = NO;
        [self.cat fallDown];
    }
}

- (void)catFallDownFinishd {
    UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"任向东帅吗" message:@"就问你帅不帅" delegate:self cancelButtonTitle:@"帅" otherButtonTitles:@"很帅",nil];
    [aler show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self.ground reStart];
    [self.cat reStart];
}


@end
