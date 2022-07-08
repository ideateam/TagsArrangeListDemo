//
//  TagsAarrangeListView.m
//  TagsArrangeListDemo
//
//  Created by mac on 2022/5/18.
//

#import "TagsAarrangeListView.h"
#import <SDAutoLayout.h>

@implementation TagsAarrangeListView

- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

//计算tags占据的高度
/*
 contentWidth 容器宽
 */
- (double)calculateHeightWithParentContentWidth:(double)contentWidth titleArr:(NSArray *)titleArr{
    double height = 0.0;
    //屏幕宽高
    double ScreenWidth = [UIScreen mainScreen].bounds.size.width;
    //文字大小
    double fontSize = 12;
    //lable的高度
    double lableSizeHeight = 19;
    //行间距
    double horizenDistance = 10;
    //列艰巨
    double vercleDistance = 10;
    //全部行数
    NSInteger lines = 0;
    //当前行已经占用的的文字宽度
    double currentLineWidth = 0;
    for (int i = 0; i < titleArr.count; i++) {
        NSString *text = [NSString stringWithFormat:@"%@",titleArr[i]];
        if (![self judgeStringIsNull:text]) {
            continue;
        }
        float lableWidth = [self sizeWithString:text font:[UIFont systemFontOfSize:fontSize] maxSize:CGSizeMake(ScreenWidth * 3, MAXFRAG)].width + 20;
        if (lableWidth + horizenDistance + horizenDistance <= contentWidth) {
            //当前文字宽度 < 容器宽度
            if (currentLineWidth + lableWidth + horizenDistance <= contentWidth) {
                //当前行已经占用的的文字宽度 + 当前文字 <= 容器宽度
                currentLineWidth += lableWidth + horizenDistance;
            }else{
                //当前行已经占用的的文字宽度 + 当前文字 > 容器宽度
                lines += 1;
                currentLineWidth = 0;
                
                if (lableWidth >= contentWidth - horizenDistance - horizenDistance) {
                    lableWidth = contentWidth - horizenDistance - horizenDistance;
                }
                
                currentLineWidth += lableWidth + horizenDistance;
            }
        }else{
            //当前文字宽度 > 容器宽度  -> 需要换一行
            lines += 1;
            currentLineWidth = 0;
            
            if (lableWidth >= contentWidth - horizenDistance - horizenDistance) {
                lableWidth = contentWidth - horizenDistance - horizenDistance;
            }
            
            currentLineWidth += lableWidth + horizenDistance;
        }
    }
    height = (lines + 1) * (lableSizeHeight + vercleDistance) - vercleDistance;
    return height;
}
//创建子视图
- (void)setUIWithParentContentWidth:(double)contentWidth titleArr:(NSArray *)titleArr{
    
    double ScreenWidth = [UIScreen mainScreen].bounds.size.width;
    double fontSize = 12;
    double lableSizeHeight = 19;
    //行间距
    double horizenDistance = 10;
    //列艰巨
    double vercleDistance = 10;
    //全部行数
    NSInteger lines = 0;
    //当前行已经占用的的文字宽度
    double currentLineWidth = 0;
    for (int i = 0; i < titleArr.count; i++) {
        NSString *text = [NSString stringWithFormat:@"%@",titleArr[i]];
        if (![self judgeStringIsNull:text]) {
            continue;
        }
        float lableWidth = [self sizeWithString:text font:[UIFont systemFontOfSize:fontSize] maxSize:CGSizeMake(ScreenWidth * 3, MAXFRAG)].width + 20;
        if (lableWidth + horizenDistance + horizenDistance <= contentWidth) {
            //当前文字宽度 < 容器宽度
            if (currentLineWidth + lableWidth + horizenDistance <= contentWidth) {
                //当前行已经占用的的文字宽度 + 当前文字 <= 容器宽度
                UILabel *lable = [[UILabel alloc] init];
                [self addSubview:lable];
                lable.backgroundColor = [self randomColor];
                lable.text = text;
                lable.textAlignment = NSTextAlignmentCenter;
                lable.font = [UIFont systemFontOfSize:fontSize];
                lable.clipsToBounds = YES;
                lable.layer.cornerRadius = 19/2;
                
                lable.sd_layout.leftSpaceToView(self, currentLineWidth).topSpaceToView(self,lines * (lableSizeHeight + vercleDistance)).widthIs(lableWidth).heightIs(lableSizeHeight);
                
                currentLineWidth += lableWidth + horizenDistance;
                
            }else{
                //当前行已经占用的的文字宽度 + 当前文字 > 容器宽度
                lines += 1;
                currentLineWidth = 0;
                
                UILabel *lable = [[UILabel alloc] init];
                [self addSubview:lable];
                lable.backgroundColor = [self randomColor];
                lable.font = [UIFont systemFontOfSize:fontSize];
                lable.text = text;
                lable.textAlignment = NSTextAlignmentCenter;
                lable.clipsToBounds = YES;
                lable.layer.cornerRadius = 19/2;
                
                if (lableWidth >= contentWidth - horizenDistance - horizenDistance) {
                    lableWidth = contentWidth - horizenDistance - horizenDistance;
                }
                
                lable.sd_layout.leftSpaceToView(self, currentLineWidth).topSpaceToView(self,lines * (lableSizeHeight + vercleDistance)).widthIs(lableWidth).heightIs(lableSizeHeight);
                
                currentLineWidth += lableWidth + horizenDistance;
            }
        }else{
            //当前文字宽度 > 容器宽度  -> 需要换一行
            lines += 1;
            currentLineWidth = 0;
            
            UILabel *lable = [[UILabel alloc] init];
            [self addSubview:lable];
            lable.text = text;
            lable.font = [UIFont systemFontOfSize:fontSize];
            lable.textAlignment = NSTextAlignmentCenter;
            lable.backgroundColor = [self randomColor];
            lable.clipsToBounds = YES;
            lable.layer.cornerRadius = 19/2;
            
            if (lableWidth >= contentWidth - horizenDistance - horizenDistance) {
                lableWidth = contentWidth - horizenDistance - horizenDistance;
            }
            
            lable.sd_layout.leftSpaceToView(self, currentLineWidth).topSpaceToView(self,lines * (lableSizeHeight + vercleDistance)).widthIs(lableWidth).heightIs(lableSizeHeight);
            
            currentLineWidth += lableWidth + horizenDistance;
        }
    }
}

/**
 计算文本的宽高
 
 @param str 计算的文本
 @param font 文字字体大小
 @param maxSize 最大的宽高   CGSizeMake(maxWith, MAXFLOAT)
 @return 计算好的宽高
 */
- (CGSize)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize {
    CGSize size = CGSizeMake(0, 0);
    if (font) {
        NSDictionary *dict = @{NSFontAttributeName : font};
        if (![str isKindOfClass:[NSNull class]]) {
            size = [str boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) attributes:dict context:nil].size;
        }
    }
    return size;
}

/**
 判断字符串是否有值

 @param string string description
 @return return value description
 */
- (BOOL)judgeStringIsNull:(NSString *)string {
    string = [NSString stringWithFormat:@"%@", string];
    if (string && ![string isEqualToString:@""] && ![string isEqualToString:@"(null)"] && ![string isEqualToString:@"<null>"] && ![string isEqualToString:@"null"]) {
        return YES;
    }else {
        return NO;
    }
}

- (UIColor *)randomColor{
    
    UIColor * randomColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    return randomColor;
}

@end
