//
//  InterestingViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/7/3.
//  Copyright © 2018年 shenjie. All rights reserved.

// 注释掉了emoj表情相关代码
//

#import "InterestingViewController.h"
#import "JJPublishViewFlowLayout.h"
#import "JJPublishPreviewCell.h"
#import "JJPhoto.h"
#import "JJPublicText.h"
#import "JJBottomMenu.h"
#import "ViewController.h"
#import "UICollectionView+JJ.h"
#import "PhotoEditingViewController.h"
#import "PhotosViewController.h"
#import "GlobalDefine.h"
#import "JJImageUploadManager.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "HttpRequestUtil.h"
#import "JSONKit.h"
#import "JJTokenManager.h"
#import "HttpRequestUrlDefine.h"


#define PUBLISH_VIEW_WIDTH self.view.frame.size.width
#define PUBLISH_VIEW_HEIGHT self.view.frame.size.height
#define MENU_BUTTOM_HEIGHT 100.0f
#define PUBLISH_TEXT_HEIGHT 120.0f

#define PUBLISH_IDENTIFIER @"JJPublishPreviewCell"

@interface InterestingViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,JJBottomMenuDelegate,JJPublicTextDelegate,JJPublishCellDelegate,AdjustImageFinishedDelegate,PhotosViewPublishDelegate,UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *pScrollView;

//jjphoto array
@property (nonatomic, strong) NSMutableArray *selectedJJPhotos;
//uiimage array
@property (nonatomic, strong) NSMutableArray *selectedImages;
//UICollectionView
@property (strong, nonatomic) UICollectionView *previewCollection;
//text
@property (strong, nonatomic) JJPublicText *publicText;
//bottomMenu
//@property (strong, nonatomic) JJBottomMenu *buttomMenu;
//emoj
//@property (strong, nonatomic) JJEmojKeyboard *emojKeyboard;
//选择调整图片的索引
@property (assign) NSInteger currentIndex;

@property (strong, nonatomic) NSMutableArray *tuchuagArray;

@end

@implementation InterestingViewController
@synthesize selectedImages = _selectedImages;
@synthesize previewCollection = _previewCollection;
@synthesize publicText = _publicText;
//@synthesize buttomMenu = _buttomMenu;
@synthesize currentIndex = _currentIndex;
@synthesize pScrollView = _pScrollView;
@synthesize tuchuagArray = _tuchuagArray;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.customNaviBar setBackgroundColor:[UIColor whiteColor]];
    //标题
    [self.customNaviBar setTitle:@"新鲜事" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:18.0f]];
    
    //取消
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancel setFrame:CGRectMake(10.0f, 22.0f, 40.0f, 40.0f)];
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancel.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [cancel addTarget:self action:@selector(OnCancelCLick:) forControlEvents:UIControlEventTouchUpInside];
    [self.customNaviBar addSubview:cancel];
    
    //发表
    UIButton *publish = [UIButton buttonWithType:UIButtonTypeCustom];
    [publish setFrame:CGRectMake(self.customNaviBar.frame.size.width - 50.f, 22.0f, 40.0f, 40.0f)];
    [publish setBackgroundColor:[UIColor clearColor]];
    [publish setImage:[UIImage imageNamed:@"publish"] forState:UIControlStateNormal];
    [publish addTarget:self action:@selector(OnPublishCLick:) forControlEvents:UIControlEventTouchUpInside];
    [self.customNaviBar addSubview:publish];
    
    //不显示
    [self.jjTabBarView setHidden:YES];
    
    self.tuchuagArray = [[NSMutableArray alloc] init];
    [self.view addSubview:self.pScrollView];
    [self.pScrollView addSubview:self.publicText];
    [self.pScrollView addSubview:self.previewCollection];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self addKeyBoardNotification];
    
