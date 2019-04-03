//
//  HomeViewController.m
//  JJImagePickerDemo
//
//  Created by silicon on 2018/10/28.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeContentmManager.h"
#import "JSONKit.h"
#import "HttpRequestUrlDefine.h"
#import "JJLoginViewController.h"
#import "LoginSessionManager.h"
#import "HttpRequestUtil.h"
#import "JJTokenManager.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "GlobalDefine.h"
#import "HomeCubeModel.h"
#import "HomeDetailsViewController.h"
#import <MJRefresh/MJRefresh.h>

#define JJDEBUG YES

static int jjPageSize = 10;

@implementation HomeViewController

@synthesize currentPageInfo = _currentPageInfo;
@synthesize homePhotoView = _homePhotoView;
@synthesize homeTopView = _homeTopView;
@synthesize photoDataSource = _photoDataSource;

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 用户是否登录
    if(![[LoginSessionManager getInstance] isUserLogin]){
        [self popLoginViewController];
    }else{
        // 网络请求
        [self reloadHomedata:0 size:jjPageSize];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveLoginSuccess:) name:LOGINSUCCESS_NOTIFICATION object:nil];
    
    // 数据源
    _photoDataSource = [[NSMutableArray alloc] init];
    
    // 添加 topview
    [self.view addSubview:self.homeTopView];
    
    // 添加 CollectionView
    [self.view addSubview:self.homePhotoView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (HomePhotosCollectionView *)homePhotoView{
    if(!_homePhotoView){
        _homePhotoView = [[HomePhotosCollectionView alloc] initWithFrame:CGRectMake(0, 120.0f, self.view.frame.size.width, self.view.frame.size.height - 120.0f)];
        _homePhotoView.delegate = self;
    }
    return _homePhotoView;
}

- (HomeTopView *)homeTopView{
    if(!_homeTopView){
        _homeTopView = [[HomeTopView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 120.0f)];
    }
    return _homeTopView;
}

// 加载首页信息
- (void)reloadHomedata:(int) page size:(int)pageSize{
    __weak typeof(self) weakSelf = self;
    [HttpRequestUtil JJ_HomePageRquestData:HOT_DISCOVERY_REQUEST token:[JJTokenManager shareInstance].getUserToken userid:[JJTokenManager shareInstance].getUserID pageIndex:[NSString stringWithFormat:@"%d", page] pageSize:[NSString stringWithFormat:@"%d", pageSize] callback:^(NSDictionary *data, NSError *error) {
        if(error){
            [self.homePhotoView.photosCollection.mj_header endRefreshing];
            [self.homePhotoView.photosCollection.mj_footer endRefreshing];
            [SVProgressHUD showErrorWithStatus:JJ_NETWORK_ERROR];
            [SVProgressHUD dismissWithDelay:2.0f];
            return ;
        }
        
        if(!data || [[data objectForKey:@"result"] isEqualToString:@"0"]){
            [SVProgressHUD showErrorWithStatus:JJ_PULLDATA_ERROR];
            [SVProgressHUD dismissWithDelay:2.0f];
            return;
        }else{
            //用户作品
            NSArray *works = [[data objectForKey:@"works"] copy];
            NSMutableArray *photoList = [[NSMutableArray alloc] init];
            for(int i = 0; i < [works count]; i++){
                NSDictionary *dic = [works objectAtIndex:i];
                NSString *photoId = [dic objectForKey:@"photoid"];
                NSString *userId = [dic objectForKey:@"userid"];
                NSString *pathStr = [dic objectForKey:@"path"];
                NSString *name = [dic objectForKey:@"name"];
                NSString *work = [dic objectForKey:@"work"];
                int likeNum = [[dic objectForKey:@"likeNum"] intValue];
                int hasLike = [[dic objectForKey:@"hasLiked"] intValue];
                NSString *iconUrl = [dic objectForKey:@"iconUrl"];
                NSString *postTime = [dic objectForKey:@"postTime"];
                NSArray *photos = [pathStr componentsSeparatedByString:@"|"];
            
                HomeCubeModel *homeCube = [[HomeCubeModel alloc] initWithPath:photos photoId:photoId userid:userId work:work name:name like:likeNum avater:iconUrl time:postTime hasLiked:hasLike == 1?YES:NO];
                [photoList addObject:homeCube];
            }
            
            // 当前页
            int currentPage = [[data objectForKey:@"currentPage"] intValue];
            JJPageInfo *pageInfo = [[JJPageInfo alloc] initWithTotalPage:0 size:jjPageSize currentPage:currentPage];
            
            [weakSelf latestInfoRequestCallBack:pageInfo photoList:photoList];
        }
    }];
}

// 加载更多首页信息
- (void)loadMoreHomedata:(int) page size:(int)pageSize{
    __weak typeof(self) weakSelf = self;
    [HttpRequestUtil JJ_HomePageRquestData:HOT_DISCOVERY_REQUEST token:[JJTokenManager shareInstance].getUserToken userid:[JJTokenManager shareInstance].getUserID pageIndex:[NSString stringWithFormat:@"%d", page] pageSize:[NSString stringWithFormat:@"%d", pageSize] callback:^(NSDictionary *data, NSError *error) {
        if(error){
            [self.homePhotoView.photosCollection.mj_header endRefreshing];
            [self.homePhotoView.photosCollection.mj_footer endRefreshing];
            [SVProgressHUD showErrorWithStatus:JJ_NETWORK_ERROR];
            [SVProgressHUD dismissWithDelay:2.0f];
            return ;
        }
        
        if(!data || [[data objectForKey:@"result"] isEqualToString:@"0"]){
            [SVProgressHUD showErrorWithStatus:JJ_PULLDATA_ERROR];
            [SVProgressHUD dismissWithDelay:2.0f];
            return;
        }else{
            //用户作品
            NSArray *works = [[data objectForKey:@"works"] copy];
            NSMutableArray *photoList = [[NSMutableArray alloc] init];
            for(int i = 0; i < [works count]; i++){
                NSDictionary *dic = [works objectAtIndex:i];
                NSString *photoId = [dic objectForKey:@"photoid"];
                NSString *userId = [dic objectForKey:@"userid"];
                NSString *pathStr = [dic objectForKey:@"path"];
                NSString *name = [dic objectForKey:@"name"];
                NSString *work = [dic objectForKey:@"work"];
                int likeNum = [[dic objectForKey:@"likeNum"] intValue];
                int hasLike = [[dic objectForKey:@"hasLiked"] intValue];
                NSString *iconUrl = [dic objectForKey:@"iconUrl"];
                NSString *postTime = [dic objectForKey:@"postTime"];
                NSArray *photos = [pathStr componentsSeparatedByString:@"|"];
                
                HomeCubeModel *homeCube = [[HomeCubeModel alloc] initWithPath:photos photoId:photoId userid:userId work:work name:name like:likeNum avater:iconUrl time:postTime hasLiked:hasLike == 1?YES:NO];
                [photoList addObject:homeCube];
            }
            
            // 当前页
            int currentPage = [[data objectForKey:@"currentPage"] intValue];
            JJPageInfo *pageInfo = [[JJPageInfo alloc] initWithTotalPage:0 size:jjPageSize currentPage:currentPage];
            
            [weakSelf latestInfoRequestCallBack:pageInfo photoList:photoList];
        }
    }];
}


- (void)latestInfoRequestCallBack:(JJPageInfo *)pageInfo photoList:(NSMutableArray *)photoList{
 
    if(pageInfo.currentPage == 0){
        [self.homePhotoView.photosCollection.mj_header endRefreshing];
        [self.homePhotoView.photosCollection.mj_footer endRefreshing];
    }else{
        if([photoList count] < jjPageSize){
            [self.homePhotoView.photosCollection.mj_footer setState:MJRefreshStateNoMoreData];
        }
        [self.homePhotoView.photosCollection.mj_footer endRefreshing];
    }
    
    _currentPageInfo = pageInfo;
    if(_currentPageInfo.currentPage == 0){
        [_photoDataSource removeAllObjects];
    }
    
    [_photoDataSource addObjectsFromArray:[photoList copy]];
    
    [_homePhotoView updatephotosArray:_photoDataSource];
}


/**
 弹出登录界面
 */
- (void)popLoginViewController{
    JJLoginViewController *jjLoginView = [JJLoginViewController new];
    [self.navigationController pushViewController:jjLoginView animated:YES];
}


- (void)receiveLoginSuccess:(NSNotification *)notify{
    NSLog(@"%s", __func__);
    [self TriggerRefresh];
}


-(void)TriggerRefresh{
    NSLog(@"%s", __func__);
    // 网络请求
    [self reloadHomedata:0 size:jjPageSize];
}

#pragma mark - HomePhotosViewDelegate
- (void)goToDetailViewCallback:(HomeCubeModel *)work{
    HomeDetailsViewController *homeDetailView = [HomeDetailsViewController new];
    [homeDetailView setWorksInfo:work];
    [self.navigationController pushViewController:homeDetailView animated:YES];
}

// 下拉刷新
-(void)downPullFreshData:(MJRefreshHeader *)mjHeader{
    [self reloadHomedata:0 size:jjPageSize];
}

// 上拉获取更多数据
- (void)upPullFreshData:(MJRefreshFooter *)mjFooter{
    [self loadMoreHomedata:_currentPageInfo ? _currentPageInfo.currentPage + 1 : 0 size:jjPageSize];
}

@end
