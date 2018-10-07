//
//  TagEditView.h
//  testTag
//
//  Created by shenjie on 2018/9/30.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TagEditView;
@protocol TagEditViewDelegate <NSObject>
- (void)TagAdd:(TagEditView *)view tag:(NSString *)tag;
@end

@interface TagEditView : UIView<UITextFieldDelegate>

@property (nonatomic, weak) UIImageView *imageV;
@property (nonatomic, weak) UITextField *tagTextField;
@property (nonatomic, weak) UIButton *addBtn;
@property (nonatomic, weak) id<TagEditViewDelegate> delegate;

@end
