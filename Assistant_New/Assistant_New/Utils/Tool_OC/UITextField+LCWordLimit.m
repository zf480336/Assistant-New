//
//  UITextField+LCWordLimit.m
//  VerifyDemo
//
//  Created by 伯明利 on 2017/6/26.
//  Copyright © 2017年 伯明利. All rights reserved.
//

#import "UITextField+LCWordLimit.h"
#import <objc/runtime.h>
static const void *lcCountKey = &lcCountKey;

@implementation UITextField (LCWordLimit)

- (void)lc_wordLimit:(NSInteger)count {
    self.lc_maxLength = [NSString stringWithFormat:@"%ld",(long)count];
    [self addTarget:self action:@selector(lc_valueChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (NSString *)lc_maxLength {
    return objc_getAssociatedObject(self, &lcCountKey);
}
- (void)setLc_maxLength:(NSString *)lc_count {
    objc_setAssociatedObject(self, &lcCountKey, lc_count, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(void)lc_moneyFormat{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lc_textChangedForMoney:) name:UITextFieldTextDidChangeNotification object:self];
}

- (void)lc_valueChanged:(UITextField *)sender {
    //数字限制
    NSInteger maximumNumberOfText = [self.lc_maxLength integerValue];
    NSString* string = self.text;
    NSString* lang = [self.textInputMode primaryLanguage];
    if ([lang isEqualToString:@"zh-Hans"]) {//中文输入
        //获取高亮部分
        UITextRange* selectedRange = [self markedTextRange];
        UITextPosition* position = [self positionFromPosition:selectedRange.start offset:0];
        if (!position) {
            if (string.length > maximumNumberOfText) {
                self.text = [string substringToIndex:maximumNumberOfText];
            }
        }
    } else {
        if (string.length > maximumNumberOfText) {
            NSRange rangeIndex = [string rangeOfComposedCharacterSequenceAtIndex:maximumNumberOfText];
            if (rangeIndex.length == 1) {
                self.text = [string substringToIndex:maximumNumberOfText];
            }else{
                NSRange rangeRange = [string rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, maximumNumberOfText)];
                self.text = [string substringWithRange:rangeRange];
            }
        }
    }
}

-(void)lc_textChangedForMoney:(NSNotification*)notification{
//    UITextField* textField = notification.object;
    
}
@end
