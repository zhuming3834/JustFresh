//
//  PurchaseCarAnimationTool.m
//  PruchaseCarAnimation
//
//  Created by zhenyong on 16/8/17.
//  Copyright © 2016年 com.demo. All rights reserved.
//
#import "AppDelegate.h"
#import "PurchaseCarAnimationTool.h"

@interface PurchaseCarAnimationTool () <CAAnimationDelegate>

@end


@implementation PurchaseCarAnimationTool
+(instancetype)shareTool
{
    return [[PurchaseCarAnimationTool alloc]init];
}
-(void)startAnimationandView:(UIView *)view andRect:(CGRect)rect andFinisnRect:(CGPoint)finishPoint andFinishBlock:(animationFinisnBlock)completion
{
    //图层
    _layer = [CALayer layer];
    _layer.contents = view.layer.contents;
    _layer.contentsGravity = kCAGravityResizeAspectFill;
    rect.size.width = view.frame.size.width;
    rect.size.height = view.frame.size.width;   //重置图层尺寸
    _layer.bounds = rect;
    _layer.cornerRadius = rect.size.width/2;
    _layer.masksToBounds = YES;          //圆角
    [[UIApplication sharedApplication].delegate.window.layer addSublayer:_layer];
    _layer.position = CGPointMake(rect.origin.x+view.frame.size.width/2, CGRectGetMidY(rect)); //a 点
        // 路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:_layer.position];
    [path addQuadCurveToPoint:finishPoint controlPoint:CGPointMake(ScreenWidth/2, rect.origin.y-80)];
    //关键帧动画
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.path = path.CGPath;
    //
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotateAnimation.removedOnCompletion = YES;
    rotateAnimation.fromValue = [NSNumber numberWithFloat:0];
    rotateAnimation.toValue = [NSNumber numberWithFloat:12];
    rotateAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.removedOnCompletion = YES;
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:0.2];
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
    
    
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[pathAnimation,rotateAnimation,scaleAnimation];
    groups.duration = 1.2f;
    groups.removedOnCompletion=NO;
    groups.fillMode=kCAFillModeForwards;
    groups.delegate = self;
    [_layer addAnimation:groups forKey:@"group"];
    if (completion) {
        _animationFinisnBlock = completion;
    }
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    //    [anim def];
    if (anim == [_layer animationForKey:@"group"]) {
    
        [_layer removeFromSuperlayer];
        _layer = nil;
        if (_animationFinisnBlock) {
            _animationFinisnBlock(YES);
        }
    }
}
+(void)shakeAnimation:(UIView *)shakeView
{
    // transform.translation.y
    CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    shakeAnimation.duration = 0.25f;
    shakeAnimation.fromValue = [NSNumber numberWithFloat:0.7];
    shakeAnimation.toValue = [NSNumber numberWithFloat:1.2];
    shakeAnimation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
    shakeAnimation.autoreverses = YES;
    [shakeView.layer addAnimation:shakeAnimation forKey:nil];
}
@end
