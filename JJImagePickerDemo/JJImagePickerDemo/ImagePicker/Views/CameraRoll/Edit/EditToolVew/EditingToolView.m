//
//  EditingToolView.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/8/17.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "EditingToolView.h"
#import "EditingToolCell.h"
#import "JJEditTool.h"
#import "JJFilterManager.h"

#define JJ_PHOTO_EDITING_CELL @"PHOTO_EDITING_CELL"
#define JJ_PHOTO_EDITING_SUBTOOL_CELL @"JJ_PHOTO_EDITING_SUBTOOL_CELL"
#define SPACEING_HORIZONTAL 20.0f
#define SPACE_VERTICAL 10.0f
#define EDIT_BTN_WIDTH 40.0f
#define EDIT_BTN_HEIGHT 40.0f

@implementation EditingToolView

@synthesize toolArray = _toolArray;
@synthesize toolCollectionView = _toolCollectionView;
@synthesize delegate = _delegate;

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
    [self addSubview:self.toolCollectionView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

//懒加载
-(UICollectionView *)toolCollectionView{
    if (!_toolCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(80, 90);
        layout.collectionView.pagingEnabled = YES;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        //自动网格布局
        _toolCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:layout];
        //设置数据源代理
        _toolCollectionView.dataSource = self;
        _toolCollectionView.delegate = self;
        _toolCollectionView.scrollsToTop = NO;
        _toolCollectionView.showsVerticalScrollIndicator = NO;
        _toolCollectionView.showsHorizontalScrollIndicator = NO;
        _toolCollectionView.alwaysBounceHorizontal = NO;
        [_toolCollectionView setBackgroundColor:[UIColor whiteColor]];
        [_toolCollectionView registerClass:[EditingToolCell class] forCellWithReuseIdentifier:JJ_PHOTO_EDITING_CELL];
    }
    
    return _toolCollectionView;
}


#pragma mark - collectionViewDelegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//每个分组里有多少个item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_toolArray count];;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(collectionView == _toolCollectionView){
        //回调选择的是哪个子工具
        JJEditTool *toolModel = [self.toolArray objectAtIndex:indexPath.row];
        
        if(!toolModel.subToolArrays){
            return;
        }
        
        NSArray *subTools = toolModel.subToolArrays;
        [_delegate PhotoEditShowSubEditTool:collectionView Index:indexPath.row array:subTools];
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //初始化cell
    NSString *identifier = JJ_PHOTO_EDITING_CELL;
    EditingToolCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    JJEditTool *toolModel = [self.toolArray objectAtIndex:indexPath.row];
    NSString *asset = toolModel.imagePath;
    NSString *title = toolModel.title;
    
    UIImage *image = [UIImage imageNamed:asset];
    [cell updateCellContent:image title:title type:COMMON_CELL];
    
    return cell;
}

@end

@implementation EditingSubToolView
@synthesize subToolArray = _subToolArray;
@synthesize subToolCollectionView = _subToolCollectionView;
@synthesize cancel = _cancel;
@synthesize confirm = _confirm;
@synthesize titleLabel = _titleLabel;
@synthesize delegate = _delegate;
@synthesize originalImage = _originalImage;

- (instancetype)initWithFrame:(CGRect)frame ToolType:(PhotoEditToolType)type size:(CGSize)size{
    self = [super initWithFrame:frame];
    if(self){
        _photoEditToolType = type;
        _itemSize = size;
        [self commonInitlization];
    }
    
    return self;
}

- (id)init{
    return [self initWithFrame:CGRectZero];
}