//    self.emojKeyboard = [[JJEmojKeyboard alloc] initWithFrame:CGRectMake(0, PUBLISH_VIEW_HEIGHT, PUBLISH_VIEW_WIDTH, 200.0f)];
//    self.emojKeyboard.delegate = self.publicText;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//添加消息中心监听
- (void)addKeyBoardNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardChangeFrame:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
}

//懒加载

- (UIScrollView *)pScrollView{
    if(!_pScrollView){
        _pScrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
        _pScrollView.delegate = self;
        _pScrollView.showsHorizontalScrollIndicator = NO;
        _pScrollView.alwaysBounceVertical = YES;
        [_pScrollView setBackgroundColor:[UIColor whiteColor]];
    }
    return _pScrollView;
}

- (JJPublicText *)publicText{
    if(!_publicText){
        _publicText = [[JJPublicText alloc] initWithFrame:CGRectMake(10, self.customNaviBar.bounds.size.height, PUBLISH_VIEW_WIDTH - 20.0f, PUBLISH_TEXT_HEIGHT)];
        _publicText.delegate = self;
    }
    return _publicText;
}

//- (JJBottomMenu *)buttomMenu{
//    if(!_buttomMenu){
//        _buttomMenu = [[JJBottomMenu alloc] initWithFrame:CGRectMake(0, PUBLISH_VIEW_HEIGHT - MENU_BUTTOM_HEIGHT , PUBLISH_VIEW_WIDTH, MENU_BUTTOM_HEIGHT)];
//        _buttomMenu.delegate = self;
//    }
//    return _buttomMenu;
//}

-(UICollectionView *)previewCollection{
    if (!_previewCollection) {
        JJPublishViewFlowLayout *layout = [[JJPublishViewFlowLayout alloc] init];
        //自动网格布局
        _previewCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(20, self.publicText.frame.origin.y + PUBLISH_TEXT_HEIGHT + 10.0f, self.view.frame.size.width - 40.0f, self.view.frame.size.height) collectionViewLayout:layout];
        //设置数据源代理
        _previewCollection.dataSource = self;
        _previewCollection.delegate = self;
        
        _previewCollection.showsVerticalScrollIndicator = NO;
        _previewCollection.alwaysBounceHorizontal = NO;
        [_previewCollection setBackgroundColor:[UIColor whiteColor]];
        [_previewCollection registerClass:[JJPublishPreviewCell class] forCellWithReuseIdentifier:PUBLISH_IDENTIFIER];
    }
    
    return _previewCollection;
}

- (void)setPublishSelectedImages:(NSMutableArray *)images{
    if(!images){
        return;
    }
    //jjphoto 数组
    self.selectedJJPhotos = images;

    //所选图片数组
    self.selectedImages = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [images count]; i++) {
        JJPhoto *pObj = [images objectAtIndex:i];
        [pObj requestOriginImageWithCompletion:^(UIImage *result, NSDictionary<NSString *,id> *info) {
            [self.selectedImages addObject:result];
        } withProgressHandler:^(double progress, NSError * _Nullable error, BOOL * _Nonnull stop, NSDictionary * _Nullable info) {

        }];
    }
}

