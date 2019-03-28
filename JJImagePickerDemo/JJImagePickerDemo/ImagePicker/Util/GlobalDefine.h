//
//  GlobalDefine.h
//  CoolFrame
//
//  Created by silicon on 2017/8/3.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#ifndef GlobalDefine_h
#define GlobalDefine_h

#define ScreenRect                          [[UIScreen mainScreen] bounds]
#define ScreenWidth                         [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight                        [[UIScreen mainScreen] bounds].size.height
#define ScreenScale                         [UIScreen mainScreen].scale
#define StatusBarHeight                     [UIApplication sharedApplication].statusBarFrame.size.height

#define Rect(x, y, w, h)                    CGRectMake(x, y, w, h)
#define Size(w, h)                          CGSizeMake(w, h)
#define Point(x, y)                         CGPointMake(x, y)


#define RGB_TitleNormal                     RGB(255.0f, 255.0f, 255.0f)
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define RGB(r, g, b)                        [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.f]

// UIColor 相关的宏
#define UIColorMake(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define UIColorMakeWithRGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a/1.0]

#define JJCHECKBOX  [UIColor colorWithRed:255/255.f green:34/255.f blue:29/255.f alpha:1.0f];

#define JJ_MAX_PHOTO_NUM 9
#define JJ_CELL_VIDEO_IDENTIFIER @"video"
#define JJ_CELL_IMAGE_UNKNOWNTYPE @"imageOrunknown"
#define JJ_PHOTO_ASSERT_CELL @"JJ_PHOTO_ASSERT_CELL"

#define JJ_PREVIEWCELL_IDENTIFIER_DEFAULT @"jj_previewcell_identifer"
#define JJ_PREVIEWCELL_IDENTIFIER_LIVEPHOTO @"jj_previewcell_identifer_live"
#define JJ_PREVIEWCELL_IDENTIFIER_VIDEO @"jj_previewcell_identifer_video"


/*
 * Tips
 */
#define JJ_PULLDATA_ERROR @"获取数据失败，请重试"
#define JJ_NETWORK_ERROR @"网络失败，请重试"
#define JJ_NO_PHOTOS @"你还没有内容，快去发布吧"
#define JJ_PUBLISH_ERROR @"发布失败"
#define JJ_PUBLISH_SUCCESS @"发布成功"
#define JJ_PUBLISH_UPLOAD_SUCCESS @"上传成功，正在发布"
#define JJ_LOGININFO_EXCEPTION  @"登录数据异常"
#define JJ_LOGININFO_EXPIRED  @"登录数据过期,请重新登录"
#define JJ_WECHATLOGIN_DENIED   @"微信登录用户拒绝"
#define JJ_WECHATLOGIN_CANCEL @"微信登录用户取消"


#endif /* GlobalDefine_h */
