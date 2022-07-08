//
//  TagsAarrangeListView.h
//  TagsArrangeListDemo
//
//  Created by mac on 2022/5/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TagsAarrangeListView : UIView
//计算tags占据的高度
/*
 contentWidth 容器宽
 */
- (double)calculateHeightWithParentContentWidth:(double)contentWidth titleArr:(NSArray *)titleArr;
//创建子视图
- (void)setUIWithParentContentWidth:(double)contentWidth titleArr:(NSArray *)titleArr;
@end

NS_ASSUME_NONNULL_END
