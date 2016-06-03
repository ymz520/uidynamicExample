//
//  ViewController.m
//  uidynamicExample
//
//  Created by 张 荣桂 on 16/6/3.
//  Copyright © 2016年 张 荣桂. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,strong)UIDynamicAnimator *dynamicAnimator;
@end

@implementation ViewController
#pragma mark-懒加载
-(UIDynamicAnimator *)dynamicAnimator
{
    if(!_dynamicAnimator)
    {
        //创建物理仿真器(引用视图)(顺便设置仿真仿真范围)
        _dynamicAnimator=[[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    }
    return _dynamicAnimator;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //1.获取当前触摸的手指
    UITouch *touchs=[touches anyObject];
    //2
 CGPoint point=[touchs locationInView:touchs.view];
    
    //重力仿真
    [self addgravity];
    //碰撞
    [self addcollision];
    //吸附
//    [self addsnap:point];
    
}
#pragma mark-重力物理引擎
-(void)addgravity
{
    
    //创建相应的物理仿真行为(顺便添加物理仿真元素)
    UIGravityBehavior *gravitybehavior=[[UIGravityBehavior alloc]initWithItems:@[self.itemss]];
    //重力仿真方向
    gravitybehavior.gravityDirection=CGVectorMake(1, 0);
    gravitybehavior.angle=M_PI_2;
    gravitybehavior.magnitude=1;
    //将物理仿真行为添加到物理仿真器中，开始仿真
    [self.dynamicAnimator addBehavior:gravitybehavior];

}
#pragma mark-碰撞物理引擎
-(void)addcollision
{
    //创建物理仿真器(引用视图)(顺便设置仿真仿真范围)
    //创建相应的物理仿真行为(顺便添加物理仿真元素)
    UICollisionBehavior *collisionbrhavior=[[UICollisionBehavior alloc]initWithItems:@[self.itemss,self.segments]];
    //将参考范围转化为边界
    collisionbrhavior.translatesReferenceBoundsIntoBoundary=YES;
    //矩形里画椭圆
    UIBezierPath *bezierpath=[UIBezierPath bezierPathWithOvalInRect:self.view.frame];
    //将椭圆转化为边界
    [collisionbrhavior addBoundaryWithIdentifier:@"123" forPath:bezierpath];
    //将线段转化为边界
    [collisionbrhavior addBoundaryWithIdentifier:@"456" fromPoint:CGPointMake(0, 100) toPoint:CGPointMake(320, 400)];
    //将物理仿真行为添加到物理仿真器中，开始仿真
    [self.dynamicAnimator addBehavior:collisionbrhavior];
}
#pragma mark-吸附
-(void)addsnap:(CGPoint)point
{
    //创建物理仿真器(引用视图)(顺便设置仿真仿真范围)
    //创建相应的物理仿真行为(顺便添加物理仿真元素)
    UISnapBehavior *snapbehavior=[[UISnapBehavior alloc]initWithItem:self.itemss snapToPoint:point];
    [self.dynamicAnimator removeAllBehaviors];
    //damping（阻尼）
    snapbehavior.damping=10;
    //将物理仿真行为添加到物理仿真器中，开始仿真
    [self.dynamicAnimator addBehavior:snapbehavior];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
