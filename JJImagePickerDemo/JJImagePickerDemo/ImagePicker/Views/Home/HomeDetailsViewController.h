//
//  HomeDetailsViewController.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/3/26.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CustomPhotoViewController.h"
#import "HomeCubeModel.h"
#import "CommentView.h"
#import "OthersMainPageViewController.h"
#import "JJCommentDetailController.h"

@interface HomeDetailsViewController : UIViewController<CommentViewDelegate, JJDetailsInfoViewDelegate>

@property (strong, nonatomic) CommentView *commentView;
@property (strong, nonatomic) HomeCubeModel *photoWork;
@property (strong, nonatomic) NSIndexPath *selectedIndex;

- (void)setWorksInfo:(HomeCubeModel *)detailInfo index:(NSIndexPath *)indexPath;

@end

