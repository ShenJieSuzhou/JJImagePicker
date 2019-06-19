//
//  WordsBrushViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/10/20.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "WordsBrushViewController.h"
#import "WordsView.h"

@interface WordsBrushViewController ()

@end

@implementation WordsBrushViewController
@synthesize brushPaneView = _brushPaneView;
@synthesize textEditView = _textEditView;
@synthesize cusNavbar = _cusNavbar;
@synthesize delegate = _delegate;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    UIImage *closeImg = [[UIImage imageNamed:@"tabbar_close"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithImage:closeImg style:UIBarButtonItemStyleDone target:self action:@selector(OnCancelCLick:)];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(OnConfirmlCLick:)];
    [self.navigationItem setRightBarButtonItem:rightItem];
    
//    [self.view addSubview:self.cusNavbar];
    [self.view addSubview:self.textEditView];
    [self.view addSubview:self.brushPaneView];
    
    //添加键盘消息监听
    [self addKeyBoardNotification];
}

//添加消息中心监听
- (void)addKeyBoardNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardChangeFrame:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
}

#pragma mark -lazyload
- (BrushPaneView *)brushPaneView{
    if(!_brushPaneView){
        _brushPaneView = [[BrushPaneView alloc] initWithFrame:CGRectMake(0, 400, self.view.frame.size.width, 40.0f)];
        _brushPaneView.delegate = self;
    }
    return _brushPaneView;
}

- (TextEditView *)textEditView{
    if(!_textEditView){
        _textEditView = [[TextEditView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height / 2)];
        _textEditView.delegate = self;
    }
    return _textEditView;
}

- (CustomNaviBarView *)cusNavbar{
    if(!_cusNavbar){
        _cusNavbar = [[CustomNaviBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64.0f)];
        [_cusNavbar setBackgroundColor:[UIColor whiteColor]];
        
        UIButton *cancel = [UIButton buttonWithType:UIButtonTypeSystem];
        [cancel setTitle:@"取消" forState:UIControlStateNormal];
        [cancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancel addTarget:self action:@selector(OnCancelCLick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *confirm = [UIButton buttonWithType:UIButtonTypeSystem];
        [confirm setTitle:@"完成" forState:UIControlStateNormal];
        [confirm setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [confirm addTarget:self action:@selector(OnConfirmlCLick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_cusNavbar setLeftBtn:cancel];
        [_cusNavbar setRightBtn:confirm];
    }
    return _cusNavbar;
}

- (void)OnCancelCLick:(UIButton *)sender{    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)OnConfirmlCLick:(UIButton *)sender{
    WordsModel *model = [self.textEditView getWordModel];
    if([_delegate respondsToSelector:@selector(WordsBrushViewController:didAddWordsToImage:)]){
        
        [_delegate WordsBrushViewController:self didAddWordsToImage:model];
    }
}

#pragma mark - keyboard
- (void)keyboardWillShow:(NSNotification *)notif {
    
}

- (void)keyboardShow:(NSNotification *)notif {
    NSDictionary *userInfo = notif.userInfo;
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 键盘的frame
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:duration animations:^{
        [weakSelf.brushPaneView setFrame:CGRectMake(0, keyboardF.origin.y - 40.0f, self.view.frame.size.width, 40.0f)];
    }];
}

- (void)keyboardWillHide:(NSNotification *)notif {

}

- (void)keyboardHide:(NSNotification *)notif {
    
}

- (void)keyboardChangeFrame:(NSNotification *)notif{
    
}

#pragma mark - TextEditViewDelegate
- (void)textEditFinished:(TextEditView *)textView text:(WordsModel *)model{    
    if([_delegate respondsToSelector:@selector(WordsBrushViewController:didAddWordsToImage:)]){
        [_delegate WordsBrushViewController:self didAddWordsToImage:model];
    }
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - BrushPaneDelegate
- (void)chooseColorCallBack:(BrushPaneView *)view color:(UIColor *)color{
    [self.textEditView setEditTextColor:color];
}

@end
