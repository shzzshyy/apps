//
//  UIView+Addition.h
//  FYDriver
//
//  Created by 曹运 on 15/11/13.
//  Copyright © 2015年 Foryou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Addition)
/**
 * Shortcut for frame.origin.x.
 *
 * Sets frame.origin.x = left
 */
@property (nonatomic) CGFloat left;

/**
 * Shortcut for frame.origin.y
 *
 * Sets frame.origin.y = top
 */
@property (nonatomic) CGFloat top;

/**
 * Shortcut for frame.origin.x + frame.size.width
 *
 * Sets frame.origin.x = right - frame.size.width
 */
@property (nonatomic) CGFloat right;

/**
 * Shortcut for frame.origin.y + frame.size.height
 *
 * Sets frame.origin.y = bottom - frame.size.height
 */
@property (nonatomic) CGFloat bottom;

/**
 * Shortcut for frame.size.width
 *
 * Sets frame.size.width = width
 */
@property (nonatomic) CGFloat width;

/**
 * Shortcut for frame.size.height
 *
 * Sets frame.size.height = height
 */
@property (nonatomic) CGFloat height;

/**
 * Shortcut for center.x
 *
 * Sets center.x = centerX
 */
@property (nonatomic) CGFloat centerX;

/**
 * Shortcut for center.y
 *
 * Sets center.y = centerY
 */
@property (nonatomic) CGFloat centerY;

/**
 * Return the x coordinate on the screen.
 */
@property (nonatomic, readonly) CGFloat ttScreenX;

/**
 * Return the y coordinate on the screen.
 */
@property (nonatomic, readonly) CGFloat ttScreenY;

/**
 * Return the x coordinate on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGFloat screenViewX;

/**
 * Return the y coordinate on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGFloat screenViewY;

/**
 * Return the view frame on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGRect screenFrame;

/**
 * Shortcut for frame.origin
 */
@property (nonatomic) CGPoint origin;

/**
 * Shortcut for frame.size
 */
@property (nonatomic) CGSize size;

/**
 * Shortcut for layer.transfrom
 */
/**
 *  设置圆角
 */
- (void)setCornerRadius:(CGFloat)cornerRadius;
/**
 *  设置某一角圆角
 */
- (void)setCornerRadius:(CGFloat)cornerRadius directions:(UIRectCorner)rectCorner;
- (void)setBorderWithWidth:(CGFloat)width andColor:(UIColor *)color;
-(void)removeAllSubviews;
-(void)removeViewWithTag:(NSInteger)tag;
-(void)removeViewWithTags:(NSArray *)tagArray;
-(void)removeViewWithTagLessThan:(NSInteger)tag;
-(void)removeViewWithTagGreaterThan:(NSInteger)tag;
- (UIViewController *)selfViewController;
-(UIView *)subviewWithTag:(NSInteger)tag;
@end
