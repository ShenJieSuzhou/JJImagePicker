//
//  GridView.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/5/31.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "GridView.h"
#import "JJCollectionViewCell.h"

#define JJ_CELL_VIDEO_IDENTIFIER @"video"
#define JJ_CELL_IMAGE_UNKNOWNTYPE @"imageorunknown"

@implementation GridView
@synthesize imagesAssetArray = _imagesAssetArray;
@synthesize selectedImageAssetArray = _selectedImageAssetArray;
@synthesize photoAlbum = _photoAlbum;

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
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
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
    
    
    
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //获得一个照片对象
    JJPhoto *imageAsset = [self.imagesAssetArray objectAtIndex:indexPath.row];
    
    NSString *identifier = nil;
    if(imageAsset.assetType == JJAssetTypeAudio){
        identifier = JJ_CELL_VIDEO_IDENTIFIER;
    }else{
        identifier = JJ_CELL_IMAGE_UNKNOWNTYPE;
    }
    
    JJCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.assetIdentifier = imageAsset.identifier;
    
    //异步请求资源对应的缩略图
    [imageAsset requestThumbnailImageWithSize:CGSizeMake(80, 80) completion:^(UIImage *result, NSDictionary *info) {
        if([cell.assetIdentifier isEqualToString:imageAsset.identifier]){
            cell.contentImageView.image = result;
        }else{
            cell.contentImageView.image = nil;
        }
    }];
    
    [cell setNeedsLayout];
    return cell;
}

@end
