//
//  EFPageControl.h
//  EFPageControl
//
//  Created by Allen on 2016/12/1.
//  Copyright © 2016年 Allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EFPageControlDelegate;

@interface EFPageControl : UIView

@property (nonatomic, assign)NSInteger numberOfPage;
@property (nonatomic, assign)NSInteger currentPage;
@property (nonatomic, weak)id<EFPageControlDelegate>delegate;
- (instancetype)init UNAVAILABLE_ATTRIBUTE;
/**
 重新加载所有指示器
 */
- (void)reloadPageIndicatorView;
@end

@protocol EFPageControlDelegate <NSObject>
@required
- (UIView *)pageControl:(EFPageControl *)pageControl indicatorViewAtIndex:(NSInteger)index;

- (CGSize)pageControl:(EFPageControl *)pageControl sizeForIndicatorViewAtIndex:(NSInteger)index;

@optional
- (CGFloat)pageControl:(EFPageControl *)pageControl spaceBeforPageAtIndex:(NSInteger)index;

- (CGFloat)pageControl:(EFPageControl *)pageControl topSpaceForIndicatorAtIndex:(NSInteger)index;

- (void)pageControl:(EFPageControl *)pageControl didSelectedPage:(UIView *)pageIndicator atIndex:(NSInteger)index;
@end
