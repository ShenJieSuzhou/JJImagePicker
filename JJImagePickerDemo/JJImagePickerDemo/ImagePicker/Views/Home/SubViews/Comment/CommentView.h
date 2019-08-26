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
#import "JJDetailsInfoHeaderView.h"
#import "JJCommentInputView.h"
#import "JJCommentContainerView.h"
#import "JJPageInfo.h"
#import "JJWorksFrame.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CommentViewDelegate <NSObject>

- (void)jumpToCommemtDetailView:(JJTopicFrame *)topicFrame;

- (void)goToUserZoneInViewController;

- (void)pullToBlackListInViewController;

@end

@interface CommentView : UIView<UITableViewDelegate, UITableViewDataSource, JJCommentCellDelegate, JJTopicHeaderViewDelegate, JJCommentContainerViewDelegate, JJCommentInputViewDelegate, JJDetailsInfoViewDelegate>

@property (nonatomic, strong) JJDetailsInfoHeaderView *detailInfoHeader;

@property (nonatomic, strong) UITableView *commentTableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) JJTopicFrame *selecteTopicFrame;
// 评论框
@property (nonatomic, strong) JJCommentInputView *commentInputView;

@property (nonatomic, strong) JJCommentContainerView *commentContainerV;

@property (nonatomic, weak) id<CommentViewDelegate> delegate;

@property (nonatomic, strong) JJPageInfo *currentPageInfo;

@property (nonatomic, strong) HomeCubeModel *cubeModel;


- (void)show;

@end

NS_ASSUME_NONNULL_END
