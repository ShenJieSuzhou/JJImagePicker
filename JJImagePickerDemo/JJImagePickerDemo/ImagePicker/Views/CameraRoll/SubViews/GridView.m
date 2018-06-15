//
//  GridView.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/5/31.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "GridView.h"
#import "JJCollectionViewCell.h"
#import "JJCollectionViewFlowLayout.h"
#import "NSString+JJUI.h"
#import "UICollectionView+JJ.h"

#define JJ_CELL_VIDEO_IDENTIFIER @"video"
#define JJ_CELL_IMAGE_UNKNOWNTYPE @"imageOrunknown"

@implementation GridView
@synthesize imagesAssetArray = _imagesAssetArray;
@synthesize selectedImageAssetArray = _selectedImageAssetArray;
@synthesize photoAlbum = _photoAlbum;
@synthesize isAllowedMutipleSelect = _isAllowedMutipleSelect;
@synthesize maxSeledtedNum = _maxSeledtedNum;
@synthesize mDelegate = _mDelegate;


- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self commonInitlization];
    }
    
    return self;
}

- (id)init{
    return [self initWithFrame:CGRectZero];
}

- (void)commonInitlization{
    self.imagesAssetArray = [[NSMutableArray alloc] init];
    self.selectedImageAssetArray = [[NSMutableArray alloc] init];
    
    self.background = [[UIView alloc] init];
    [self addSubview:self.background];
    [self addSubview:self.photoCollectionView];
}

- (void)refreshPhotoAsset:(JJPhotoAlbum *)album{
    if(!album){
        return;
    }
    
    if(!self.imagesAssetArray){
        self.imagesAssetArray = [[NSMutableArray alloc] init];
        self.selectedImageAssetArray = [[NSMutableArray alloc] init];
    }else{
        [self.imagesAssetArray removeAllObjects];
    }
    
    //加载照片比较耗时，所以start loading
    
    //遍历相册的事情，就交由子线程去完成吧
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [album getAlbumAssetWithOptions:^(JJPhoto *result) {
            //这里需要对UI进行操作，交由主线程去处理
            dispatch_async(dispatch_get_main_queue(), ^{
                if(result){
                    [self.imagesAssetArray addObject:result];
                }else{
                    //当result为nil时，遍历照片完毕
                    [self.photoCollectionView reloadData];
                    //加载结束 stop loading
                }
                
                
            });
        }];
        
        
    });
    
    [_photoCollectionView reloadData];
}


//懒加载
-(UICollectionView *)photoCollectionView{
    if (!_photoCollectionView) {
        JJCollectionViewFlowLayout *layout = [[JJCollectionViewFlowLayout alloc] init];
        //自动网格布局
        _photoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:layout];
        //设置数据源代理
        _photoCollectionView.dataSource = self;
        _photoCollectionView.delegate = self;
        _photoCollectionView.showsVerticalScrollIndicator = NO;
        _photoCollectionView.alwaysBounceHorizontal = NO;
        [_photoCollectionView setBackgroundColor:[UIColor whiteColor]];
        [_photoCollectionView registerClass:[JJCollectionViewCell class] forCellWithReuseIdentifier:JJ_CELL_VIDEO_IDENTIFIER];
        [_photoCollectionView registerClass:[JJCollectionViewCell class] forCellWithReuseIdentifier:JJ_CELL_IMAGE_UNKNOWNTYPE];
    }
    
    return _photoCollectionView;
}

//获取缩略图尺寸
- (CGSize)referenceImageSize{
    CGFloat collectionWidth = CGRectGetWidth(self.photoCollectionView.bounds);
    CGFloat collectionSpace = self.photoCollectionView.contentInset.left + self.photoCollectionView.contentInset.right;
    CGFloat referenceWidth = 0.0f;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        
    }else{
        //如果是iPhone设备，默认显示的照片为4列
        referenceWidth = (collectionWidth - 4 * collectionSpace) / 4;
    }
    
    return CGSizeMake(referenceWidth, referenceWidth);
}


#pragma mark - collectionViewDelegate

//有多少的分组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//每个分组里有多少个item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [self.imagesAssetArray count];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(self.mDelegate && [self.mDelegate respondsToSelector:@selector(JJImagePickerViewController:selectAtIndex:)]){
        [_mDelegate JJImagePickerViewController:self selectAtIndex:indexPath];
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //获得一个照片对象
    JJPhoto *imageAsset = [self.imagesAssetArray objectAtIndex:indexPath.row];
    
    //初始化cell
    NSString *identifier = nil;
    if(imageAsset.assetType == JJAssetTypeAudio){
        identifier = JJ_CELL_VIDEO_IDENTIFIER;
    }else{
        identifier = JJ_CELL_IMAGE_UNKNOWNTYPE;
    }
    JJCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.assetIdentifier = imageAsset.identifier;
    
    //异步请求资源对应的缩略图
    [imageAsset requestThumbnailImageWithSize:[self referenceImageSize] completion:^(UIImage *result, NSDictionary *info) {
        if([cell.assetIdentifier isEqualToString:imageAsset.identifier]){
            cell.contentImageView.image = result;
        }else{
            cell.contentImageView.image = nil;
        }
    }];
    
    //为视频加上时间跟类型标记
    if(imageAsset.assetType == JJAssetTypeVideo){
        cell.videoDuration.text = [NSString jj_timeStringWithMinsAndSecsFromSecs:imageAsset.duration];
        [cell.videoView setHidden:NO];
        [cell.videoDuration setHidden:NO];
    }
    
    [cell.checkBox addTarget:self action:@selector(handleCheckBoxClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell setNeedsLayout];
    return cell;
}

//点击checkbox按钮响应事件
- (void)handleCheckBoxClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    NSIndexPath *indexPath = [self.photoCollectionView jj_indexPathForItemAtView:sender];
    JJCollectionViewCell *cell = (JJCollectionViewCell *)[self.photoCollectionView cellForItemAtIndexPath:indexPath];
    JJPhoto *imageAsset = [self.imagesAssetArray objectAtIndex:indexPath.row];
    
    if(sender.selected){
        //照片被选中，加入到队列中
        if([self.selectedImageAssetArray count] > self.maxSeledtedNum){
            NSLog(@"提示:已选达到最大数量");
            return;
        }
        
        [self.selectedImageAssetArray addObject:imageAsset];
        
        //更新UI
        
    }else{
        //取消选中状态，从队列中移除
        [self.selectedImageAssetArray removeObject:imageAsset];
        
        //更新UI
    }
}

//处理多选逻辑


@end