- (void)commonInitlization{
    [self setBackgroundColor:[UIColor whiteColor]];
    self.cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancel addTarget:self action:@selector(clickCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.confirm = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.confirm addTarget:self action:@selector(clickConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self addSubview:self.subToolCollectionView];
    CGFloat height = self.subToolCollectionView.frame.size.height;
    UIImage *close = [UIImage imageNamed:@"tabbar_close"];
    UIImage *finish = [UIImage imageNamed:@"tabbar_finish"];
    
    [self.cancel setBackgroundImage:close forState:UIControlStateNormal];
    [self.cancel setFrame:CGRectMake(SPACEING_HORIZONTAL, height, close.size.width, close.size.height)];
    
    [self.confirm setBackgroundImage:finish forState:UIControlStateNormal];
    [self.confirm setFrame:CGRectMake(self.bounds.size.width - finish.size.width - SPACEING_HORIZONTAL, height, finish.size.width, finish.size.width)];
    
    [self addSubview:self.cancel];
    [self addSubview:self.confirm];
}

//懒加载
- (UICollectionView *)subToolCollectionView{
    if(!_subToolCollectionView){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = _itemSize;
        layout.collectionView.pagingEnabled = YES;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        //自动网格布局
        _subToolCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 30) collectionViewLayout:layout];
        //设置数据源代理
        _subToolCollectionView.dataSource = self;
        _subToolCollectionView.delegate = self;
        _subToolCollectionView.scrollsToTop = NO;
        _subToolCollectionView.showsVerticalScrollIndicator = NO;
        _subToolCollectionView.showsHorizontalScrollIndicator = NO;
        _subToolCollectionView.alwaysBounceHorizontal = NO;
        [_subToolCollectionView setBackgroundColor:[UIColor whiteColor]];
        [_subToolCollectionView registerClass:[EditingToolCell class] forCellWithReuseIdentifier:JJ_PHOTO_EDITING_SUBTOOL_CELL];
    }
    
    return _subToolCollectionView;
}

- (void)setSubToolArray:(NSMutableArray *)subToolArray{
    if(!subToolArray){
        return;
    }
    _subToolArray = nil;
    _subToolArray = subToolArray;
}