- (void)OnCancelCLick:(UIButton *)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//发表
- (void)OnPublishCLick:(UIButton *)sender{
    //http 请求发送到服务器
    [self.tuchuagArray removeAllObjects];
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    //将所选的图片上传至云
    __weak typeof(self) weakSelf = self;
    for (int i = 0; i < [self.selectedImages count]; i++) {
        UIImage *selectImg = [self.selectedImages objectAtIndex:i];
        [[JJImageUploadManager shareInstance] uploadImageToQN:selectImg uploadResult:^(BOOL isSuccess, NSString *file) {
            if(isSuccess){
                [weakSelf.tuchuagArray addObject:file];
                if([weakSelf.tuchuagArray count] == [weakSelf.selectedImages count]){
                    [SVProgressHUD showInfoWithStatus:JJ_PUBLISH_UPLOAD_SUCCESS];
                    NSString *publishText= [[weakSelf.publicText getInterestInfo] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                    [weakSelf postMyPhotosToPublic:publishText photos:weakSelf.tuchuagArray];
                }
            }else{
                [SVProgressHUD showErrorWithStatus:JJ_PUBLISH_ERROR];
                [SVProgressHUD dismiss];
                return;
            }
        }];
    }
}


/**
 发布我的信息

 @param content 新鲜事
 @param photos 照片
 */
- (void)postMyPhotosToPublic:(NSString *)content photos:(NSMutableArray *)photos{
    NSMutableDictionary *publishDic = [[NSMutableDictionary alloc] init];
    [publishDic setValue:content forKey:@"content"];
    [publishDic setValue:photos forKey:@"photos"];
    
    NSString *jsonStr = [publishDic JSONString];
    NSLog(@"%@", jsonStr);
    __weak typeof(self) weakSelf = self;
    [HttpRequestUtil JJ_PublishMyPhotoWorks:POST_WORKS_REQUEST token:[JJTokenManager shareInstance].getUserToken photoInfo:jsonStr userid:[JJTokenManager shareInstance].getUserID callback:^(NSDictionary *data, NSError *error) {
        if(error){
            [SVProgressHUD showErrorWithStatus:JJ_NETWORK_ERROR];
            [SVProgressHUD dismissWithDelay:2.0f];
            return ;
        }
        if([[data objectForKey:@"result"] isEqualToString:@"1"]){
            //发布成功
            [SVProgressHUD showSuccessWithStatus:JJ_PUBLISH_SUCCESS];
            [SVProgressHUD dismissWithDelay:2.0f];
            [weakSelf OnCancelCLick:nil];
        }else{
            //发布失败
            [SVProgressHUD showErrorWithStatus:[data objectForKey:@"errorMsg"]];
            [SVProgressHUD dismissWithDelay:2.0f];
        }
    }];
}

#pragma mark - collectionViewDelegate
//有多少的分组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//每个分组里有多少个item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if([self.selectedImages count] < 9){
        return [self.selectedImages count] + 1;
    }else if([self.selectedImages count] == 9){
        return [self.selectedImages count];
    }
    return 1;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row < [self.selectedImages count]){
        _currentIndex = indexPath.row;
        //调整图片
        PhotoEditingViewController *editViewController = [PhotoEditingViewController new];
        [editViewController setParentPage:PAGE_PUBLISH];
        editViewController.delegate = self;
        UIImage *origanial = [self.selectedImages objectAtIndex:indexPath.row];
       
        [editViewController setEditImage:origanial];
        [self.navigationController pushViewController:editViewController animated:YES];
    }else if(indexPath.row == [self.selectedImages count]){
        if([self.selectedImages count] == 9){
            _currentIndex = indexPath.row;
            //调整图片
            PhotoEditingViewController *editViewController = [PhotoEditingViewController new];
            [editViewController setParentPage:PAGE_PUBLISH];
            editViewController.delegate = self;
            UIImage *origanial = [self.selectedImages objectAtIndex:indexPath.row];
            [editViewController setEditImage:origanial];

            [self.navigationController pushViewController:editViewController animated:YES];
        }else{
            //添加图片
            PhotosViewController *photoViewControl = [PhotosViewController new];
            photoViewControl.delegate = self;
            photoViewControl.isPublishViewAsk = YES;
            int leftNum = (int)(JJ_MAX_PHOTO_NUM - [self.selectedImages count]);
            [photoViewControl setUpGridView:leftNum min:0];
            
            [self.navigationController pushViewController:photoViewControl animated:YES];
        }
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JJPublishPreviewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PUBLISH_IDENTIFIER forIndexPath:indexPath];
    cell.delegate = self;
    
    if([self.selectedImages count] == 9){
        [cell updatePublishImgCell:NO asset:[self.selectedImages objectAtIndex:indexPath.row]];
    }else if([self.selectedImages count] < 9){
        if(indexPath.row == [self.selectedImages count]){
            [cell setAddImgBtn:[UIImage imageNamed:@"add_image"]];
        }else{
            [cell updatePublishImgCell:NO asset:[self.selectedImages objectAtIndex:indexPath.row]];
        }
    }
    
    return cell;
}


