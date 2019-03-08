//
//  FingetprintVerificationUtil.m
//  PNRouter
//
//  Created by Jelly Foo on 2018/9/10.
//  Copyright © 2018年 旷自辉. All rights reserved.
//

#import "FingetprintVerificationUtil.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface FingetprintVerificationUtil ()

@property (nonatomic, strong) LAContext *unlockContext;

@end

@implementation FingetprintVerificationUtil


//+ (void)show {
//    //首先判断版本
//    if (NSFoundationVersionNumber < NSFoundationVersionNumber_iOS_8_0) {
//        DDLogDebug(@"系统版本不支持TouchID");
//        return;
//    }
//
//    LAContext *context = [[LAContext alloc] init];
//    context.localizedFallbackTitle = @"Enter Password";
//    if (@available(iOS 10.0, *)) {
//        //        context.localizedCancelTitle = @"22222";
//    } else {
//        // Fallback on earlier versions
//    }
//    NSError *error = nil;
//    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
//        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"Fingerprint verification" reply:^(BOOL success, NSError * _Nullable error) {
//            if (success) {
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    DDLogDebug(@"TouchID验证成功");
////                    [AppD.window showHint:@"Authentication is successful"];
//                });
//            } else if(error) {
//                switch (error.code) {
//                    case LAErrorAuthenticationFailed:{
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            DDLogDebug(@"TouchID 验证失败");
//                            [FingetprintVerificationUtil exitAPP];
//                        });
//                        break;
//                    }
//                    case LAErrorUserCancel:{
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            DDLogDebug(@"TouchID 被用户手动取消");
//                            [FingetprintVerificationUtil exitAPP];
//                        });
//                    }
//                        break;
//                    case LAErrorUserFallback:{
//                        DDLogDebug(@"TouchID 用户手动输入密码");
//                        [FingetprintVerificationUtil verificationPassword];
//                    }
//                        break;
//                    case LAErrorSystemCancel:{
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            DDLogDebug(@"TouchID 被系统取消 (如遇到来电,锁屏,按了Home键等)");
//                            [FingetprintVerificationUtil exitAPP];
//                        });
//                    }
//                        break;
//                    case LAErrorPasscodeNotSet:{
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            DDLogDebug(@"TouchID 无法启动,因为用户没有设置密码");
//                            [FingetprintVerificationUtil exitAPP];
//                        });
//                    }
//                        break;
//                    case LAErrorTouchIDNotEnrolled:{
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            DDLogDebug(@"TouchID 无法启动,因为用户没有设置TouchID");
//                            [FingetprintVerificationUtil exitAPP];
//                        });
//                    }
//                        break;
//                    case LAErrorTouchIDNotAvailable:{
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            DDLogDebug(@"TouchID 无效");
//                            [FingetprintVerificationUtil exitAPP];
//                        });
//                    }
//                        break;
//                    case LAErrorTouchIDLockout:{
//
//                        DDLogDebug(@"TouchID 被锁定(连续多次验证TouchID失败,系统需要用户手动输入密码)");
//                        [FingetprintVerificationUtil verificationPassword];
//
//                    }
//                        break;
//                    case LAErrorAppCancel:{
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            DDLogDebug(@"当前软件被挂起并取消了授权 (如App进入了后台等)");
//                            [FingetprintVerificationUtil exitAPP];
//                        });
//                    }
//                        break;
//                    case LAErrorInvalidContext:{
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            DDLogDebug(@"当前软件被挂起并取消了授权 (LAContext对象无效)");
//                            [FingetprintVerificationUtil exitAPP];
//                        });
//                    }
//                        break;
//                    default:
//                        break;
//                }
//            }
//        }];
//    } else {
//        DDLogDebug(@"当前设备不支持TouchID");
//        [FingetprintVerificationUtil showNotSupport];
//    }
//}

- (LAContext *)unlockContext {
    if (!_unlockContext) {
        _unlockContext = [[LAContext alloc] init];
    }
    
    return _unlockContext;
}

- (void)backShowWithComplete:(void(^_Nullable)(BOOL success, NSError * _Nullable error))complete {
    @weakify_self
    dispatch_async(dispatch_get_main_queue(), ^{
        DDLogDebug(@"开始解锁");
        NSError *error = nil;
        if( [weakSelf.unlockContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:&error]) {
            [weakSelf.unlockContext evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:@"Use the fingerprint to continue." reply:^(BOOL success, NSError * _Nullable error) {
                if (error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        DDLogDebug(@"解锁验证失败");
                    });
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        DDLogDebug(@"解锁验证成功");
                        
                    });
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (complete) {
                        complete(success, error);
                    }
                });
            }];
        }
    });
}

- (void)hide {
    if (self.unlockContext) {
        [self.unlockContext invalidate];
        self.unlockContext = nil;
    }
}

+ (void)backShow
{
    dispatch_async(dispatch_get_main_queue(), ^{
        DDLogDebug(@"开始解锁");
        LAContext *myContext = [[LAContext alloc] init];
        NSError *error = nil;
        if( [myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:&error])
        {
            [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:@"Use the fingerprint to continue." reply:^(BOOL success, NSError * _Nullable error) {
                if (error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        DDLogDebug(@"解锁验证失败");
                        [FingetprintVerificationUtil exitAPP];
                    });
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        DDLogDebug(@"解锁验证成功");
                    });
                }
            }];
        }
    });
}

+ (void) show
{
    dispatch_async(dispatch_get_main_queue(), ^{
        DDLogDebug(@"开始解锁");
        LAContext *myContext = [[LAContext alloc] init];
        NSError *error = nil;
        if( [myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:&error])
        {
            [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:@"Use the fingerprint to continue." reply:^(BOOL success, NSError * _Nullable error) {
                if (error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        DDLogDebug(@"解锁验证失败");
                         [FingetprintVerificationUtil exitAPP];
                    });
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        DDLogDebug(@"解锁验证成功");
                        [[NSNotificationCenter defaultCenter] postNotificationName:TOUCH_MODIFY_SUCCESS_NOTI object:nil];
                    });
                }
            }];
        }
    });
}
+ (void)showNotSupport {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:@"当前设备不支持TouchID" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertConfirm = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [FingetprintVerificationUtil exitAPP];
    }];
    [alertC addAction:alertConfirm];
    [AppD.window.rootViewController presentViewController:alertC animated:YES completion:nil];
}

+ (void)exitAPP {
    [AppD.window showHint:@"Validation fails"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         exit(0);
    });
}



@end
