//
//  JJDetailsInfoFooterView.h
//  JJImagePickerDemo
//
//  Created by silicon on 2019/8/25.
//  Copyright © 2019 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYText.h>

@interface JJDetailsInfoFooterView : UITableViewHeaderFooterView

@property (strong, nonatomic) YYLabel *commentTitle;

@property (strong, nonatomic) UIImageView *seperateLine;

@property (strong, nonatomic) UIView *noCommentV;

+ (instancetype)footerViewWithTableView:(UITableView *)tableView;
@end

