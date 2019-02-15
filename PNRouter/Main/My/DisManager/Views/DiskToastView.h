//
//  MnemonicTipView.h
//  Qlink
//
//  Created by Jelly Foo on 2018/10/23.
//  Copyright © 2018 pan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DiskToastView : UIView

+ (instancetype)getInstance;
- (void)showWithTitle:(NSString *)title;
- (void)hide;

@end

NS_ASSUME_NONNULL_END
