//
//  JJTagsCollectionViewCell.m
//  testTag
//
//  Created by silicon on 2018/10/4.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "JJTagsCollectionViewCell.h"

@implementation JJTagsCollectionViewCell
@synthesize tagText = _tagText;

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor clearColor];
        _tagText = [[UILabel alloc]init];
        //此处可以根据需要自己使用自动布局代码实现
        _tagText.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        _tagText.backgroundColor = [UIColor whiteColor];
        _tagText.font = [UIFont systemFontOfSize:14];
        _tagText.layer.borderWidth = 1.f;
        _tagText.layer.cornerRadius = frame.size.height * 0.5;
        _tagText.layer.masksToBounds = YES;
        _tagText.textColor = [UIColor blackColor];
        _tagText.textAlignment = NSTextAlignmentCenter;
        _tagText.layer.borderColor = [UIColor blackColor].CGColor;
        [self.contentView addSubview:_tagText];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _tagText.frame = self.bounds;
}

- (void)updateCell:(SubTagModel *)tag{
    [_tagText setText:tag.name];
}

@end
