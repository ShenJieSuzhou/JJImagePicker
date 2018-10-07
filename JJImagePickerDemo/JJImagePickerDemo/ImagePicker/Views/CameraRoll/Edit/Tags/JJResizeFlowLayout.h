//
//  JJResizeFlowLayout.h
//  testTag
//
//  Created by silicon on 2018/10/3.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JJResizeFlowLayout;
@protocol JJResizeFlowLayoutDelegate <NSObject>
//通过代理获取每个cell的高度
- (CGFloat)resizeFlowLayout:(JJResizeFlowLayout *)layout withIndexPath:(NSIndexPath *)indexPath;
@end

@interface JJResizeFlowLayout : UICollectionViewFlowLayout
@property (nonatomic, weak) id<JJResizeFlowLayoutDelegate> delegate;
@property (assign) CGFloat rowHeight;

- (void)reCalculateFrames;

@end
