//
//  Toast.h
//  
//
//  Created by apple on 13-1-22.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
// [Toast showWithText:@"获取下载key失败" bottomOffset:80 duration:5];
//

#define DEFAULT_DISPLAY_DURATION 2.0f

@interface Toast : NSObject {
    NSString *text;
    UIButton *contentView;
    CGFloat  duration;
}

+ (void)showWithText:(NSString *) text_;
+ (void)showWithText:(NSString *) text_
            duration:(CGFloat)duration_;

+ (void)showWithText:(NSString *) text_
           topOffset:(CGFloat) topOffset_;
+ (void)showWithText:(NSString *) text_
           topOffset:(CGFloat) topOffset
            duration:(CGFloat) duration_;

+ (void)showWithText:(NSString *) text_
        bottomOffset:(CGFloat) bottomOffset_;
+ (void)showWithText:(NSString *) text_
        bottomOffset:(CGFloat) bottomOffset_
            duration:(CGFloat) duration_;

@end
