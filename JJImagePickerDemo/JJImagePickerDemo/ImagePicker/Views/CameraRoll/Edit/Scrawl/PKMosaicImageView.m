//
//  PKMosaicImageView.m
//
//  Created by cuihanxiu on 2017/7/27.
//

#import "PKMosaicImageView.h"

@implementation PKMosaicImageView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    if (self.touchesBeginBlock) self.touchesBeginBlock(touches, event);
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    if (self.touchesMovedBlock) self.touchesMovedBlock(touches, event);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    if (self.touchesEndedBlock) self.touchesEndedBlock(touches, event);
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    if (self.touchesCancelledBlock) self.touchesCancelledBlock(touches, event);
}

@end
