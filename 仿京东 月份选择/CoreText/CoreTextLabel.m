//
//  CoreTextLabel.m
//  仿京东 月份选择
//
//  Created by ouxuesen on 16/8/30.
//  Copyright © 2016年 ouxuesen. All rights reserved.
//

#import "CoreTextLabel.h"
#import "CoreText/CoreText.h"
@implementation CoreTextLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)drawTextInRect:(CGRect)rect
{
    [super drawTextInRect:rect];
    //1
    CGContextRef context = UIGraphicsGetCurrentContext();
    //2
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    //3
    
    CGMutablePathRef path = CGPathCreateMutable();
//    CGPathAddRect(path, NULL, self.bounds);
    
    
    CGPathAddEllipseInRect(path, NULL, self.bounds);
    
    NSAttributedString * attstring  = [[NSAttributedString alloc]initWithString:@"Hello World!""创建绘制区域，Coretext本身支持各种稳健派盘的区域。""我们这里简单的将UIView的整个界面作为排盘的区域""为了加深理解，建议读者将该不走的代码提花城如下代码""测试设置不同的绘制区域带来的界面变化"];
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)(attstring));
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, [attstring length]), path, NULL);
    //5
    CTFrameDraw(frame, context);
    //6
    CFRelease(frame);
    CFRelease(path);
    CFRelease(framesetter);
    
}
@end
