//
//  EditAvaterViewController.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/4/26.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CropAvaterViewController.h"


@class EditAvaterViewController;
@protocol EditAvaterDelegate <NSObject>

- (void)EditAvaterSuccessCallBack:(UIImage *)avater;

@end

@interface EditAvaterViewController : UIViewController

@property (weak, nonatomic) id<EditAvaterDelegate> delegate;

@property (strong, nonatomic) NSString *avaterUrl;

@property (strong, nonatomic) CropAvaterViewController *cropAvaterView;

@end

