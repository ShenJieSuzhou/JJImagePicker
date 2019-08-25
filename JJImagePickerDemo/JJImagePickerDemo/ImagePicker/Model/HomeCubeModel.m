//
//  HomeCubeModel.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/3/26.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import "HomeCubeModel.h"
#import <YYText.h>
#import "JJCommentConstant.h"


@implementation HomeCubeModel
@synthesize hasFocused = _hasFocused;
@synthesize hasLiked = _hasLiked;
@synthesize likeNum = _likeNum;

- (instancetype)initWithPath:(NSArray *)path photoId:(NSString *)photoId userid:(NSString *)userid work:(NSString *)work name:(NSString *)name like:(int)likes avater:(NSString *)avater time:(NSString *)postTime hasLiked:(BOOL)hasLiked hasFocused:(BOOL)hasFocused isYourWork:(BOOL)isYourWork{
    self = [super init];
    if(self){
        self.photoId = [photoId copy];
        self.path = [path copy];
        self.userid = [userid copy];
        self.work = [work copy];
        self.name = [name copy];
        self.likeNum = likes;
        self.iconUrl = [avater copy];
        self.postTime = [postTime copy];
        self.hasLiked = hasLiked;
        self.isYourWork = isYourWork;
        self.hasFocused = hasFocused;
    }
    return self;
}

- (NSAttributedString *)attributedText
{
    if (self.work == nil) return nil;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.work];
    attributedString.yy_font = JJFont(JJPxConvertPt(14.0f), NO);
    attributedString.yy_color = [UIColor blackColor];
    attributedString.yy_lineSpacing = 12.0f;
    return attributedString;
}

@end
