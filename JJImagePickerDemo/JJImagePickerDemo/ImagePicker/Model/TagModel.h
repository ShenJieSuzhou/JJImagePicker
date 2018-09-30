//
//  TagModel.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/9/25.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    TAG_DIRECTION_LEFT,
    TAG_DIRECTION_RIGHT,
    TAG_DIRECTION_LEFT_DELETE,
    TAG_DIRECTION_RIGHT_DELETE,
} TAG_DIRECTION;

@interface TagModel : NSObject

@property (strong, nonatomic) NSString *tagName;

@property (assign) CGPoint point;

@property (assign) TAG_DIRECTION dircetion;

- (void)updateTagName:(NSString *)tagName;

@end
