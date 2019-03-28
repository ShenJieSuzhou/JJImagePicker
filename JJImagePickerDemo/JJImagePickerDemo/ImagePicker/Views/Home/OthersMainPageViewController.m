//
//  OthersMainPageViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/3/27.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import "OthersMainPageViewController.h"
#import "OthersIDView.h"
#import "WorksView.h"
#import "GlobalDefine.h"
#import "OriginalWorksViewController.h"
#import "CandyFansViewController.h"


#define USERVIEW_WIDTH self.view.frame.size.width
#define USERVIEW_HEIGHT self.view.frame.size.height
#define DETAIL_INFO_VIEW_HEIGHT 300.0f

@interface OthersMainPageViewController ()<OthersIDInfoViewDelegate, WorksViewDelegate>

@property (strong, nonatomic) OthersIDView *othersIDView;
@property (strong, nonatomic) WorksView *workView;

@property (copy, nonatomic) NSString *fansId;
@property (strong, nonatomic) UIImage *avaterImg;
@property (copy, nonatomic) NSString *nikeName;
@property (copy, nonatomic) NSArray *fansList;

@end

@implementation OthersMainPageViewController
@synthesize othersIDView = _othersIDView;
@synthesize workView = _workView;
@synthesize fansId = _fansId;
@synthesize avaterImg = _avaterImg;
@synthesize nikeName = _nikeName;
@synthesize fansList = _fansList;


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1]];
    [self.view addSubview:self.othersIDView];
    [self.view addSubview:self.workView];
    
    // 获取用户数据
    [self requestUserInfo];
}

- (void)setDetailInfo:(NSString *)fansId avater:(UIImage *)avater name:(NSString *)name{
    self.fansId = fansId;
    self.avaterImg = avater;
    self.nikeName = name;
}

-(OthersIDView *)othersIDView{
    if(!_othersIDView){
        _othersIDView = [[OthersIDView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, DETAIL_INFO_VIEW_HEIGHT)];
        _othersIDView.delegate = self;
    }
    return _othersIDView;
}

/**
 发布作品试图
 
 @return 发布作品试图
 */
- (WorksView *)workView{
    if(!_workView){
        _workView = [[WorksView alloc] initWithFrame:CGRectMake(0, DETAIL_INFO_VIEW_HEIGHT + 10.0f, self.view.frame.size.width, self.view.frame.size.height - DETAIL_INFO_VIEW_HEIGHT - 10.0f)];
        _workView.delegate = self;
    }
    return _workView;
}

/**
 获取用户信息
 */
- (void)requestUserInfo{
    [SVProgressHUD show];
    __weak typeof(self) weakSelf = self;
    [HttpRequestUtil JJ_GetMyWorksArray:OTHERS_DATA_REQUEST token:[JJTokenManager shareInstance].getUserToken userid:[JJTokenManager shareInstance].getUserID fansid:self.fansId callback:^(NSDictionary *data, NSError *error) {
        [SVProgressHUD dismiss];
        if(error){
            [SVProgressHUD showErrorWithStatus:JJ_NETWORK_ERROR];
            [SVProgressHUD dismissWithDelay:1.0f];
            return ;
        }
        
        if([[data objectForKey:@"result"] isEqualToString:@"0"]){
            if([[data objectForKey:@"errorCode"] isEqualToString:@"1008"]){
                [SVProgressHUD showErrorWithStatus:JJ_LOGININFO_EXPIRED];
                [SVProgressHUD dismissWithDelay:1.0f];
                return;
            }
            [SVProgressHUD showErrorWithStatus:JJ_PULLDATA_ERROR];
            [SVProgressHUD dismissWithDelay:1.0f];
            return;
        }
        
        // 用户信息
        NSString *fans = [data objectForKey:@"fans"];
        NSString *likesCount = [data objectForKey:@"likesCount"];
        NSArray *nFansList = [data objectForKey:@"fansList"];
        weakSelf.fansList = nFansList;
        
        NSArray *works = [[data objectForKey:@"works"] copy];
        NSMutableArray *photoList = [[NSMutableArray alloc] init];
        for(int i = 0; i < [works count]; i++){
            NSDictionary *dic = [works objectAtIndex:i];
            NSString *userId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"userid"]];
            NSString *photoId = [NSString stringWithFormat:@"%@", [dic objectForKey:@"photoid"]];
            NSString *pathStr = [dic objectForKey:@"path"];
            NSString *postTime = [dic objectForKey:@"postTime"];
            NSString *work = [dic objectForKey:@"work"];
            NSString *likeNum = [NSString stringWithFormat:@"%@",[dic objectForKey:@"likeNum"]];
            NSArray *photos = [pathStr componentsSeparatedByString:@"|"];
            
            Works *postWork = [[Works alloc] initWithPath:photos photoID:photoId userid:userId work:work time:postTime like:likeNum];
            [photoList addObject:postWork];
        }
        
        NSString *postCount = [NSString stringWithFormat:@"%lu", (unsigned long)[photoList count]];
        [weakSelf refreshViewInfo:weakSelf.avaterImg nickname:weakSelf.nikeName postCount:postCount fans:fans likes:likesCount posts:photoList];
    }];
}

/**
 刷新用户界面
 */
- (void)refreshViewInfo:(UIImage *)avater nickname:(NSString *)name postCount:(NSString *)postCount fans:(NSString *)fans likes:(NSString *)likes posts:(NSMutableArray *)posts{
    
    [self.othersIDView updateViewInfo:avater name:name worksCount:postCount fans:fans likes:likes];
    [self.workView updateWorksArray:posts];
}


#pragma mark - OthersIDInfoViewDelegate
- (void)showFansListCallback{
    CandyFansViewController *fansView = [CandyFansViewController new];
    [fansView setCandyFansList:[NSMutableArray arrayWithArray:self.fansList]];
    [self.navigationController pushViewController:fansView animated:YES];
}

- (void)focusHerCandy{
    
}

- (void)goback{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - WorksViewDelegate
- (void)goToWorksDetailViewCallback:(Works *)work{
    OriginalWorksViewController *origialWorksView = [OriginalWorksViewController new];
    [origialWorksView setWorksInfo:work];
    [self.navigationController pushViewController:origialWorksView animated:YES];
}

@end
