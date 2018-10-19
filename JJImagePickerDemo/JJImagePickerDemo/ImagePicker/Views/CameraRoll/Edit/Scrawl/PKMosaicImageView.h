//
//  PKMosaicImageView.h
//
//  Created by cuihanxiu on 2017/7/27.
//

#import <UIKit/UIKit.h>

@interface PKMosaicImageView : UIImageView
@property (nonatomic, copy) void(^touchesBeginBlock)(NSSet<UITouch *> *touches, UIEvent *event);
@property (nonatomic, copy) void(^touchesMovedBlock)(NSSet<UITouch *> *touches, UIEvent *event);
@property (nonatomic, copy) void(^touchesEndedBlock)(NSSet<UITouch *> *touches, UIEvent *event);
@property (nonatomic, copy) void(^touchesCancelledBlock)(NSSet<UITouch *> *touches, UIEvent *event);
@end