#pragma mark - keyborad notification
- (void)keyboardWillShow:(NSNotification *)notif {
    
}

- (void)keyboardShow:(NSNotification *)notif {
//    NSDictionary *userInfo = notif.userInfo;
//    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//    // 键盘的frame
//    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//
//    __weak typeof(self) weakself = self;
//    [UIView animateWithDuration:duration animations:^{
//        [weakself.buttomMenu setFrame:CGRectMake(0, keyboardF.origin.y - MENU_BUTTOM_HEIGHT, PUBLISH_VIEW_WIDTH, MENU_BUTTOM_HEIGHT)];
//    }];
}

- (void)keyboardWillHide:(NSNotification *)notif {

}

- (void)keyboardHide:(NSNotification *)notif {

}

- (void)keyboardChangeFrame:(NSNotification *)notif{
    
}

#pragma mark - JJBottomMenuDelegate
- (void)showViewWithType:(ChatFunctionViewShowType)showType{
//    if(showType == ChatFunctionViewShowFace){
//        [self.publicText.publishText resignFirstResponder];
////        [self.view addSubview:self.emojKeyboard];
//        [UIView animateWithDuration:0.25 animations:^{
//            //[self.emojKeyboard setFrame:CGRectMake(0, PUBLISH_VIEW_HEIGHT - 200.0f, PUBLISH_VIEW_WIDTH, 200.0f)];
//            [self.buttomMenu setFrame:CGRectMake(0, PUBLISH_VIEW_HEIGHT - MENU_BUTTOM_HEIGHT, PUBLISH_VIEW_WIDTH, MENU_BUTTOM_HEIGHT)];
//        } completion:nil];
//    }else{
//        [self.publicText.publishText becomeFirstResponder];
//        [self.emojKeyboard removeFromSuperview];
//    }
}

#pragma mark - JJPublicTextDelegate
- (void)textViewShouldBeginEditing:(UITextView *)publishView{
//    self.buttomMenu.emojBtn.selected = NO;
}


#pragma mark - JJPublishCellDelegate
- (void)JJPublishCallBack:(JJPublishPreviewCell *)cell{
    if([self.selectedImages containsObject:cell.imageData]){
        [self.selectedImages removeObject:cell.imageData];
    }
    
    [self.previewCollection reloadData];
}

#pragma mark - AdjustImageFinishedDelegate
- (void)AdjustImageFinished:(UIViewController *)viewController image:(UIImage *)image{
    [viewController.navigationController popViewControllerAnimated:YES];
    
    [self.selectedImages replaceObjectAtIndex:_currentIndex withObject:image];
    [self.previewCollection reloadData];
}

#pragma mark - PhotosViewPublishDelegate
- (void)photoViewToPublishCallback:(NSMutableArray *)imagesAsset viewCtrl:(UIViewController *)viewControl{
    if(!imagesAsset){
        return;
    }
    
    for (int i = 0; i < [imagesAsset count]; i++) {
        JJPhoto *pObj = [imagesAsset objectAtIndex:i];
        [pObj requestOriginImageWithCompletion:^(UIImage *result, NSDictionary<NSString *,id> *info) {
            [self.selectedImages addObject:result];
        } withProgressHandler:^(double progress, NSError * _Nullable error, BOOL * _Nonnull stop, NSDictionary * _Nullable info) {
            
        }];
    }
    
    [self.previewCollection reloadData];
    [viewControl.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //滑动就收起键盘
    [self.publicText.publishText resignFirstResponder];
}
@end