- (void)setBaseFilterImage:(UIImage *)original{
    //create thumbnail image
    UIImage *newImage;
    if(!original){
        newImage = nil;
    }else{
        CGSize oldSize = original.size;
        CGSize size = CGSizeMake(oldSize.width/3.0f, oldSize.height/3.0f);
        UIGraphicsBeginImageContext(size);
        [original drawInRect:CGRectMake(0, 0, size.width, size.height)];
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    _originalImage = original;
}

- (void)clickCancelBtn:(UIButton *)sender{
    //取消
    if([_delegate respondsToSelector:@selector(PhotoEditSubEditToolDismiss)]){
        [_delegate PhotoEditSubEditToolDismiss];
    }
}

- (void)clickConfirmBtn:(UIButton *)sender{
    //保存图片
    if([_delegate respondsToSelector:@selector(PhotoEditSubEditToolConfirm)]){
        [_delegate PhotoEditSubEditToolConfirm];
    }
}

#pragma mark - collectionViewDelegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//每个分组里有多少个item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_subToolArray count];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //对图片做相对应的处理操作
    NSInteger index = indexPath.row;
   
    if(_photoEditToolType == PhotoEditToolCrop){
        if(![_delegate respondsToSelector:@selector(PhotoEditSubEditTool:Tools:)]){
            return;
        }
        
        if(index == 0){
            [_delegate PhotoEditSubEditTool:collectionView Tools:JJAspectRatioPresetSquare];
        }else if(index == 1){
            [_delegate PhotoEditSubEditTool:collectionView Tools:JJAspectRatioPreset3x4];
        }else if(index == 2){
            [_delegate PhotoEditSubEditTool:collectionView Tools:JJAspectRatioPreset4x3];
        }else if(index == 3){
            [_delegate PhotoEditSubEditTool:collectionView Tools:JJAspectRatioPreset9x16];
        }else if(index == 4){
            [_delegate PhotoEditSubEditTool:collectionView Tools:JJAspectRatioPreset16x9];
        }else if(index == 5){
            [_delegate PhotoEditSubEditTool:collectionView Tools:JJRotateViewClockwise];
        }
    }else if(_photoEditToolType == PhotoEditToolAdjust){
        if(![_delegate respondsToSelector:@selector(PhotoEditSubEditTool:adjustType:)]){
            return;
        }
        
        if(index == 0){
            [_delegate PhotoEditSubEditTool:collectionView adjustType:JJSmoothSkinAdjust];
        }else if(index == 1){
            [_delegate PhotoEditSubEditTool:collectionView adjustType:JJExposureAdjust];
        }else if(index == 2){
            [_delegate PhotoEditSubEditTool:collectionView adjustType:JJTemperatureAdjsut];
        }else if(index == 3){
            [_delegate PhotoEditSubEditTool:collectionView adjustType:JJContrastAdjust];
        }else if(index == 4){
            [_delegate PhotoEditSubEditTool:collectionView adjustType:JJSaturationAdjsut];
        }else if(index == 5){
            [_delegate PhotoEditSubEditTool:collectionView adjustType:JJShapeAdjust];
        }else if(index == 6){
            
        }else if(index == 7){
            [_delegate PhotoEditSubEditTool:collectionView adjustType:JJDarkangleAdjust];
        }
    
    }else if(_photoEditToolType == PhotoEditToolFilter){
        NSDictionary *tool = [self.subToolArray objectAtIndex:indexPath.row];
        NSString *filterName = [tool objectForKey:@"name"];
        if(![_delegate respondsToSelector:@selector(PhotoEditSubEditTool:filterName:)]){
            return;
        }
        
        [_delegate PhotoEditSubEditTool:collectionView filterName:filterName];
    }else if(_photoEditToolType == PhotoEditToolSticker){
        NSDictionary *tool = [self.subToolArray objectAtIndex:indexPath.row];
        NSString *name = [tool objectForKey:@"name"];
        if(![_delegate respondsToSelector:@selector(PhotoEditSubEditTool:stickerName:)]){
            return;
        }
        
        [_delegate PhotoEditSubEditTool:collectionView stickerName:name];
    }else if(_photoEditToolType == PhotoEditToolScrawl){
        if(![_delegate respondsToSelector:@selector(PhotoEditSubEditTool:actionType:)]){
            return;
        }
        
        if(index == 0){
            [_delegate PhotoEditSubEditTool:collectionView actionType:PhotoEditScrawl_Pen_1X];
        }else if(index == 1){
            [_delegate PhotoEditSubEditTool:collectionView actionType:PhotoEditScrawl_Pen_2X];
        }else if(index == 2){
            [_delegate PhotoEditSubEditTool:collectionView actionType:PhotoEditScrawl_Pen_3X];
        }else if(index == 3){
            [_delegate PhotoEditSubEditTool:collectionView actionType:PhotoEditScrawl_Pen_4X];
        }else if(index == 4){
            [_delegate PhotoEditSubEditTool:collectionView actionType:PhotoEditScrawl_Pre];
        }else if(index == 5){
            [_delegate PhotoEditSubEditTool:collectionView actionType:PhotoEditScrawl_Next];
        }
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //初始化cell
    NSString *identifier = JJ_PHOTO_EDITING_SUBTOOL_CELL;
    EditingToolCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    NSDictionary *tool = [self.subToolArray objectAtIndex:indexPath.row];
    if(_photoEditToolType == PhotoEditToolCrop){
        NSString *asset = [tool objectForKey:@"imagePath"];
        NSString *title = [tool objectForKey:@"name"];
        
        [cell updateCellContent:[UIImage imageNamed:asset] title:title type:COMMON_CELL];
    }else if(_photoEditToolType == PhotoEditToolFilter){
        NSString *filterName = [tool objectForKey:@"name"];
        NSString *title = [tool objectForKey:@"title"];
    
        //thumbnail add filters
        UIImage *result = [[JJFilterManager getInstance] renderImage:filterName image:_originalImage];
        [cell updateCellContent:result title:title type:FILTER_CELL];
    }else if(_photoEditToolType == PhotoEditToolAdjust){
        NSString *title = [tool objectForKey:@"name"];
        NSString *asset = [tool objectForKey:@"imagePath"];
        
        [cell updateCellContent:[UIImage imageNamed:asset] title:title type:COMMON_CELL];
    }else if(_photoEditToolType == PhotoEditToolSticker){
        NSString *title = [tool objectForKey:@"name"];
        NSString *asset = [tool objectForKey:@"imagePath"];
        [cell updateCellContent:[UIImage imageNamed:asset] title:title type:STICKER_CELL];
    }else if(_photoEditToolType == PhotoEditToolScrawl){
        NSString *title = [tool objectForKey:@"name"];
        NSString *asset = [tool objectForKey:@"imagePath"];
        [cell updateCellContent:[UIImage imageNamed:asset] title:title type:SCRAWL_CELL];
    }
    
    return cell;
}

@end


