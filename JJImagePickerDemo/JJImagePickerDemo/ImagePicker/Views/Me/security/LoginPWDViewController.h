//
//  LoginPWDViewController.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/1/3.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPhotoViewController.h"

@interface LoginPWDViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *nUserView;

@property (weak, nonatomic) IBOutlet UITextField *nPwdField;

@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@property (weak, nonatomic) IBOutlet UIView *oUserView;

@property (weak, nonatomic) IBOutlet UITextField *oldPwdField;

@property (weak, nonatomic) IBOutlet UITextField *mPwdField;

@property (weak, nonatomic) IBOutlet UITextField *checkMPwdField;

@property (weak, nonatomic) IBOutlet UIButton *nSaveBtn;

@property (weak, nonatomic) IBOutlet UIView *navBar;

@property (weak, nonatomic) IBOutlet UIButton *closeBtn;

@property (weak, nonatomic) IBOutlet UILabel *myTitle;

@property (assign) BOOL isFreshMan;

- (IBAction)nclickSaveBtn:(id)sender;

- (IBAction)mClickSaveBtn:(id)sender;

@end

