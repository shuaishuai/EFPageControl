//
//  ViewController.m
//  EFPageControl
//
//  Created by Allen on 2016/12/1.
//  Copyright © 2016年 Allen. All rights reserved.
//

#import "ViewController.h"
#import "EFPageControl.h"
@interface ViewController ()<UIScrollViewDelegate, EFPageControlDelegate>
@property (nonatomic, strong)EFPageControl *pageControl1;
@property (nonatomic, strong)EFPageControl *pageControl2;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.pageControl1];
    [self.view addSubview:self.pageControl2];
    self.pageControl1.numberOfPage = 5;
    self.pageControl2.numberOfPage = 5;
}
- (IBAction)buttonClick:(id)sender {
    if (self.pageControl1.currentPage == 4) {
        self.pageControl1.currentPage = 0;
        self.pageControl2.currentPage = 0;
        return;
    }
    self.pageControl1.currentPage ++;
    self.pageControl2.currentPage ++;
}

- (UIView *)pageControl:(EFPageControl *)pageControl indicatorViewAtIndex:(NSInteger)index{
    UIView *view = [[UIView alloc]init];
    if (index == pageControl.currentPage) {
        view.backgroundColor = [UIColor redColor];
    }else{
        view.backgroundColor = [UIColor grayColor];
    }
    return view;
}
- (CGSize)pageControl:(EFPageControl *)pageControl sizeForIndicatorViewAtIndex:(NSInteger)index{
    return CGSizeMake(30, 15);
}


- (CGFloat)pageControl:(EFPageControl *)pageControl spaceBeforPageAtIndex:(NSInteger)index{
    if (pageControl == self.pageControl1) {
        return 0;
    }else{
        if (index == 0) {
            return 0;
        }else{
            return 5;
        }
    }
    return 0;
}

- (EFPageControl *)pageControl1{
    if (_pageControl1 == nil) {
        _pageControl1 = [[EFPageControl alloc]initWithFrame:CGRectMake(0, 400, CGRectGetWidth(self.view.bounds), 20)];
        _pageControl1.delegate = self;
    }
    return _pageControl1;
}

- (EFPageControl *)pageControl2{
    if (_pageControl2 == nil) {
        _pageControl2 = [[EFPageControl alloc]initWithFrame:CGRectMake(0, 430, CGRectGetWidth(self.view.bounds), 20)];
        _pageControl2.delegate = self;
    }
    return _pageControl2;
}
@end
