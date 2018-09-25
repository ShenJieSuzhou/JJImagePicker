//
//  JJLoadConfig.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/8/24.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "JJLoadConfig.h"

@interface JJLoadConfig()

@property (strong, nonatomic) NSDictionary *contentDic;
@property (strong, nonatomic) NSDictionary *stickerDic;

@end

@implementation JJLoadConfig
@synthesize contentDic = _contentDic;
@synthesize stickerDic = _stickerDic;

+ (JJLoadConfig *)getInstance{
    static JJLoadConfig *m_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        m_instance = [[JJLoadConfig alloc] init];
    });
    
    return m_instance;
}

- (NSDictionary *)getCustomContent{
    
    if(!self.contentDic){
        self.contentDic = [self loadEditToolConfigFile];
    }
    
    return self.contentDic;
}

- (NSDictionary *)getStickercontent{
    if(!self.stickerDic){
        self.stickerDic = [self loadStickerFile];
    }
    
    return self.stickerDic;
}

#pragma mark - init edit tool
- (NSDictionary *)loadEditToolConfigFile{
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"content" ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    if(!data){
        NSLog(@"init edit tool failed");
    }
    
    // 对数据进行JSON格式化并返回字典形式
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

- (NSDictionary *)loadStickerFile{
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"stickerConfig" ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    if(!data){
        NSLog(@"init edit tool failed");
    }
    
    // 对数据进行JSON格式化并返回字典形式
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

@end
