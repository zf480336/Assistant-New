//
//  EntryCollectionCell.m
//  MallClient
//
//  Created by 中车_LL_iMac on 2016/11/28.
//  Copyright © 2016年 com.zhongche.cn. All rights reserved.
//

#import "EntryCollectionCell.h"

@implementation EntryCollectionCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self != nil) {
        _bg = [UIView new];
        _bg.backgroundColor = [UIColor whiteColor];
        [_bg.layer setMasksToBounds:YES];
        [_bg.layer setCornerRadius:12];//设置矩形四个圆角半径
        _bg.layer.borderColor = [self colorWithHexString:@"#EBEBEB"].CGColor;
        _bg.layer.borderWidth = 0.5;
        [self addSubview:_bg];
        
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.textColor = [self colorWithHexString:@"#666666"];
        _textLabel.font = [UIFont systemFontOfSize:12.0f];
        [self addSubview:_textLabel];
    }
    return self;
}

-(void)setBright:(BOOL)bright
{
    _bright = bright;
    if (bright) {
        self.textLabel.textColor = [self colorWithHexString:@"#FC8716"];
        self.bg.layer.borderColor = [self colorWithHexString:@"#FC8716"].CGColor;
    }
    else
    {
        self.textLabel.textColor = [self colorWithHexString:@"#66666"];
        self.bg.layer.borderColor = [self colorWithHexString:@"#66666"].CGColor;
    }

}
- (UIColor *) colorWithHexString: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor colorWithWhite:1.0 alpha:0.5];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor colorWithWhite:1.0 alpha:0.5];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}
@end

@implementation EntryCollectionCellForConditionsForRetrievalVC

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self != nil) {
        [self.bg.layer setCornerRadius:16];//设置矩形四个圆角半径
    }
    return self;
}

-(void)setBright:(BOOL)bright {
    [super setBright:bright];
    if (bright) {
        self.textLabel.textColor = [self colorWithHexString:@"#FC8716"];
        self.bg.layer.borderColor = [self colorWithHexString:@"#FC8716"].CGColor;
    }
    else
    {
        self.textLabel.textColor = [self colorWithHexString:@"#66666"];
        self.bg.layer.borderColor = [self colorWithHexString:@"#66666"].CGColor;
    }
    
}

@end
