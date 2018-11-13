//
//  InterestingViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/7/3.
//  Copyright © 2018年 shenjie. All rights reserved.
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


#define PUBLISH_VIEW_WIDTH self.view.frame.size.width
#define PUBLISH_VIEW_HEIGHT self.view.frame.size.height
#define MENU_BUTTOM_HEIGHT 100.0f
#define PUBLISH_TEXT_HEIGHT 80.0f

#define PUBLISH_IDENTIFIER @"JJPublishPreviewCell"

@interface InterestingViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,JJBottomMenuDelegate,JJPublicTextDelegate,JJPublishCellDelegate,AdjustImageFinishedDelegate,PhotosViewPublishDelegate>

//jjphoto array
@property (nonatomic, strong) NSMutableArray *selectedJJPhotos;
//uiimage array
@property (nonatomic, strong) NSMutableArray *selectedImages;
//UICollectionView
@property (strong, nonatomic) UICollectionView *previewCollection;
//text
@property (strong, nonatomic) JJPublicText *publicText;
//bottomMenu
@property (strong, nonatomic) JJBottomMenu *buttomMenu;
//emoj
@property (strong, nonatomic) JJEmojKeyboard *emojKeyboard;
//选择调整图片的索引
@property (assign) NSInteger currentIndex;


@end

@implementation InterestingViewController
@synthesize selectedImages = _selectedImages;
@synthesize previewCollection = _previewCollection;
@synthesize publicText = _publicText;
@synthesize buttomMenu = _buttomMenu;
@synthesize currentIndex = _currentIndex;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.customNaviBar setBackgroundColor:[UIColor lightGrayColor]];
    
    //取消
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeSystem];
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(OnCancelCLick:) forControlEvents:UIControlEventTouchUpInside];
    [self setNaviBarLeftBtn:cancel];
    
    //发表
    UIButton *publish = [UIButton buttonWithType:UIButtonTypeSystem];
    [publish setTitle:@"发表" forState:UIControlStateNormal];
    [publish addTarget:self action:@selector(OnPublishCLick:) forControlEvents:UIControlEventTouchUpInside];
    [self setNaviBarRightBtn:publish];
    
    //不显示
    [self.jjTabBarView setHidden:YES];
    
    [self.view addSubview:self.publicText];
    [self.view addSubview:self.previewCollection];
    [self.view addSubview:self.buttomMenu];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self addKeyBoardNotification];
    
    self.emojKeyboard = [[JJEmojKeyboard alloc] initWithFrame:CGRectMake(0, PUBLISH_VIEW_HEIGHT, PUBLISH_VIEW_WIDTH, 200.0f)];
    self.emojKeyboard.delegate = self.publicText;
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
- (JJPublicText *)publicText{
    if(!_publicText){
        _publicText = [[JJPublicText alloc] initWithFrame:CGRectMake(10, self.customNaviBar.bounds.size.height, PUBLISH_VIEW_WIDTH - 20.0f, PUBLISH_TEXT_HEIGHT)];
        _publicText.delegate = self;
    }
    return _publicText;
}

- (JJBottomMenu *)buttomMenu{
    if(!_buttomMenu){
        _buttomMenu = [[JJBottomMenu alloc] initWithFrame:CGRectMake(0, PUBLISH_VIEW_HEIGHT - MENU_BUTTOM_HEIGHT , PUBLISH_VIEW_WIDTH, MENU_BUTTOM_HEIGHT)];
        _buttomMenu.delegate = self;
    }
    return _buttomMenu;
}

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

- (void)setSeleImages:(NSMutableArray *)images{
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

    if([self.selectedImages count] < 9){
        [self.selectedImages addObject:[UIImage imageNamed:@"addImg"]];
    }
}

- (void)OnCancelCLick:(UIButton *)sender{
    self.isPublishViewAsk = NO;
    UIViewController *vc = self.presentingViewController;
    
    //要跳转的界面
    while (![vc isKindOfClass:[ViewController class]]) {
        vc = vc.presentingViewController;
    }
    
    [vc dismissViewControllerAnimated:YES completion:nil];
}

//发表
- (void)OnPublishCLick:(UIButton *)sender{
    //http 请求发送到服务器
    NSLog(@"send .... ");
    
}

