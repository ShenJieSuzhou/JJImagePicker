//
//  HttpRequestUrlDefine.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/12/14.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#ifndef HttpRequestUrlDefine_h
#define HttpRequestUrlDefine_h
    

#define LOGINSUCCESS_NOTIFICATION                       @"LOGINSUCCESS_NOTIFICATION"

#define LOGINOUT_NOTIFICATION                           @"LOGINOUT_NOTIFICATION"

#define AC_LOGIN_REQUEST                                @"http://172.16.10.45:8080/login/accountLogin"

#define VERIFY_TOKEN_REQUEST                            @"http://172.16.10.45:8080/login/tokenVerify"

#define GET_WORKS_REQUEST                               @"http://172.16.10.45:8080/admin/api/getMyWorks"

#define POST_WORKS_REQUEST                              @"http://172.16.10.45:8080/admin/api/postMyWorks"

#define UPDATE_NICKNAME_REQUEST                         @"http://172.16.10.45:8080/admin/setting/api/updateNickName"

#define UPDATE_GENDER_REQUEST                           @"http://172.16.10.45:8080/admin/setting/api/updateGender"

#define UPDATE_BIRTH_REQUEST                            @"http://172.16.10.45:8080/admin/setting/api/updateUserBirth"

#define UPDATE_AVATAR_REQUEST                           @"http://172.16.10.45:8080/admin/setting/api/updateUserAvatar"

#define SET_NEWUSERPWD_REQUEST                          @"http://172.16.10.45:8080/admin/setting/api/setNewUserPwd"

#define SET_NEWPWD_REQUEST                              @"http://172.16.10.45:8080/admin/setting/api/setNewPwd"

#define BIND_PHONECODE_REQUEST                          @"http://172.16.10.45:8080/admin/setting/api/reqBindPhoneCode"

#define BIND_PHONE_REQUEST                              @"http://172.16.10.45:8080/admin/setting/api/bindUserPhone"

#define WECHAT_AUTHORIZATION                            @"http://172.16.10.45:8080/login/weChatAuthorization"

#define THIRDPLATFORM_LOGIN                             @"http://172.16.10.45:8080/login/thirdPlatformLogin"

#endif /* HttpRequestUrlDefine_h */
