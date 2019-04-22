//
//  UIImage+Orientation.h
//  FaceRecognition
//
//  Created by WuJiLei on 2019/1/7.
//  Copyright © 2019年 com.znxunzhi.AJiaMiddleTeacher. All rights reserved.
//该类是翻转图片,(手机拍照默认方向是旋转90度的)

#import <UIKit/UIKit.h>



@interface UIImage (Orientation)
+ (UIImage *)fixOrientation:(UIImage *)aImage;
@end