#pragma mark - collectionViewDelegate
//有多少的分组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//每个分组里有多少个item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.selectedImages count];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if([self.selectedImages count] < 9 && (indexPath.row + 1) == [self.selectedImages count]){
        //添加图片
        PhotosViewController *photoViewControl = [PhotosViewController new];
        photoViewControl.delegate = self;
        photoViewControl.isPublishViewAsk = YES;
        int leftNum = (int)(JJ_MAX_PHOTO_NUM - [self.selectedImages count]);
        [photoViewControl setUpGridView:leftNum min:0];
        
        [self presentViewController:photoViewControl animated:YES completion:^{
            
        }];
    }else {
        _currentIndex = indexPath.row;
        //调整图片
        PhotoEditingViewController *editViewController = [PhotoEditingViewController new];
        [editViewController setParentPage:PAGE_PUBLISH];
        editViewController.delegate = self;
        UIImage *origanial = [self.selectedImages objectAtIndex:indexPath.row];

        [self presentViewController:editViewController animated:YES completion:^{
            [editViewController setEditImage:origanial];
        }];
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JJPublishPreviewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PUBLISH_IDENTIFIER forIndexPath:indexPath];
    cell.delegate = self;
    
    if([[self.selectedImages objectAtIndex:indexPath.row] isKindOfClass:[UIImage class]]){
        UIImage *image = [self.selectedImages objectAtIndex:indexPath.row];
        [cell updatePublishImgCell:NO asset:image];
    }

    if((indexPath.row + 1) == [self.selectedImages count]){
        [cell isDefaultImage:YES];
    }
    
    return cell;
}


#pragma mark - keyborad notification
- (void)keyboardWillShow:(NSNotification *)notif {
    
}

- (void)keyboardShow:(NSNotification *)notif {
    NSDictionary *userInfo = notif.userInfo;
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 键盘的frame
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    __weak typeof(self) weakself = self;
    [UIView animateWithDuration:duration animations:^{
        [weakself.buttomMenu setFrame:CGRectMake(0, keyboardF.origin.y - MENU_BUTTOM_HEIGHT, PUBLISH_VIEW_WIDTH, MENU_BUTTOM_HEIGHT)];
    }];
}

- (void)keyboardWillHide:(NSNotification *)notif {

}

- (void)keyboardHide:(NSNotification *)notif {

}

- (void)keyboardChangeFrame:(NSNotification *)notif{
    
}

#pragma mark - JJBottomMenuDelegate
- (void)showViewWithType:(ChatFunctionViewShowType)showType{
    if(showType == ChatFunctionViewShowFace){
        [self.publicText.publishText resignFirstResponder];
        [self.view addSubview:self.emojKeyboard];
        [UIView animateWithDuration:0.25 animations:^{
            [self.emojKeyboard setFrame:CGRectMake(0, PUBLISH_VIEW_HEIGHT - 200.0f, PUBLISH_VIEW_WIDTH, 200.0f)];
            [self.buttomMenu setFrame:CGRectMake(0, self.emojKeyboard.frame.origin.y - MENU_BUTTOM_HEIGHT, PUBLISH_VIEW_WIDTH, MENU_BUTTOM_HEIGHT)];
        } completion:nil];
    }else{
        [self.publicText.publishText becomeFirstResponder];
        [self.emojKeyboard removeFromSuperview];
    }
}

#pragma mark - JJPublicTextDelegate
- (void)textViewShouldBeginEditing:(UITextView *)publishView{
    self.buttomMenu.emojBtn.selected = NO;
}


#pragma mark - JJPublishCellDelegate
- (void)JJPublishCallBack:(JJPublishPreviewCell *)cell{
    if(!cell.obj){
        return;
    }
    JJPhoto *asset = cell.obj;
    if([self.selectedImages containsObject:asset]){
        [self.selectedImages removeObject:asset];
        if([self.selectedImages count] == 1 && [[self.selectedImages lastObject] isKindOfClass:[UIImage class]]){
            [self.selectedImages removeAllObjects];
        }
    }
    
    [self.previewCollection reloadData];
}

#pragma mark - AdjustImageFinishedDelegate
- (void)AdjustImageFinished:(UIViewController *)viewController image:(UIImage *)image{
    [viewController dismissViewControllerAnimated:YES completion:^{
    }];
    
    [self.selectedImages replaceObjectAtIndex:_currentIndex withObject:image];
    [self.previewCollection reloadData];
}

#pragma mark - PhotosViewPublishDelegate
- (void)photoViewToPublishCallback:(NSMutableArray *)imagesAsset viewCtrl:(UIViewController *)viewControl{
    if(!imagesAsset){
        return;
    }
    
    [self.selectedImages removeLastObject];
    
    for (int i = 0; i < [imagesAsset count]; i++) {
        JJPhoto *pObj = [imagesAsset objectAtIndex:i];
        [pObj requestOriginImageWithCompletion:^(UIImage *result, NSDictionary<NSString *,id> *info) {
            [self.selectedImages addObject:result];
        } withProgressHandler:^(double progress, NSError * _Nullable error, BOOL * _Nonnull stop, NSDictionary * _Nullable info) {
            
        }];
    }
    
    if([self.selectedImages count] < 9){
        [self.selectedImages addObject:[UIImage imageNamed:@"addImg"]];
    }
    
    [viewControl dismissViewControllerAnimated:YES completion:^{
        [self.previewCollection reloadData];
    }];
}

@end
