//
//  PhotoEditingViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/7/26.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "PhotoEditingViewController.h"
#import "JJEditTool.h"
#import "JJLoadConfig.h"
#import "TagModel.h"
#import "JJTagView.h"
#import "WordsView.h"

#define JJ_DEFAULT_IMAGE_PADDING 50
#define JJ_EDITTOOL_HEIGHT 100

@interface PhotoEditingViewController ()
@property (nonatomic, strong) NSMutableArray *historys;
@property (nonatomic, strong) NSMutableArray *selectedStickers;
@end

@implementation PhotoEditingViewController
@synthesize delegate = _delegate;
@synthesize preViewImage = _preViewImage;
@synthesize preImage = _preImage;
@synthesize editToolView = _editToolView;
@synthesize editData = _editData;
@synthesize croppedFrame = _croppedFrame;
@synthesize angle = _angle;
@synthesize layerV = _layerV;
@synthesize historys = _historys;
@synthesize pAdjustModel = _pAdjustModel;
@synthesize parentPage = _parentPage;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1]];
    
    self.historys = [[NSMutableArray alloc] init];
    self.selectedStickers = [[NSMutableArray alloc] init];
    
    //背景色去除
    [self.customNaviBar setBackgroundColor:[UIColor whiteColor]];
    [self.jjTabBarView setHidden:YES];
    
    //返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"edit_close"] forState:UIControlStateNormal];
    [backBtn setBackgroundColor:[UIColor clearColor]];
    [backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.customNaviBar setLeftBtn:backBtn withFrame:CGRectMake(20.0f, 29.0f, 16.0f, 16.0f)];
    
    //完成
    UIButton *finishedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [finishedBtn setTitle:@"完成" forState:UIControlStateNormal];
    [finishedBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [finishedBtn.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [finishedBtn setBackgroundColor:[UIColor clearColor]];
    [finishedBtn addTarget:self action:@selector(finishedBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.customNaviBar setRightBtn:finishedBtn withFrame:CGRectMake(self.view.bounds.size.width - 60.0f, 25.0f, 40.0f, 20.0f)];
    
    //底部工具栏
    if(!self.editData){
        self.editData = [[JJLoadConfig getInstance] getCustomContent];
    }

    self.editToolView = [[EditingToolView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - JJ_EDITTOOL_HEIGHT, self.view.bounds.size.width, JJ_EDITTOOL_HEIGHT)];
    self.editToolView.delegate = self;
    self.editToolView.toolArray = [self parseDataToObject:self.editData];
    [self.view addSubview:self.editToolView];
    
    self.layerV = [[UIView alloc] initWithFrame:CGRectMake(0, self.customNaviBar.frame.size.height, self.view.bounds.size.width, self.view.bounds.size.height - JJ_EDITTOOL_HEIGHT - self.customNaviBar.frame.size.height)];
    [self.layerV setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.layerV];
    
    //预览图
    [self.layerV addSubview:self.preViewImage];
    [self.view bringSubviewToFront:self.editToolView];
    
    //调整图片的参数数值
    self.pAdjustModel = [[AdjustModel alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void)setPageJumpFrom:(PARENT_PAGE)page{
    _parentPage = page;
}

#pragma mark - Image Layout -
- (void)layoutImageView
{
    if (self.preViewImage.image == nil)
        return;
    
    CGFloat padding = 20.0f;
    
    CGRect viewFrame = self.layerV.frame;
    viewFrame.size.width -= padding;
    viewFrame.size.height -= padding;
    
    CGRect imageFrame = CGRectZero;
    imageFrame.size = self.preViewImage.image.size;
    
    if (self.preViewImage.image.size.width > viewFrame.size.width ||
        self.preViewImage.image.size.height > viewFrame.size.height)
    {
        CGFloat scale = MIN(viewFrame.size.width / imageFrame.size.width, viewFrame.size.height / imageFrame.size.height);
        imageFrame.size.width *= scale;
        imageFrame.size.height *= scale;
        imageFrame.origin.x = (CGRectGetWidth(self.layerV.frame) - imageFrame.size.width) * 0.5f;
        imageFrame.origin.y = (CGRectGetHeight(self.layerV.frame) - imageFrame.size.height) * 0.5f;
        self.preViewImage.frame = imageFrame;
    }
    else {
        imageFrame.origin.x = (CGRectGetWidth(self.layerV.frame) - imageFrame.size.width) * 0.5f;
        imageFrame.origin.y = (CGRectGetHeight(self.layerV.frame) - imageFrame.size.height) * 0.5f;
        self.preViewImage.frame = imageFrame;
//        self.preViewImage.center = (CGPoint){CGRectGetMidX(viewFrame), CGRectGetMidY(viewFrame)};
    }
}

#pragma mark - image process business
- (void)setEditImage:(UIImage *)image{
    if(!image){
        return;
    }
    
    [self.preViewImage setImage:image];
    [self layoutImageView];
}

- (UIImageView *)preViewImage{
    if(!_preViewImage){
        _preViewImage = [[UIImageView alloc] init];
        _preViewImage.userInteractionEnabled = YES;
        _preViewImage.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    return _preViewImage;
}

//返回
- (void)backBtnClick:(UIButton *)sender{
    _delegate = nil;
    _preViewImage = nil;
    _preImage = nil;
    _editToolView = nil;
    _editData = nil;
    _layerV = nil;
    _historys = nil;
    _pAdjustModel = nil;
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

//完成
- (void)finishedBtnClick:(UIButton *)sender{
    //跳转到发布页面
    _preImage = nil;
    _editToolView = nil;
    _editData = nil;
    _layerV = nil;
    _historys = nil;
    _pAdjustModel = nil;
    
    if([self.selectedStickers count] > 0){
        for (int i = 0; i < [self.selectedStickers count]; i++) {
            StickerParttenView *stickerView = [self.selectedStickers objectAtIndex:i];
            [stickerView hideDelAndMoveBtn];
        }
    }
    
    UIImage *combineImg = [self combineImagesToOne:_preViewImage];
    if(_parentPage == PAGE_GALLARY){
        
    }else if(_parentPage == PAGE_PUBLISH){
        if([_delegate respondsToSelector:@selector(AdjustImageFinished:image:)]){
            [_delegate AdjustImageFinished:self image:combineImg];
        }
    }
}

- (UIImage *)combineImagesToOne:(UIImageView *)view{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, [[UIScreen mainScreen] scale]);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (NSMutableArray *)parseDataToObject:(NSDictionary *)fieldDic{
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    if(![fieldDic objectForKey:@"field"]){
        NSLog(@" parseDataToObject error");
        return nil;
    }
    
    NSArray *tArray = [fieldDic objectForKey:@"field"];

    for (int i = 0; i < [tArray count]; i++) {
        NSDictionary *dic = [tArray objectAtIndex:i];
        NSString *title = [dic objectForKey:@"title"];
        NSString *name = [dic objectForKey:@"name"];
        NSString *imagePath = [dic objectForKey:@"imagePath"];
        NSMutableArray *subTools = [dic objectForKey:@"subTools"];
        
        JJEditToolType toolType;
        if([name isEqualToString:@"crop"]){
            toolType = JJEditToolCrop;
        }else if([name isEqualToString:@"adjust"]){
            toolType = JJEditToolAdjust;
        }else if([name isEqualToString:@"filter"]){
            toolType = JJEditToolFilter;
        }else if([name isEqualToString:@"sticker"]){
            toolType = JJEditToolSticker;
        }else if([name isEqualToString:@"Brush"]){
            toolType = JJEditToolBrush;
        }else if([name isEqualToString:@"tag"]){
            toolType = JJEditToolTag;
        }else if([name isEqualToString:@"scrawl"]){
            toolType = JJEditToolscrawl;
        }else if([name isEqualToString:@"bigHeader"]){
            toolType = JJEditToolscrawl;
        }
    
        JJEditTool *model = [[JJEditTool alloc] initWithName:name title:title path:imagePath type:toolType array:subTools];
        [tempArray addObject:model];
    }
    
    return tempArray;
}


/**
 屏幕触摸

 @param touches
 @param event 
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if([self.selectedStickers count] > 0){
        for (int i = 0; i < [self.selectedStickers count]; i++) {
            StickerParttenView *stickerView = [self.selectedStickers objectAtIndex:i];
            [stickerView hideDelAndMoveBtn];
        }
    }
}

#pragma mark - PhotoEditingDelegate
- (void)PhotoEditingFinished:(UIImage *)image{
    
}

- (void)PhotoEditShowSubEditTool:(UICollectionView *)collectionV Index:(NSInteger)index array:(NSArray *)array{
    //switch 语句来判断跳转哪一个界面
    JJEditTool *toolModel = [self.editToolView.toolArray objectAtIndex:index];
    switch (toolModel.jjToolType) {
        case JJEditToolCrop:{
            JJCropViewController *jjCropView = [[JJCropViewController alloc] initWithCroppingStyle:TOCropViewCroppingStyleDefault image:self.preViewImage.image];
            jjCropView.delegate = self;
            //加载裁剪
            [jjCropView setOptionsAray:[NSMutableArray arrayWithArray:array]];
            [self presentViewController:jjCropView animated:YES completion:^{
                
            }];
            
        }
            break;
        case JJEditToolAdjust:{
            AdjustViewController *adjustView = [AdjustViewController new];
            [adjustView setSlideValue:self.pAdjustModel];
            [adjustView setEditImage:self.preViewImage.image];
            [adjustView setAdToolArrays:array];
            [self presentViewController:adjustView animated:YES completion:^{
                
            }];
        }
            break;
        case JJEditToolFilter:{
            FilterViewController *jjFilterView = [FilterViewController new];
            jjFilterView.delegate = self;
            [jjFilterView setEditImage:self.preViewImage.image];
            [self presentViewController:jjFilterView animated:YES completion:^{
                
            }];
        }
            break;
        case JJEditToolSticker:{
            StickerViewController *jjStickerView = [StickerViewController new];
            jjStickerView.delegate = self;
            [jjStickerView setStickerArrays:[NSMutableArray arrayWithArray:array]];
            [jjStickerView setSelectedStickers:self.selectedStickers];
            [jjStickerView setEditImage:self.preViewImage.image];
            [self presentViewController:jjStickerView animated:YES completion:^{
                
            }];
        }
            break;
//        case JJEditToolWords:
//            break;
        case JJEditToolBrush:{
            WordsBrushViewController *wordsBrushView = [WordsBrushViewController new];
            wordsBrushView.delegate = self;
            [self presentViewController:wordsBrushView animated:YES completion:^{
                
            }];
        }
            break;
        case JJEditToolTag:{
            NSArray *tags = @[@"中午吃些啥",
                              @"玩儿去",
                              @"口头禅",
                              @"侧颜大赛",
                              @"我们爱着呢",
                              @"我要休假",
                              @"晴天娃娃",
                              @"杜嘉班纳",
                              @"香奈儿",
                              @"椰子鞋",
                              @"微胖女人颜值高"
                              ];
            
            NSMutableArray *testTags0 = [[NSMutableArray alloc] init];
            for(NSInteger i = 0; i < [tags count]; i++){
                SubTagModel *model = [[SubTagModel alloc] initWithID:0 Name:[tags objectAtIndex:i]];
                [testTags0 addObject:model];
            }
            
            JJTagCategoryView *tagCategoryView = [[JJTagCategoryView alloc] initWithFrame:self.view.bounds];
            tagCategoryView.delegate = self;
            [tagCategoryView setHotTags:testTags0 withHistory:_historys];
            [self.view addSubview:tagCategoryView];
        }
            break;
        case JJEditToolscrawl:{
            ScrawlViewController *scrawlViewController = [ScrawlViewController new];
            scrawlViewController.delegate = self;
            [scrawlViewController setSToolArrays:array];
            [scrawlViewController setEditImage:self.preViewImage.image];
            [self presentViewController:scrawlViewController animated:YES completion:^{
                
            }];
        }
            break;
        default:
            break;
    }
}

- (void)PhotoEditSubEditToolDismiss{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)PhotoEditSubEditToolConfirm{
    NSLog(@"hshhshshshsh");
}

#pragma mark - Cropper Delegate -
- (void)cropViewController:(JJCropViewController *)cropViewController didCropToImage:(UIImage *)image withRect:(CGRect)cropRect angle:(NSInteger)angle
{
    self.croppedFrame = cropRect;
    self.angle = angle;
    
    self.preViewImage.image = image;
    [self layoutImageView];
    [cropViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)filterViewController:(nonnull FilterViewController *)filterViewController didAddFilterToImage:(nonnull UIImage *)image{
    self.preViewImage.image = image;
    [self layoutImageView];
    
    [filterViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark -JJTagCategoryDelegate
- (void)JJTagCategory:(JJTagCategoryView *)jjTagCategoryView historyTag:(SubTagModel *)tag{
    [self.historys addObject:tag];
    [jjTagCategoryView removeFromSuperview];
    jjTagCategoryView = nil;
    
    TagModel *model = [[TagModel alloc] init];
    model.tagName = tag.name;
    model.point = CGPointZero;
    model.dircetion = TAG_DIRECTION_LEFT;
    
    JJTagView *tagView = [[JJTagView alloc] initWithTagModel:model];
    [self.preViewImage addSubview:tagView];
}

- (void)JJTagCategory:(JJTagCategoryView *)jjTagCategoryView didChooseTag:(SubTagModel *)tag{
    [jjTagCategoryView removeFromSuperview];
    jjTagCategoryView = nil;

    TagModel *model = [[TagModel alloc] init];
    model.tagName = tag.name;
    model.point = CGPointZero;
    model.dircetion = TAG_DIRECTION_LEFT;
    
    JJTagView *tagView = [[JJTagView alloc] initWithTagModel:model];
    [self.preViewImage addSubview:tagView];
}

- (void)JJTagCategoryDidCancel:(JJTagCategoryView *)jjTagCategoryView{
    [jjTagCategoryView removeFromSuperview];
    jjTagCategoryView = nil;
}

#pragma mark - ScrawlDelegate
-(void)ScrawlDidFinished:(UIImage *)scrawlImage{
    if(!scrawlImage){
        return;
    }
    [self.preViewImage setImage:scrawlImage];
}

#pragma mark - JJWordsDelegate
- (void)WordsBrushViewController:(nonnull WordsBrushViewController *)viewController didAddWordsToImage:(WordsModel *)words{
    WordsView *view = [[WordsView alloc] initWithFrame:self.preViewImage.frame];
    [view setWModel:words];
    [self.preViewImage addSubview:view];
}

#pragma mark - AdjustmentDelegate
- (void)AdjustView:(AdjustViewController *)view didFinished:(UIImage *)result model:(AdjustModel *)model{
    self.pAdjustModel = model;
    self.preViewImage.image = result;
    [self layoutImageView];
}

- (void)AdjustView:(AdjustViewController *)view didCancel:(BOOL) isCancel{
    
}

#pragma mark - JJStickDelegate
- (void)stickerViewController:(nonnull StickerViewController *)viewController didAddStickerToImage:(nonnull NSMutableArray *)stickers{
    if([stickers count] == 0 || !stickers){
        return;
    }

    for (int i = 0; i < [stickers count]; i++) {
        StickerParttenView *sticker = [stickers objectAtIndex:i];
        [self.preViewImage addSubview:sticker];
    }
}

@end
