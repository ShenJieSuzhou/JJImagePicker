//
//  OriginalWorksViewController.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/1/15.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPhotoViewController.h"
#import "Works.h"

@interface OriginalWorksViewController : CustomPhotoViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

- (void)setWorksInfo:(Works *)workModel;

@end


