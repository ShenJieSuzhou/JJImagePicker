//
//  HomeDetailsViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/3/26.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import "HomeDetailsViewController.h"



@interface HomeDetailsViewController ()
@end

@implementation HomeDetailsViewController
@synthesize commentView = _commentView;
@synthesize photoWork = _photoWork;
@synthesize selectedIndex = _selectedIndex;
@synthesize detailsInfoView = _detailsInfoView;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1]];
    [self.navigationItem setTitle:@"作品详情"];
    UIImage *img = [[UIImage imageNamed:@"tabbar_close"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithImage:img style:UIBarButtonItemStyleDone target:self action:@selector(clickCancelBtn:)];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    
    // 作品详情
    [self.detailsInfoView setWorksInfo:self.photoWork index:self.selectedIndex];
    [self.detailsInfoView commonInitlization];
    
    [self.commentView setDecorateHeader:self.detailsInfoView];
    [self.commentView commonInitlization];
    // 评论
    [self.view addSubview:self.commentView];
    [self.commentView loadComments];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    

}

- (void)setWorksInfo:(HomeCubeModel *)detailInfo index:(NSIndexPath *)indexPath{
    if(!detailInfo){
        return;
    }
    
    self.photoWork = detailInfo;
    self.selectedIndex = indexPath;
}

- (void)clickCancelBtn:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

/*
 * 评论试图
 */
- (CommentView *)commentView{
    if(!_commentView){
        _commentView = [[CommentView alloc] initWithFrame:CGRectZero];
        _commentView.delegate = self;
        [_commentView setPostId:_photoWork.photoId];
    }
    
    return _commentView;
}

- (JJDetailsInfoView *)detailsInfoView{
    if(!_detailsInfoView){
        _detailsInfoView = [[JJDetailsInfoView alloc] initWithFrame:CGRectZero];
    }
    
    return _detailsInfoView;
}

#pragma -mark CommentViewDelegate
- (void)jumpToCommemtDetailView:(JJTopicFrame *)topicFrame{
    JJCommentDetailController *detailComment = [JJCommentDetailController new];
    detailComment.topicFrame = topicFrame;
    [self.navigationController pushViewController:detailComment animated:YES];
}


- (void)goToUserZone{
    OthersMainPageViewController *otherZoneView = [OthersMainPageViewController new];
    [otherZoneView setUserZone:self.photoWork];
    [self.navigationController pushViewController:otherZoneView animated:YES];
}

- (void)pullToBlackList{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
