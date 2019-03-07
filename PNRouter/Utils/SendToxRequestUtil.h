//
//  SendToxRequestUtil.h
//  PNRouter
//
//  Created by 旷自辉 on 2018/11/29.
//  Copyright © 2018 旷自辉. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OCTManager.h"


NS_ASSUME_NONNULL_BEGIN

@interface SendToxRequestUtil : NSObject

+ (void) sendTextMessageWithText:(NSString *) message manager:(id<OCTManager>) manage;
+ (void) sendFileWithFilePath:(NSString *) filePath parames:(NSDictionary *) parames;
+ (void) uploadFileWithFilePath:(NSString *) filePath parames:(NSDictionary *) parames fileData:(NSData *) fileData;
+ (void) cancelToxFileUploadWithFileid:(NSString *) fileid;
// 取消tox文件上传
+ (void) cancelToxFileDownWithMsgid:(NSString *) msgid;
@end

NS_ASSUME_NONNULL_END
