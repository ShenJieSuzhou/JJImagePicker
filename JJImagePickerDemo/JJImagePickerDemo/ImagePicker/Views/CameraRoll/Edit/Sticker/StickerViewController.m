//
//  StickerViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/9/25.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "StickerViewController.h"
#import "JJLoadConfig.h"
#import "StickerCollectionView.h"
#import "StickerModel.h"


#define JJ_STICKERTOOL_HEIGHT 160
#define JJ_STICK_COLLECT_HEIGHT self.view.bounds.size.height * 0.5
#define JJ_STICK_COLLECT_WIDTH  self.view.bounds.size.width

@interface StickerViewController ()

@property (strong, nonatomic) NSMutableDictionary *stickers;
@property (strong, nonatomic) StickerCollectionView *stickerCollectionView;
@property (strong, nonatomic) NSMutableArray *selectedSticks;

@end

@implementation StickerViewController
@synthesize image = _image;
@synthesize layerV = _layerV;
@synthesize preViewImage = _preViewImage;
@synthesize stickerListView = _stickerListView;
@synthesize stickerArrays = _stickerArrays;
@synthesize delegate = _delegate;
@synthesize stickers = _stickers;
@synthesize selectedSticks = _selectedSticks;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1]];
    
    [self.stickerListView setSubToolArray:_stickerArrays];
    [self.view addSubview:self.stickerListView];
    
    //初始化贴纸
    self.selectedSticks = [[NSMutableArray alloc] init];
    [self initializeStickerModels];
    [self.view addSubview:self.stickerCollectionView];
    [self.stickerCollectionView setHidden:YES];
    
    self.layerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - JJ_STICKERTOOL_HEIGHT)];
    [self.layerV setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.layerV];
    
    //预览图
    [self.layerV addSubview:self.preViewImage];
    [self.view bringSubviewToFront:self.stickerListView];
    [self.view bringSubviewToFront:self.stickerCollectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self layoutImageView];
}

/*
 * @brief 初始化表情列表
 */
- (void)initializeStickerModels{
    NSDictionary *stickerConfig = [[JJLoadConfig getInstance] getStickercontent];
    NSMutableArray *array = [stickerConfig objectForKey:@"stickers"];
    for (int i = 0; i < [array count]; i++) {
        NSDictionary *sticker = [array objectAtIndex:i];
        NSString *name = [sticker objectForKey:@"name"];
        NSMutableArray *assets = [sticker objectForKey:@"asstes"];
        StickerModel *stickerModel = [[StickerModel alloc] init];
        [stickerModel setStickers:name withArray:assets];
        [self.stickers setValue:stickerModel forKey:name];
    }
}

#pragma mark lazyLoading
- (EditingSubToolView *)stickerListView{
    if(!_stickerListView){
        _stickerListView = [[EditingSubToolView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - JJ_STICKERTOOL_HEIGHT, self.view.bounds.size.width, JJ_STICKERTOOL_HEIGHT) ToolType:PhotoEditToolSticker size:CGSizeMake(80.0f, 120.0f)];
        _stickerListView.delegate = self;
    }
    return _stickerListView;
}

- (StickerCollectionView *)stickerCollectionView{
    if(!_stickerCollectionView){
        _stickerCollectionView = [[StickerCollectionView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - JJ_STICKERTOOL_HEIGHT - JJ_STICK_COLLECT_HEIGHT, JJ_STICK_COLLECT_WIDTH, JJ_STICK_COLLECT_HEIGHT)];
        _stickerCollectionView.delegate = self;
    }
    
    return _stickerCollectionView;
}

- (NSMutableDictionary *)stickers{
    if(!_stickers){
        _stickers = [[NSMutableDictionary alloc] init];
    }
    return _stickers;
}

#pragma mark - Image Layout
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
        self.preViewImage.center = (CGPoint){CGRectGetMidX(viewFrame), CGRectGetMidY(viewFrame)};
    }
}

#pragma mark - image process business
- (void)setEditImage:(UIImage *)image{
    if(!image){
        return;
    }
    
    _image = image;
    [self.preViewImage setImage:image];
}

- (UIImageView *)preViewImage{
    if(!_preViewImage){
        _preViewImage = [[UIImageView alloc] init];
        _preViewImage.userInteractionEnabled = YES;
        _preViewImage.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    return _preViewImage;
}


- (void)setAdjustToolArrays:(NSMutableArray *)arrays;{
    if(!arrays){
        return;
    }
    
    _stickerArrays = arrays;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if(!self.stickerCollectionView.hidden){
        [self.stickerCollectionView setHidden:YES];
    }
    
    if([self.selectedSticks count] > 0){
        for (int i = 0; i < [self.selectedSticks count]; i++) {
            StickerParttenView *stickerView = [self.selectedSticks objectAtIndex:i];
            [stickerView hideDelAndMoveBtn];
        }
    }
}

#pragma mark - StickerParttenDelegate
- (void)stickerDidTapped:(nonnull StickerParttenView *)stick{
    if([self.selectedSticks count] > 0){
        for (int i = 0; i < [self.selectedSticks count]; i++) {
            StickerParttenView *stickerView = [self.selectedSticks objectAtIndex:i];
            [stickerView hideDelAndMoveBtn];
        }
    }
    
    [stick showDelAndMoveBtn];
}


#pragma mark - PhotoSubToolEditingDelegate
- (void)PhotoEditSubEditToolDismiss{
    _preViewImage = nil;
    _layerV = nil;
    _stickerListView = nil;
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)PhotoEditSubEditToolConfirm{
    
}

- (void)PhotoEditSubEditTool:(UICollectionView *)collectionV stickerName:(NSString *)stickerName{
    StickerModel *model = [self.stickers objectForKey:stickerName];

    [UIView animateWithDuration:0.9f animations:^{
        [self.stickerCollectionView setHidden:NO];
        [self.stickerCollectionView setStickers:model.stickArray];
        [self.stickerCollectionView refreshTheSticker];
    }];
}

#pragma mark - JJStickSelectedDelegate
- (void)stickerDidSelected:(nonnull UIImage *)image withStickerTag:(NSInteger)tag{
    StickerParttenView *stickerView = [[StickerParttenView alloc] initWithFrame:CGRectMake(0, 0, 120.0f, 120.0f) sticker:image];
    stickerView.stickPtDelgate = self;
    //添加到贴纸队列中
    [self.selectedSticks addObject:stickerView];
    [self.preViewImage addSubview:stickerView];
}

- (void)stickerDidClosed{
    [UIView animateWithDuration:0.9f animations:^{
        [self.stickerCollectionView setHidden:YES];
    }];
}

@end
