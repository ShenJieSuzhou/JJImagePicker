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

//懒加载
- (UITableView *)rollsTableView{
    if(!_rollsTableView){
        _rollsTableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _rollsTableView.delegate = self;
        _rollsTableView.dataSource = self;
    }
    
    return _rollsTableView;
}

- (void)setRollsArray:(NSMutableArray *)rollsArray{
    if(!rollsArray){
        return;
    }
    
    self.rollsArray = rollsArray;
}


//tableview datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
//    return [self.rollsArray count];
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ThumbCell"];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 45)];
    }
    
    [cell.textLabel setText:@"111111"];
    return cell;
}


//tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
