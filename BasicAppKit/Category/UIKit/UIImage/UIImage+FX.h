//
//  UIImage+FX.h
//
//  Version 1.2.3
//
//  Created by Nick Lockwood on 31/10/2011.
//  Copyright (c) 2011 Charcoal Design
//
//  Distributed under the permissive zlib License
//  Get the latest version from here:
//
//  https://github.com/nicklockwood/FXImageView
//
//  This software is provided 'as-is', without any express or implied
//  warranty.  In no event will the authors be held liable for any damages
//  arising from the use of this software.
//
//  Permission is granted to anyone to use this software for any purpose,
//  including commercial applications, and to alter it and redistribute it
//  freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented; you must not
//  claim that you wrote the original software. If you use this software
//  in a product, an acknowledgment in the product documentation would be
//  appreciated but is not required.
//
//  2. Altered source versions must be plainly marked as such, and must not be
//  misrepresented as being the original software.
//
//  3. This notice may not be removed or altered from any source distribution.
//

#import <UIKit/UIKit.h>


@interface UIImage (FX)
//返回裁剪到指定矩形的图像的副本（在图像坐标中）
- (UIImage *)imageCroppedToRect:(CGRect)rect;
//返回缩放到指定大小的图像的副本。该方法可能会改变图像的宽高比。
- (UIImage *)imageScaledToSize:(CGSize)size;
//返回缩放以适合指定大小的图像的副本，而不更改其宽高比。如果纵横比不匹配，则所得到的图像可能小于一维中指定的大小。不会添加填充。
- (UIImage *)imageScaledToFitSize:(CGSize)size;
//返回缩放以适合指定大小的图像的副本，而不更改其宽高比。如果图像宽高比与指定尺寸的宽高比不匹配，则图像将被裁剪以适合。
- (UIImage *)imageScaledToFillSize:(CGSize)size;
//使用指定的UIViewContentMode将图像缩放和/或裁剪的副本返回到指定的大小。当在UIImageView中显示UIViewContentMode对图像的影响时，此方法非常有用。如果padToFit参数为NO，则所得到的图像可能小于指定的大小，因此宽高比不匹配。如果padToFit为YES，则会在图像周围添加额外的透明像素，以将其填充到指定的大小。
- (UIImage *)imageCroppedAndScaledToSize:(CGSize)size
                             contentMode:(UIViewContentMode)contentMode
                                padToFit:(BOOL)padToFit;
//返回图像的垂直反射的副本，使用渐变渐变为透明。缩放参数确定图像逐渐变细的点，其值应介于0.0和1.0之间。
- (UIImage *)reflectedImageWithScale:(CGFloat)scale;
//返回包含具有指定刻度，间距和alpha（不透明度）的反射的图像的副本。原始图像将在新图像中垂直居中，并且其上方的图像填充有与下面的反射高度相匹配的透明像素。这样可以更轻松地将图像放置在UIImageView中。
- (UIImage *)imageWithReflectionWithScale:(CGFloat)scale gap:(CGFloat)gap alpha:(CGFloat)alpha;
//使用指定颜色，偏移和模糊渲染的阴影返回图像的副本。无论偏移值如何，原始图像将在新图像中垂直居中，以便更容易将图像定位在UIImageView中。
- (UIImage *)imageWithShadowColor:(UIColor *)color offset:(CGSize)offset blur:(CGFloat)blur;
//返回图像的副本，并将拐角修剪到指定的曲率半径。
- (UIImage *)imageWithCornerRadius:(CGFloat)radius;
//以指定的alpha（不透明度）返回图像的副本。alpha被乘以图像的原始Alpha通道，因此这种方法只能用于使图像更透明，更不透明。
- (UIImage *)imageWithAlpha:(CGFloat)alpha;
//使用指定的遮罩图像剪辑图像。掩模图像应该是不透明的，灰度级的alpha掩码。如果要使用透明蒙版图像，请使用该maskImageFromImageAlpha方法将其转换为正确的格式。
- (UIImage *)imageWithMask:(UIImage *)maskImage;
//该方法从具有嵌入式alpha掩码的图像中提取Alpha通道，并将其作为独立的灰度蒙版图像返回，适用于该imageWithMask:方法。
- (UIImage *)maskImageFromImageAlpha;


@end
