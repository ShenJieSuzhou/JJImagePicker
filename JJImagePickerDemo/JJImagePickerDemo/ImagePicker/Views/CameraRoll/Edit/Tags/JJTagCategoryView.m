//
//  JJTagCategoryView.m
//  testTag
//
//  Created by shenjie on 2018/9/30.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "JJTagCategoryView.h"

#define EDIT_HEIGHT 40.0f
#define EDIT_WIDTH self.frame.size.width
#define TAG_VIEW_HEIGHT self.frame.size.height
#define HEADERIDENTIFIER @"JJHEADERIDENTIFIER"
#define FOOTIDENTIFIER @"JJFOOTIDENTIFIER"
#define TAGCELLIDENTIFIER @"JJTAGCELLIDENTIFIER"

@implementation JJTagCategoryView
@synthesize navBarView = _navBarView;
@synthesize tagEditView = _tagEditView;
@synthesize tagsCollectionView = _tagsCollectionView;
@synthesize hotTags = _hotTags;
@synthesize historyTags = _historyTags;
@synthesize delegate = _delegate;

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self commonInitialization];
    }
    return self;
}

- (void)commonInitialization{
    self.userInteractionEnabled = YES;

    //取消
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeSystem];
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(OnCancelCLick:) forControlEvents:UIControlEventTouchUpInside];
    [self.navBarView setLeftBtn:cancel];
    [self.navBarView setTitle:@"添加标签" textColor:[UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1.0f] font:[UIFont systemFontOfSize:15.0f]];
    
    [self addSubview:self.navBarView];
    [self addSubview:self.tagEditView];
    [self addSubview:self.tagsCollectionView];
}

- (void)layoutSubviews{
    [super layoutSubviews];

    [self.tagEditView setFrame:CGRectMake(0, [CustomNaviBarView barSize].height, EDIT_WIDTH, EDIT_HEIGHT)];
    [self.tagsCollectionView setFrame:CGRectMake(0, EDIT_HEIGHT + [CustomNaviBarView barSize].height, EDIT_WIDTH, TAG_VIEW_HEIGHT - EDIT_HEIGHT - 10.0f)];
}


- (void)setHotTags:(NSMutableArray *)hotTags withHistory:(NSMutableArray *)history{
    self.hotTags = hotTags;
    self.historyTags = history;
}

