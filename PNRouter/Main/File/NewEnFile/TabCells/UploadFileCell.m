//
//  UploadFileCell.m
//  MyConfidant
//
//  Created by 旷自辉 on 2019/11/21.
//  Copyright © 2019 旷自辉. All rights reserved.
//

#import "UploadFileCell.h"
#import "PNFileModel.h"
#import "SystemUtil.h"
#import "MyConfidant-Swift.h"

@implementation UploadFileCell
- (IBAction)clickOptionAction:(id)sender {
    if (_optionBlock) {
        _optionBlock(self.fileModel,self.tag);
    }
}
- (void) setFileM:(PNFileModel *) fileModel isLocal:(BOOL)isLocal
{
    self.fileModel = fileModel;
    _lblDesc.text = [SystemUtil transformedValue:fileModel.Size];
    if (fileModel.Type == 1) {
        _typeImgView.image = [UIImage imageNamed:@"jpg"];
    } else if (fileModel.Type == 4) {
        _typeImgView.image = [UIImage imageNamed:@"mp4"];
    } else {
        NSString *fileType = [[fileModel.Fname componentsSeparatedByString:@"."] lastObject];
        UIImage *typeImg = [UIImage imageNamed:[fileType lowercaseString]];
        if (typeImg) {
            _typeImgView.image = typeImg;
        } else {
            _typeImgView.image = [UIImage imageNamed:@"other"];
        }
        
    }
    _nodeImgView.hidden = YES;
    if (isLocal) {
        _lblName.text = fileModel.Fname;
        if (fileModel.uploadStatus <= 0) {
            _progress.progress = 0;
            [_optionBtn setImage:[UIImage imageNamed:@"statusbar_hedo"] forState:UIControlStateNormal];
        } else if (fileModel.uploadStatus == 1) {
            _progress.progress = fileModel.progressV;
            [_optionBtn setImage:[UIImage imageNamed:@"noun_pause_a"] forState:UIControlStateNormal];
        } else {
            _nodeImgView.hidden = NO;
            _progress.progress = 0;
            [_optionBtn setImage:[UIImage imageNamed:@"statusbar_hedo"] forState:UIControlStateNormal];
        }
    } else {
        _lblName.text = [Base58Util Base58DecodeWithCodeName:fileModel.Fname];
        [_optionBtn setImage:[UIImage imageNamed:@"statusbar_hedo"] forState:UIControlStateNormal];
        _progress.progress = 0;
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end