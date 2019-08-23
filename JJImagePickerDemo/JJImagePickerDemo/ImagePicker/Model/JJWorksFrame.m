//
//  JJWorksFrame.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/8/22.
//  Copyright © 2019 shenjie. All rights reserved.
//

#import "JJWorksFrame.h"
#import <YYTextLayout.h>

@implementation JJWorksFrame
@synthesize workModel = _workModel;

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)initPhotoUrl:(HomeCubeModel *)work{
    NSMutableArray *photosArray = [[NSMutableArray alloc] initWithArray:work.path];
    //计算几行几列
    NSInteger photoCount = [photosArray count];
    
    switch (photoCount) {
        case 1:
            _albumRows = 1;
            _albumColums = 1;
            _isEven = NO;
            break;
        case 2:
            _albumRows = 1;
            _albumColums = 2;
            _isEven = YES;
            break;
        case 3:
            _albumRows = 1;
            _albumColums = 2;
            _isEven = NO;
            break;
        case 4:
            _albumRows = 2;
            _albumColums = 2;
            _isEven = YES;
            break;
        case 5:
            _albumRows = 2;
            _albumColums = 2;
            _isEven = NO;
            break;
        case 6:
            _albumRows = 2;
            _albumColums = 3;
            _isEven = YES;
            break;
        case 7:
            _albumRows = 2;
            _albumColums = 3;
            _isEven = NO;
            break;
        case 8:
            _albumRows = 2;
            _albumColums = 4;
            _isEven = YES;
            break;
        case 9:
            _albumRows = 2;
            _albumColums = 4;
            _isEven = NO;
            break;
        default:
            break;
    }
}

- (void)setWorkModel:(HomeCubeModel *)workModel{
    // 初始化
    [self initPhotoUrl:workModel];
    
    _workModel = workModel;
    
    // 整个宽度
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat avatarWH = 40.0f;
    
    // 头像
    CGFloat avatarX = 10.0f;
    CGFloat avatarY = 10.0f;
    CGFloat avatarW = avatarWH;
    CGFloat avatarH = avatarWH;
    self.avatarFrame = (CGRect){{avatarX , avatarY},{avatarW , avatarH}};
    
    // 关注
    CGFloat focusX = width - 90.0f;
    CGFloat focusY = avatarY;
    CGFloat focusW = 50.0f;
    CGFloat focusH = 25.0f;
    self.focusFrame = (CGRect){{focusX , focusY},{focusW , focusH}};
    
    // 布局更多
    CGFloat moreW = 30.0f;
    CGFloat moreX = width - moreW - focusW;
    CGFloat moreY = avatarY;
    CGFloat moreH = 30.0f;
    self.moreFrame = CGRectMake(moreX, moreY, moreW, moreH);
    
    // 昵称
    CGFloat nicknameX = CGRectGetMaxX(self.avatarFrame) + 10.0f;
    CGFloat nicknameY = CGRectGetMidY(self.avatarFrame);
    CGFloat nicknameW = CGRectGetMinX(self.focusFrame) - nicknameX;
    CGFloat nicknameH = moreH;
    self.nicknameFrame = CGRectMake(nicknameX, nicknameY, nicknameW, nicknameH);
    
    // 作品
    CGFloat workX = avatarX;
    CGFloat workY = CGRectGetMaxY(self.nicknameFrame);
    CGFloat workW = width - 20.0f;
    
    CGFloat workViewHeight = 0.0f;
    if(self.isEven){
        workViewHeight = (width - 10.0f) / self.albumColums * self.albumRows;
    }else{
        CGFloat firstCellHeight = (width - 10.0f)*9/16;
        workViewHeight = (width - 10.0f) / self.albumColums * self.albumRows + firstCellHeight;
    }
    CGFloat workH = workViewHeight;
    self.worksFrame = CGRectMake(workX, workY, workW, workH);
    
    // 内容
    CGFloat textX = nicknameX;
    CGSize textLimitSize = CGSizeMake(width - textX - 10, MAXFLOAT);
    CGFloat textY = CGRectGetMaxY(self.worksFrame) + CGRectGetHeight(self.worksFrame);
    CGFloat textH = [YYTextLayout layoutWithContainerSize:textLimitSize text:workModel.attributedText].textBoundingSize.height + 20.0f;
    
    self.textFrame = (CGRect){{textX , textY} , {textLimitSize.width, textH}};
    
    // 时间
    CGFloat createX = nicknameX;
    CGFloat createY = CGRectGetMaxY(self.textFrame);
    CGFloat createW = width - createX - 100;
    CGFloat createH = moreH;
    self.createTimeFrame = CGRectMake(createX, createY, createW, createH);
    
    // 点赞
    CGFloat likeW = 20.0f;
    CGFloat likeX = width - 70.0f;
    CGFloat likeY = CGRectGetMaxY(self.textFrame);
    CGFloat likeH = 20.0f;
    self.likeFrame = CGRectMake(likeX, likeY, likeW, likeH);
    
    // 点赞数
    CGFloat likeNumW = 50.0f;
    CGFloat likeNumX = width - 50.0f;
    CGFloat likeNumY = CGRectGetMaxY(self.textFrame);
    CGFloat likeNumH = 20.0f;
    self.likeNumFrame = CGRectMake(likeNumX, likeNumY, likeNumW, likeNumH);
    
    self.height = CGRectGetMaxY(self.likeNumFrame);
}

@end
