//
//  PKBitmapData.m
//
//  Created by cuihanxiu on 2017/8/1.
//

#import "MosaicBitmapData.h"
#import "UIImage+Mosaic.h"

@implementation MosaicBitmapData {
    UIImage *_image;
    CGSize _bitmapSize;
    unsigned char *_bitmap;
    
    int _scale;
}

- (void)dealloc {
    if (_bitmap) {
        free(_bitmap);
        _bitmap = NULL;
    }
}

- (instancetype)initWithImage:(UIImage *)image {
    if (self = [self init]) {
        _bitmap = NULL;
        if (image) {
            _image = image;
            _scale = image.scale;
            _bitmapSize = CGSizeMake(image.size.width * _scale, image.size.height * _scale);
            _bitmap = [UIImage mosaicBitmapForImage:image];
        }
    }
    return self;
}

- (UIColor *)colorWithPoint:(CGPoint)point {
    if (_bitmap) {
        CGSize imgSize = _bitmapSize;
        point.x *= _scale;
        point.y *= _scale;
        if (point.x < 0) {
            point.x = 0;
        } else if (point.x > imgSize.width) {
            point.x = imgSize.width;
        }
        
        if (point.y < 0) {
            point.y = 0;
        } else if (point.y >= imgSize.height) {
            point.y = imgSize.height - 1;
        }
        long long index = (long)point.y * (long)_bitmapSize.width + (long)point.x;
        UInt32 *pixel = (UInt32 *)_bitmap;
        return [UIImage mosaicColorWithRGBA:*(pixel + index)];
    }
    return nil;
}
@end
