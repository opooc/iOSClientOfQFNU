//
//  tableHeadView.m
//  iOSClientOfQFNU
//
//  Created by doushuyao on 17/6/21.
//  Copyright © 2017年 iOSClientOfQFNU. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DSYPhotoHelperBlock) (id data);

@interface DSYPhotoHelper : UIImagePickerController


+ (instancetype)shareHelper;

- (void)showImageViewSelcteWithResultBlock:(DSYPhotoHelperBlock)selectImageBlock;

@end
