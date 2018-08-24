//
//  CameraRollView.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/6/1.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "CameraRollView.h"


@implementation CameraRollView
@synthesize rollsTableView = _rollsTableView;
@synthesize rollsArray = _rollsArray;
@synthesize background = _background;
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
    self.background = [[UIView alloc] init];
    [self addSubview:self.background];
    [self addSubview:self.rollsTableView];
}

- (void)layoutSubviews{
    [self.rollsTableView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];

}

- (void)refreshAlbumAseets:(NSMutableArray *)albums{
    if(!albums){
        return;
    }

    self.rollsArray = albums;
    [_rollsTableView reloadData];
}

//懒加载
- (UITableView *)rollsTableView{
    if(!_rollsTableView){
        _rollsTableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _rollsTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _rollsTableView.delegate = self;
        _rollsTableView.dataSource = self;
    }
    
    return _rollsTableView;
}

- (void)setRollsArray:(NSMutableArray *)rollsArray{
    if(!rollsArray){
        return;
    }
    
    _rollsArray = rollsArray;
}


//tableview datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.rollsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *jjIdentifier = @"jjCellIdentifier";
    JJTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:jjIdentifier];
    if(!cell){
        cell = [[JJTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:jjIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            [cell setFrame:CGRectMake(0, 0, self.frame.size.width, 65.0f)];
        }else{
            [cell setFrame:CGRectMake(0, 0, self.frame.size.width, 57.0f)];
        }
    }
    
    //取一个相册
    JJPhotoAlbum *album = [self.rollsArray objectAtIndex:indexPath.row];
    //显示相册缩略图
    cell.imageView.image = [album albumThumbWithSize:CGSizeMake(cell.frame.size.height - 5, cell.frame.size.height - 5)];
    //显示相册名称
    cell.textLabel.text = [album albumName];
    //显示相册的照片数量
    cell.detailTextLabel.text = [NSString stringWithFormat:@"(%ld)", (long)[album numberOfAsset]];
    
    return cell;
}


//tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    JJTableViewCell *cell = (JJTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JJPhotoAlbum *album = [self.rollsArray objectAtIndex:indexPath.row];
    //将获取到的相册回调给 PhotosViewController 展示九宫格图片列表
    [_delegate imagePickerViewControllerForCameraRollView:album];
    
    //跳转到 PhotosViewController 
    [self removeFromSuperview];
}



@end
