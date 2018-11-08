//
//  JJPublishPreviewCell.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/7/3.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "JJPublishPreviewCell.h"
#define PIC_EDIT_WIDTH 40.0f
#define PIC_EDIT_HEIGHT 20.0f
#define PIC_DEL_WIDTH 20.0f
#define PIC_DEL_HEIGHT 20.0f

@implementation JJPublishPreviewCell

@synthesize contentImageView = _contentImageView;
@synthesize editLabel = _editLabel;
@synthesize deleteBtn = _deleteBtn;
@synthesize indexPath = _indexPath;
@synthesize delegate = _delegate;
@synthesize isAddCell = _isAddCell;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self commonInitlization];
    }
    
    return self;
}

- (id)init{
    return [self initWithFrame:CGRectZero];
}

- (void)commonInitlization{
    _isAddCell = YES;
    //添加图片视图
    _contentImageView = [[UIImageView alloc] init];
    _contentImageView.contentMode = UIViewContentModeScaleAspectFill;
    _contentImageView.clipsToBounds = YES;
    [self.contentView addSubview:self.contentImageView];
    
    //添加 editbutton
    _editLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_editLabel setText:@"编辑"];
    [_editLabel setTextColor:[UIColor whiteColor]];
    [self.contentImageView addSubview:_editLabel];
    
    //添加 删除按钮
    _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_deleteBtn setImage:[UIImage imageNamed:@"edit_close"] forState:UIControlStateNormal];
    [_deleteBtn addTarget:self action:@selector(deleteThePhoto:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentImageView addSubview:_deleteBtn];
    
    [self isDefaultImage:_isAddCell];
}

- (void)isDefaultImage:(BOOL)flag{
    if(flag){
        [_deleteBtn setHidden:YES];
        [_editLabel setHidden:YES];
    }else{
        [_deleteBtn setHidden:NO];
        [_editLabel setHidden:NO];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.contentImageView.frame = self.contentView.bounds;
    CGRect size = self.contentImageView.frame;
    [_editLabel setFrame:CGRectMake(0, size.size.height - PIC_EDIT_HEIGHT, PIC_EDIT_WIDTH, PIC_EDIT_HEIGHT)];
    [_deleteBtn setFrame:CGRectMake(size.size.width - PIC_DEL_WIDTH, 0, PIC_DEL_WIDTH, PIC_DEL_HEIGHT)];
}

- (void)updatePublishImgCell:(BOOL)flag img:(UIImage *)image{
    [self isDefaultImage:flag];
    [self.contentImageView setImage:image];
}

- (void)deleteThePhoto:(UIButton *)sender{
    if([_delegate respondsToSelector:@selector(JJPublishCallBack:)]){
        [_delegate JJPublishCallBack:self];
    }
}

@end
