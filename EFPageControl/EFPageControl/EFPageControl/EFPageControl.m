//
//  EFPageControl.m
//  EFPageControl
//
//  Created by Allen on 2016/12/1.
//  Copyright © 2016年 Allen. All rights reserved.
//

#import "EFPageControl.h"

@interface EFPageControl ()
@property (nonatomic, strong)UIScrollView *contentScrollView;
@end

@implementation EFPageControl

- (void)reloadPageIndicatorView{
    [self setupContent];
    [self layoutIndicatorPageView];
}

- (void)setNumberOfPage:(NSInteger)numberOfPage{
    if (_numberOfPage == numberOfPage) {
        return;
    }
    _numberOfPage = numberOfPage;
    [self setupContent];
    [self layoutIndicatorPageView];
}

- (void)setCurrentPage:(NSInteger)currentPage{
    if (_currentPage == currentPage) {
        return;
    }
    NSInteger oldPageIndicator = _currentPage;
    _currentPage = currentPage;
    [self replaceCurrentView:oldPageIndicator];
    [self replaceCurrentView:_currentPage];
    [self layoutIndicatorPageView];
    UIView *currentView = self.contentScrollView.subviews[self.currentPage];
    [self.contentScrollView scrollRectToVisible:currentView.frame animated:YES];
}

- (void)replaceCurrentView:(NSInteger)currentPage{
    UIView *oldCurrentPageView = [self.contentScrollView.subviews objectAtIndex:currentPage];
    UIView *newCurrentPageView = [self.delegate pageControl:self indicatorViewAtIndex:currentPage];
    [self.contentScrollView insertSubview:newCurrentPageView aboveSubview:oldCurrentPageView];
    [oldCurrentPageView removeFromSuperview];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat selfWidth = CGRectGetWidth(self.bounds);
    CGFloat scrollViewSizeWidth = self.contentScrollView.contentSize.width;
    if (selfWidth <= scrollViewSizeWidth ) {
        self.contentScrollView.bounds = CGRectMake(0, 0, selfWidth, CGRectGetHeight(self.bounds));
    }else{
        self.contentScrollView.bounds = CGRectMake(0, 0, scrollViewSizeWidth, CGRectGetHeight(self.bounds));
    }
    self.contentScrollView.center = CGPointMake(selfWidth*0.5, CGRectGetHeight(self.bounds)*0.5);
}

- (void)setupContent{
    [self.contentScrollView removeFromSuperview];
    self.contentScrollView = nil;
    UIView *lastIndicatorView = nil;
    for (NSInteger index = 0; index < self.numberOfPage; index++) {
        UIView *indictorView = [self.delegate pageControl:self indicatorViewAtIndex:index];
        indictorView.tag = index;
        [self.contentScrollView addSubview:indictorView];
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(indicatorViewClicked:)];
        [indictorView addGestureRecognizer:tapGes];
        lastIndicatorView = indictorView;
    }
}

- (void)layoutIndicatorPageView{
    NSArray *indicatorPageViews = self.contentScrollView.subviews;
    __block UIView *lastIndicatorView = nil;
    [indicatorPageViews enumerateObjectsUsingBlock:^(UIView *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGSize size = [self.delegate pageControl:self sizeForIndicatorViewAtIndex:idx];
        CGFloat spaceBefor = 0;
        CGFloat topSpace = 0;
        if ([self.delegate respondsToSelector:@selector(pageControl:spaceBeforPageAtIndex:)]) {
            spaceBefor = [self.delegate pageControl:self spaceBeforPageAtIndex:idx];
        }
        if ([self.delegate respondsToSelector:@selector(pageControl:topSpaceForIndicatorAtIndex:)]) {
            topSpace = [self.delegate pageControl:self topSpaceForIndicatorAtIndex:idx];
        }
        obj.frame = CGRectMake(CGRectGetMaxX(lastIndicatorView.frame)+spaceBefor, topSpace, size.width, size.height);
        lastIndicatorView = obj;
    }];
    self.contentScrollView.contentSize = CGSizeMake(CGRectGetMaxX(lastIndicatorView.frame), CGRectGetHeight(self.bounds));
    [self setNeedsLayout];
}

- (void)indicatorViewClicked:(UITapGestureRecognizer *)tapGes{
    if ([self.delegate respondsToSelector:@selector(pageControl:didSelectedPage:atIndex:)]) {
        [self.delegate pageControl:self didSelectedPage:tapGes.view atIndex:tapGes.view.tag];
    }
}

- (UIScrollView *)contentScrollView{
    if (_contentScrollView == nil) {
        _contentScrollView = [[UIScrollView alloc]init];
        _contentScrollView.showsVerticalScrollIndicator = NO;
        _contentScrollView.showsHorizontalScrollIndicator = NO;
        _contentScrollView.bounces = NO;
        [self addSubview:_contentScrollView];
    }
    return _contentScrollView;
}

@end
