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

#define PUBLISH_VIEW_WIDTH self.view.frame.size.width
#define PUBLISH_VIEW_HEIGHT self.view.frame.size.height
#define MENU_BUTTOM_HEIGHT 80.0f
#define PUBLISH_TEXT_HEIGHT 80.0f

#define PUBLISH_IDENTIFIER @"JJPublishPreviewCell"

@interface InterestingViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, copy) NSMutableArray *selectedImages;
//UICollectionView
@property (strong, nonatomic) UICollectionView *previewCollection;
//text
@property (strong, nonatomic) JJPublicText *publicText;
//bottomMenu
@property (strong, nonatomic) JJBottomMenu *buttomMenu;


@end

@implementation InterestingViewController
@synthesize selectedImages = _selectedImages;
@synthesize previewCollection = _previewCollection;
@synthesize publicText = _publicText;
@synthesize buttomMenu = _buttomMenu;


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
    }
    return _publicText;
}

- (JJBottomMenu *)buttomMenu{
    if(!_buttomMenu){
        _buttomMenu = [[JJBottomMenu alloc] initWithFrame:CGRectMake(0, PUBLISH_VIEW_HEIGHT - MENU_BUTTOM_HEIGHT , PUBLISH_VIEW_WIDTH, MENU_BUTTOM_HEIGHT)];
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

- (void)setSelectedImages:(NSMutableArray *)selectedImages{
    if(!selectedImages){
        return;
    }
    _selectedImages = selectedImages;
    if([_selectedImages count] < 9){
        [_selectedImages addObject:[UIImage imageNamed:@"addImg"]];
    }
}

- (void)OnCancelCLick:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
    //调整图片
    
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JJPublishPreviewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PUBLISH_IDENTIFIER forIndexPath:indexPath];
    if([[self.selectedImages objectAtIndex:indexPath.row] isKindOfClass:[UIImage class]]){
        [cell updatePublishImgCell:YES img:[self.selectedImages objectAtIndex:indexPath.row]];
    }else{
        //获得一个照片对象
        JJPhoto *imageAsset = [self.selectedImages objectAtIndex:indexPath.row];
        //异步请求资源对应的缩略图
        [imageAsset requestThumbnailImageWithSize:[self referenceImageSize] completion:^(UIImage *result, NSDictionary *info) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [cell updatePublishImgCell:NO img:result];
            });
        }];
    }
    
    return cell;
}

//获取缩略图尺寸
- (CGSize)referenceImageSize{
    CGFloat collectionWidth = CGRectGetWidth(self.previewCollection.bounds);
    CGFloat collectionSpace = self.previewCollection.contentInset.left + self.previewCollection.contentInset.right;
    CGFloat referenceWidth = 0.0f;
    
    referenceWidth = (collectionWidth - 4 * collectionSpace) / 3;
    return CGSizeMake(referenceWidth, referenceWidth);
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


@end
