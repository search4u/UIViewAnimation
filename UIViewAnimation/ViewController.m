//
//  ViewController.m
//  UIViewAnimation
//
//  Created by bottle on 15-4-30.
//  Copyright (c) 2015年 bottle. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (nonatomic,weak) UIView *parent;
@property (nonatomic,strong) UIView *blue;
@property (nonatomic,strong) UIView *red;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *parent = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 200 , 300)];
    parent.backgroundColor = [UIColor grayColor];
    [self.view addSubview:parent];
    self.parent = parent;
    
    UIView *blue = [[UIView alloc] init];
    blue.frame = parent.bounds;
    blue.backgroundColor = [UIColor blueColor];
    //[parent addSubview:blue];
    self.blue = blue;
    
    UIView *red = [[UIView alloc]init];
    red.frame = parent.bounds;
    red.backgroundColor = [UIColor redColor];
    [parent addSubview:red];
    self.red = red;
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self uiviewAnimation5];
}

#pragma mark - 转场动画
/**
 *  转场动画3
 */
- (void)uiviewAnimation5 {
    UIView *from = nil;
    UIView *to = nil;
    if (self.blue.superview) {
        from = self.blue;
        to = self.red;
    } else {
        from = self.red;
        to = self.blue;
    }
    //会把from从superview移除，将to addsubview
    [UIView transitionFromView:from toView:to duration:1.0 options:UIViewAnimationOptionTransitionFlipFromTop completion:^(BOOL finished) {
        
    }];
}

/**
 *  转场动画2
 */
- (void)uiviewAnimation4 {
    [UIView transitionWithView:self.parent duration:1.0 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
        if (self.blue.superview) {
            [self.blue removeFromSuperview];
            [self.parent addSubview:self.red];
        } else {
            [self.red removeFromSuperview];
            [self.parent addSubview:self.blue];
        }
    } completion:^(BOOL finished) {
        
    }];
}

/**
 *  转场动画1
 */
- (void)uiviewAnimation3 {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.parent cache:YES];
    if (self.blue.superview) {
        [self.blue removeFromSuperview];
        [self.parent addSubview:self.red];
    } else {
        [self.red removeFromSuperview];
        [self.parent addSubview:self.blue];
    }
    [UIView commitAnimations];
}

#pragma mark - block
- (void)uiviewAnimation2 {
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.iconView.center = CGPointMake(300, 300);
    } completion:^(BOOL finished) {
        NSLog(@"动画结束");
    }];
}

#pragma mark - 头尾式
- (void)uiviewAnimation1 {
    [UIView beginAnimations:@"anim" context:@"123"];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationWillStartSelector:@selector(animationDidStart:)];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:)];
    [UIView setAnimationDuration:2.0];
    self.iconView.center = CGPointMake(300, 300);
    [UIView commitAnimations];
}

- (void)animationDidStart:(CAAnimation *)anim{
    NSLog(@"animationDidStart");
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"animationDidStop");
}

@end
