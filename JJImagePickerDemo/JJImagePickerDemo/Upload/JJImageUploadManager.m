//
//  JJImageUploadManager.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/2/14.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import "JJImageUploadManager.h"
#import <Qiniu/QiniuSDK.h>
#import <Qiniu/QN_GTM_Base64.h>
#include <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonHMAC.h>
#import<QNConfiguration.h>

@interface JJImageUploadManager()

@property (nonatomic, copy) NSString *accessKey;
@property (nonatomic, copy) NSString *secretKey;
@property (nonatomic, copy) NSString *scope;
@property (assign) NSInteger liveTime;
@property (nonatomic, copy) NSString *uploadToken;

@end

@implementation JJImageUploadManager

+ (JJImageUploadManager *)shareInstance{
    static JJImageUploadManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[JJImageUploadManager alloc] init];
        instance.accessKey = @"DdEttx2bOBYCjubF-hhZhclOzE6iEW9xm24L7G8I";
        instance.secretKey = @"ib5YZR-YhwuavoRxpgg6tWSXeERHQ6tzPt_5EY9o";
        instance.scope = @"beautyimage";
        instance.liveTime = 100;
        [instance createToken];
    });
    
    return instance;
}

- (void)uploadImageToQN:(UIImage *)image uploadResult:(uploadToQnCallBack)jjResult{
    QNUploadManager *uploadManager = [[QNUploadManager alloc] init];
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0f);
    [uploadManager putData:imageData key:nil token:self.uploadToken complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        if(info.ok){
            NSString *hash = [resp objectForKey:@"hash"];
            NSString *key = [resp objectForKey:@"key"];
            jjResult(YES, key);
        }else{
            jjResult(NO, nil);
        }
        
    } option:nil];
}


- (void)createToken {
    if (!self.scope.length || !self.accessKey.length || !self.secretKey.length) {
        return ;
    }
    
    // 将上传策略中的scrop和deadline序列化成json格式
    NSMutableDictionary *authInfo = [NSMutableDictionary dictionary];
    [authInfo setObject:self.scope forKey:@"scope"];
    [authInfo
     setObject:[NSNumber numberWithLong:[[NSDate date] timeIntervalSince1970] + self.liveTime * 24 * 3600]
     forKey:@"deadline"];
    
    NSData *jsonData =
    [NSJSONSerialization dataWithJSONObject:authInfo options:NSJSONWritingPrettyPrinted error:nil];
    
    // 对json序列化后的上传策略进行URL安全的base64编码
    NSString *encodedString = [self urlSafeBase64Encode:jsonData];
    
    // 用secretKey对编码后的上传策略进行HMAC-SHA1加密，并且做安全的base64编码，得到encoded_signed
    NSString *encodedSignedString = [self HMACSHA1:self.secretKey text:encodedString];
    
    // 将accessKey、encodedSignedString和encodedString拼接，中间用：分开，就是上传的token
    NSString *token = [NSString stringWithFormat:@"%@:%@:%@", self.accessKey, encodedSignedString, encodedString];
    
    self.uploadToken = token;
}


- (NSString *)urlSafeBase64Encode:(NSData *)text {
    NSString *base64 =
    [[NSString alloc] initWithData:[QN_GTM_Base64 encodeData:text] encoding:NSUTF8StringEncoding];
    base64 = [base64 stringByReplacingOccurrencesOfString:@"+" withString:@"-"];
    base64 = [base64 stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    return base64;
}

- (NSString *)HMACSHA1:(NSString *)key text:(NSString *)text {
    const char *cKey = [key cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [text cStringUsingEncoding:NSUTF8StringEncoding];
    
    char cHMAC[CC_SHA1_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC length:CC_SHA1_DIGEST_LENGTH];
    NSString *hash = [self urlSafeBase64Encode:HMAC];
    return hash;
}

//+(void)uploadImageToQNFilePath:(NSArray *)photos success:(QNSuccessBlock)success failure:(QNFailureBlock)failure{

//    NSMutableArray *imageAry =[NSMutableArray new];
//    NSMutableArray *imageAdd = [NSMutableArray new];
//    for (ZLPhotoAssets *status in photos) {
//        [imageAry addObject:[status aspectRatioImage]];
//    }
//    //主要是把图片或者文件转成nsdata类型就可以了
//    QNConfiguration *config = [QNConfiguration build:^(QNConfigurationBuilder *builder) {
//        builder.zone = [QNZone zone0];}];
//    QNUploadManager *upManager = [[QNUploadManager alloc] initWithConfiguration:config];
//    QNUploadOption *uploadOption = [[QNUploadOption alloc] initWithMime:nil
//                                                        progressHandler:^(NSString *key, float percent) {
//                                                            NSLog(@"上传进度 %.2f", percent);
//                                                        }
//                                                                 params:nil
//                                                               checkCrc:NO
//                                                     cancellationSignal:nil];
//    [imageAry enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSLog(@"%ld",idx);
//        NSData *data;
//        if (UIImagePNGRepresentation(obj) == nil){
//            data = UIImageJPEGRepresentation(obj, 1);
//        } else {
//            data = UIImagePNGRepresentation(obj);}
//        [upManager putData:data key:[QiniuLoad qnImageFilePatName] token:[QiniuLoad makeToken:accessKey secretKey:secretKey] complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
//            NSLog(@"%@",resp[@"key"]);
//            if (info.isOK) {
//                [imageAdd addObject:[NSString stringWithFormat:@"%@%@",kQNinterface,resp[@"key"]]];}else{
//                    [imageAdd addObject:[NSString stringWithFormat:@"%ld",idx]];}
//            if (imageAdd.count == imageAry.count) {
//                if (success) {
//                    success([imageAdd componentsJoinedByString:@";"]);}}}
//                    option:uploadOption];}];
    
//}

@end
