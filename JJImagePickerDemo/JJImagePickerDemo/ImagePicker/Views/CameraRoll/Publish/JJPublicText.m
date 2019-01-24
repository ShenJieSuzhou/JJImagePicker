//
//  JJPublicText.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/11/5.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "JJPublicText.h"
#import "NSString+HNEmojiExtension.h"
@implementation JJPublicText
@synthesize publishText = _publishText;
@synthesize delegate = _delegate;
@synthesize isFaceDel = _isFaceDel;

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
    //添加图片视图
//    _publishText = [[UITextView alloc] init];
//    _publishText.delegate = self;
//    _publishText.placeholder = @"这一刻的想法...";
//    [_publishText setFont:[UIFont systemFontOfSize:18.0f]];
//    _publishText.placeholderColor = [UIColor lightGrayColor];
//    [self addSubview:_publishText];
    
    _publishText = [YYTextView new];
    _publishText.font = [UIFont systemFontOfSize:18.0f];
    _publishText.delegate = self;
    _publishText.placeholderText = @"这一刻的想法...";
    _publishText.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
    [self addSubview:_publishText];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_publishText setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}

- (void)faceClick:(NSString*)faceName andFaceNumber:(NSInteger)number{
//    if ([faceName isEqualToString:@"[删除]"]) {
//        self.isFaceDel = YES;
//        [self textView:_publishText shouldChangeTextInRange:NSMakeRange(_publishText.text.length - 1, 1) replacementText:@""];
//    }else{
//        _publishText.text = [_publishText.text stringByAppendingString:faceName];
//        [self textViewDidChange:_publishText];
//    }
}

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
//    [_delegate textViewShouldBeginEditing:_publishText];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//    //对于退格删除键开放限制
//    if (text.length == 0) {
//        //判断删除的文字是否符合表情文字规则
//        NSString *deleteText = [textView.text substringWithRange:range];
//        NSUInteger location = range.location;
//        NSUInteger length = range.length;
//
//        if ([deleteText isEqualToString:@"]"]){
//            NSString *subText;
//            while (YES) {
//                if (location == 0) {
//                    return YES;
//                }
//                location -- ;
//                length ++ ;
//                subText = [textView.text substringWithRange:NSMakeRange(location, length)];
//                if (([subText hasPrefix:@"["] && [subText hasSuffix:@"]"])) {
//                    break;
//                }
//            }
//            textView.text = [textView.text stringByReplacingCharactersInRange:NSMakeRange(location, length) withString:@""];
//            [textView setSelectedRange:NSMakeRange(location, 0)];
//            [self textViewDidChange:_publishText];
//            return NO;
//        }else{
//            if (self.isFaceDel ==YES) {
//                NSLog(@"deleteText:%@",deleteText);
//                if (textView.text.length!=0) {
//
//                    textView.text = [textView.text stringByReplacingCharactersInRange:range withString:@""];
//                    [textView setSelectedRange:NSMakeRange(location, 0)];
//                    [self textViewDidChange:_publishText];
//                }
//
//            }
//            self.isFaceDel = NO;
//        }
//    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
//     [self.publishText scrollRangeToVisible:NSMakeRange(self.publishText.text.length, 1)];
}

@end
