//
//  FingetprintVerificationUtil.h
//  PNRouter
//
//  Created by Jelly Foo on 2018/9/10.
//  Copyright © 2018年 旷自辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FingetprintVerificationUtil : NSObject

+ (void)show;
+ (void)backShow;
- (void)backShowWithComplete:(void(^_Nullable)(BOOL success, NSError * _Nullable error))complete;
- (void)hide;

@end