#pragma mark 懒加载
- (UICollectionView *)tagsCollectionView{
    if(!_tagsCollectionView){
        JJResizeFlowLayout *flowlayout = [[JJResizeFlowLayout alloc] init];
        flowlayout.delegate = self;
        flowlayout.rowHeight = 30.0f;
        
        _tagsCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowlayout];
        _tagsCollectionView.backgroundColor = [UIColor whiteColor];
        [_tagsCollectionView registerClass:[JJTagsCollectionViewCell class] forCellWithReuseIdentifier:TAGCELLIDENTIFIER];
        [_tagsCollectionView registerClass:[JJCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HEADERIDENTIFIER];
        [_tagsCollectionView registerClass:[JJCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:FOOTIDENTIFIER];
        _tagsCollectionView.delegate = self;
        _tagsCollectionView.dataSource = self;
        _tagsCollectionView.showsHorizontalScrollIndicator = NO;
    }
    
    return _tagsCollectionView;
}

- (TagEditView *)tagEditView{
    if(!_tagEditView){
        _tagEditView = [[TagEditView alloc] initWithFrame:CGRectZero];
        _tagEditView.delegate = self;
    }
    return _tagEditView;
}

- (CustomNaviBarView *)navBarView{
    if(!_navBarView){
        _navBarView = [[CustomNaviBarView alloc] initWithFrame:CGRectMake(0, 0, [CustomNaviBarView barSize].width, [CustomNaviBarView barSize].height)];
        [_navBarView  setBackgroundColor:[UIColor whiteColor]];
    }
    return _navBarView;
}

#pragma mark UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(section == 0){
        return [self.hotTags count];
    }else if(section == 1){
        return [self.historyTags count];
    }
    return 0;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JJTagsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TAGCELLIDENTIFIER forIndexPath:indexPath];
    if(indexPath.section == 0){
        SubTagModel *tag = [self.hotTags objectAtIndex:indexPath.row];
        [cell updateCell:tag];
    }else if(indexPath.section == 1){
        SubTagModel *tag = [self.historyTags objectAtIndex:indexPath.row];
        [cell updateCell:tag];
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    JJCollectionReusableView *header = nil;
    if([kind isEqualToString:UICollectionElementKindSectionHeader]){
        header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HEADERIDENTIFIER forIndexPath:indexPath];
        if(indexPath.section == 0){
            [header setTitle:@"热门" image:[UIImage imageNamed:@"INPublishAddTagRec"]];
        }else if(indexPath.section == 1){
            [header setTitle:@"历史标签" image:[UIImage imageNamed:@"phototagclock"]];
        }
        return header;
    }else{
        JJCollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:FOOTIDENTIFIER forIndexPath:indexPath];
        [footer setFrame:CGRectZero];
        [footer setTitle:@"" image:nil];
        return footer;
    }
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(![_delegate respondsToSelector:@selector(JJTagCategory:didChooseTag:)]){
        return;
    }
    if(indexPath.section == 0){
        [_delegate JJTagCategory:self didChooseTag:[self.hotTags objectAtIndex:indexPath.row]];
    }else if(indexPath.section == 1){
        [_delegate JJTagCategory:self didChooseTag:[self.historyTags objectAtIndex:indexPath.row]];
    }
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}


#pragma mark TagEditViewDelegate
- (void)TagAdd:(TagEditView *)view tag:(NSString *)tag{
    [view.tagTextField setText:@""];
    [view.tagTextField resignFirstResponder];
    
    [self.hotTags removeAllObjects];
    self.hotTags = nil;
    [self.historyTags removeAllObjects];
    self.historyTags = nil;
    
    if(![_delegate respondsToSelector:@selector(JJTagCategory:historyTag:)]){
        [self removeFromSuperview];
        return;
    }
    SubTagModel *tagObj = [[SubTagModel alloc] initWithID:0 Name:tag];
    [_delegate JJTagCategory:self historyTag:tagObj];
}

#pragma mark JJResizeFlowLayoutDelegate
//通过代理获取每个cell的高度
- (CGFloat)resizeFlowLayout:(JJResizeFlowLayout *)layout withIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        SubTagModel *tag = [self.hotTags objectAtIndex:indexPath.row];
        CGSize size = CGSizeMake(EDIT_WIDTH - layout.sectionInset.left - layout.sectionInset.right, CGFLOAT_MAX);
        CGRect textRect = [tag.name boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
        CGFloat width = textRect.size.width + 15.0f;
        return width;
    }else if(indexPath.section == 1){
        SubTagModel *tag = [self.historyTags objectAtIndex:indexPath.row];
        CGSize size = CGSizeMake(EDIT_WIDTH - layout.sectionInset.left - layout.sectionInset.right, CGFLOAT_MAX);
        CGRect textRect = [tag.name boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
        CGFloat width = textRect.size.width + 15.0f;
        return width;
    }
    
    return 0.0f;
}

#pragma mark touchEvent
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if(self.tagEditView.tagTextField.isEditing){
        [self.tagEditView.tagTextField resignFirstResponder];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

- (void)OnCancelCLick:(UIButton *)sender{
    [self.hotTags removeAllObjects];
    self.hotTags = nil;
    [self.historyTags removeAllObjects];
    self.historyTags = nil;
    
    if(![_delegate respondsToSelector:@selector(JJTagCategoryDidCancel:)]){
        [self removeFromSuperview];
        return;
    }
    [_delegate JJTagCategoryDidCancel:self];
}

@end
