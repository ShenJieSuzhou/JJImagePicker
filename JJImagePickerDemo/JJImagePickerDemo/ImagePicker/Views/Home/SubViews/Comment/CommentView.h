//
//  CommentView.h
//  CommectProj
//
//  Created by shenjie on 2019/8/6.
//  Copyright © 2019 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

#import "JJTopicFrame.h"
#import "JJCommentCell.h"
#import "JJCommentModel.h"
#import "JJCommentConstant.h"
#import "JJCommentReplay.h"
#import "JJTopicManager.h"
#import "JJUser.h"
#import "JJTopicHeaderView.h"
#import "JJTopicFooterView.h"
#import "JJCommentDecorateHeader.h"
#import "JJCommentInputView.h"
#import "JJCommentContainerView.h"
#import "JJPageInfo.h"
#import "JJDetailsInfoView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CommentViewDelegate <NSObject>

- (void)jumpToCommemtDetailView:(JJTopicFrame *)topicFrame;

@end

@interface CommentView : UIView<UITableViewDelegate, UITableViewDataSource, JJCommentCellDelegate, JJTopicHeaderViewDelegate, JJCommentContainerViewDelegate, JJCommentInputViewDelegate>

@property (nonatomic, strong) JJDetailsInfoView *decorateHeader;

@property (nonatomic, strong) UITableView *commentTableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) JJTopicFrame *selecteTopicFrame;

@property (nonatomic, copy) NSString *postId;
// 评论框
@property (nonatomic, strong) JJCommentInputView *commentInputView;

@property (nonatomic, strong) JJCommentContainerView *commentContainerV;

@property (nonatomic, weak) id<CommentViewDelegate> delegate;

@property (nonatomic, strong) JJPageInfo *currentPageInfo;


- (void)commonInitlization;

/*
 * 加载评论
 */
- (void)loadComments;

@end

NS_ASSUME_NONNULL_END
