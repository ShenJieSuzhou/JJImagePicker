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
    [self addSubview:self.rollsTableView];
}

- (void)layoutSubviews{
    
    
}

//懒加载
- (void)setRollsArray:(NSMutableArray *)rollsArray{
    
}

- (void)setRollsTableView:(UITableView *)rollsTableView{
    
}

//tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.rollsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return nil;
}


//tableview datasource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 45.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}









@end
