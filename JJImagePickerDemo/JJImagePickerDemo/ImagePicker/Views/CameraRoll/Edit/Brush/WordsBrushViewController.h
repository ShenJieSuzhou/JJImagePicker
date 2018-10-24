//
//  WordsBrushViewController.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/10/20.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BrushPaneView.h"
#import "TextEditView.h"
#import "CustomNaviBarView.h"
#import "WordsModel.h"


@class WordsBrushViewController;
@protocol JJWordsDelegate <NSObject>
- (void)WordsBrushViewController:(nonnull WordsBrushViewController *)viewController didAddWordsToImage:(WordsModel *)words;
@end

@interface WordsBrushViewController : UIViewController<TextEditViewDelegate,BrushPaneDelegate>
@property (strong, nonatomic) BrushPaneView *brushPaneView;
@property (strong, nonatomic) TextEditView *textEditView;
@property (strong, nonatomic) CustomNaviBarView *cusNavbar;
@property (strong, nonatomic) id<JJWordsDelegate> delegate;
@end


