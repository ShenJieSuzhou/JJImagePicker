//
//  BindPhoneViewController.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/1/3.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GBverifyButton.h"


@interface BindPhoneViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *navBar;

@property (weak, nonatomic) IBOutlet UIButton *closeBtn;

@property (weak, nonatomic) IBOutlet UILabel *myTitle;

@property (weak, nonatomic) IBOutlet UIView *bindView;

@property (weak, nonatomic) IBOutlet UITextField *phoneTF;

@property (weak, nonatomic) IBOutlet UITextField *codeTF;

@property (weak, nonatomic) IBOutlet UIButton *bindBtn;

@property (strong, nonatomic) GBverifyButton *yzmBtn;

- (IBAction)clickBindBtn:(id)sender;


- (IBAction)clickCloseBtn:(id)sender;

@end

