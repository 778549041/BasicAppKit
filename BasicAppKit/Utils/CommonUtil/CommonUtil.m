//
//  CommonUtil.m
//  BasicAppKit
//
//  Created by xujun on 2019/8/9.
//  Copyright © 2019 xujun. All rights reserved.
//

#import "CommonUtil.h"
#import "UIImage+GIFImage.h"
#import <AVFoundation/AVFoundation.h>
#import <sys/utsname.h>

@implementation CommonUtil

DEF_SINGLETON(CommonUtil)

/**
 //gif loading
 
 @param gifName GIF图名称
 @param waitingMessage 等待提示信息
 */
- (void)showLoadingWith:(NSString *)gifName waitingMessage:(NSString *)waitingMessage{
    
    if (gifName.length > 0) {
        [SVProgressHUD setInfoImage:[UIImage imageWithGIFNamed:gifName]];
    }else{
        [SVProgressHUD setInfoImage:[UIImage imageWithGIFNamed:@"loading"]];
    }
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setMinimumDismissTimeInterval:CGFLOAT_MAX];
    [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
    [SVProgressHUD setImageViewSize:CGSizeMake(60, 60)];
    [SVProgressHUD setOffsetFromCenter:UIOffsetMake(0, 60)];
    [SVProgressHUD showInfoWithStatus:waitingMessage];
    
}

/**
 //时间戳转对应格式的时间
 
 @param timeStampStr 时间戳字符串
 @param fomatStr 转换后的时间格式 eg：yyyy-MM-dd
 @return 转换后得到的时间字符串
 */
- (NSString *)getTimeFromTimestamp:(NSString *)timeStampStr fomatStr:(NSString *)fomatStr{
    
    //将对象类型的时间转换为NSDate类型
    
    double time = [timeStampStr doubleValue];
    
    NSDate * myDate=[NSDate dateWithTimeIntervalSince1970:time];
    
    //设置时间格式
    
    NSDateFormatter * formatter=[[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:fomatStr];
    
    //将时间转换为字符串
    
    NSString *timeStr=[formatter stringFromDate:myDate];
    
    return timeStr;
    
}

/**
 //比较两个时间的大小
 
 @param date1 被比较的时间
 @param date2 待比较的时间
 @return 判断大小的值，为0说明相等，为1说明date2比date1大，为-1说明date2比date1小
 */
- (NSInteger)comparedate:(NSDate *)date1 withDate:(NSDate *)date2{
    
    NSInteger aa = 0;
    
    NSComparisonResult result = [date1 compare:date2];
    if (result==NSOrderedSame)
    {
        //        相等
        aa=0;
    }else if (result==NSOrderedAscending)
    {
        //Date2比Date1大
        aa=1;
    }else if (result==NSOrderedDescending)
    {
        //Date2比Date1小
        aa=-1;
        
    }
    
    return aa;
}

/**
 //imageid获取图片地址
 
 @param imagesID 图片id
 @param callback 请求成功回调
 */
- (void)getImageUrlString:(NSArray *)imagesID Callback:(OTSCompletionBlock)callback {
    [[AFNRequestManager sharedInstance] requestAFNWURL:@"openapi/storager/m" httpMethod:POST parameters:@{@"images":imagesID} WaitingMessage:nil Callback:^(id aResponseObject, NSError *anError) {
        if (!anError) {
            NSArray *imageUrlArr = aResponseObject[@"data"];
            callback(imageUrlArr,nil);
        }
    }];
}

/**
 //刷新tableview的某一行
 
 @param index 需要刷新的行
 @param tableView 需要刷新的table
 */
- (void)reloadIndexPath:(NSInteger)index forTableView:(UITableView *)tableView {
    [UIView setAnimationsEnabled:NO];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [UIView setAnimationsEnabled:YES];
}

/**
 //为控制器定制导航栏
 
 @param viewController 需要定制导航栏的控制器
 @param title 返回按钮标题
 @param backBtn 返回按钮
 */
- (void)setNavViewFor:(UIViewController *)viewController title:(NSString *)title backBtn:(UIButton *)backBtn{
    [viewController.navigationController.navigationBar setBackgroundImage:GetImage(@"nav_bg") forBarMetrics:UIBarMetricsDefault];
    //自定义返回按钮
    backBtn.frame = CGRectMake(0, 0, 40, 35);
    [backBtn setImage:[UIImage imageNamed:@"back_w"] forState:UIControlStateNormal];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 16)];
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 40)];
    v.backgroundColor = [UIColor clearColor];
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 40)];
    l.textAlignment = NSTextAlignmentCenter;
    l.font = [UIFont systemFontOfSize:22];
    l.backgroundColor = [UIColor clearColor];
    l.textColor = [UIColor whiteColor];
    l.text = title;
    [v addSubview:l];
    
    viewController.navigationItem.titleView = v;
}

/**
 //弹出相机进行拍照或者拍视频并通过回调返回图片或者视频地址
 
 @param callBack 拍摄完成回调
 */
- (void)presentCameraController:(OTSCompletionBlock)callBack {
#if TARGET_IPHONE_SIMULATOR
    [MBProgressHUD showError:@"simulator does not support taking picture"];
#elif TARGET_OS_IPHONE
    HVideoViewController *vc = [[NSBundle mainBundle] loadNibNamed:@"HVideoViewController" owner:nil options:nil].lastObject;
    vc.HSeconds = 8;//设置可录制最长时间
    vc.takeBlock = ^(id item) {
        if ([item isKindOfClass:[NSURL class]]) {
            
            NSURL *videoURL = item;
            NSFileManager *fileman = [NSFileManager defaultManager];
            if ([fileman fileExistsAtPath:videoURL.path]) {
                NSError *error = nil;
                [fileman removeItemAtURL:videoURL error:&error];
                if (error) {
                    NSLog(@"failed to remove file, error:%@.", error);
                }
            }
            callBack(videoURL,nil);
            
        } else {
            UIImage *image = item;
            callBack(image,nil);
            
        }
    };
    [[ApiHandler currentViewController] presentViewController:vc animated:YES completion:nil];
#endif
}

/*!
 @method
 @brief mov格式视频转换为MP4格式
 @discussion
 @param movUrl   mov视频路径
 @result  MP4格式视频路径
 */
- (NSURL *)_convert2Mp4:(NSURL *)movUrl
{
    NSURL *mp4Url = nil;
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:movUrl options:nil];
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    
    if ([compatiblePresets containsObject:AVAssetExportPresetHighestQuality]) {
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc]initWithAsset:avAsset
                                                                              presetName:AVAssetExportPresetHighestQuality];
        NSString *mp4Path = [NSString stringWithFormat:@"%@/%d%d.mp4", [self dataPath], (int)[[NSDate date] timeIntervalSince1970], arc4random() % 100000];
        mp4Url = [NSURL fileURLWithPath:mp4Path];
        exportSession.outputURL = mp4Url;
        exportSession.shouldOptimizeForNetworkUse = YES;
        exportSession.outputFileType = AVFileTypeMPEG4;
        dispatch_semaphore_t wait = dispatch_semaphore_create(0l);
        [exportSession exportAsynchronouslyWithCompletionHandler:^{
            switch ([exportSession status]) {
                case AVAssetExportSessionStatusFailed: {
                    NSLog(@"failed, error:%@.", exportSession.error);
                } break;
                case AVAssetExportSessionStatusCancelled: {
                    NSLog(@"cancelled.");
                } break;
                case AVAssetExportSessionStatusCompleted: {
                    NSLog(@"completed.");
                } break;
                default: {
                    NSLog(@"others.");
                } break;
            }
            dispatch_semaphore_signal(wait);
        }];
        long timeout = dispatch_semaphore_wait(wait, DISPATCH_TIME_FOREVER);
        if (timeout) {
            NSLog(@"timeout.");
        }
        if (wait) {
            //dispatch_release(wait);
            wait = nil;
        }
    }
    
    return mp4Url;
}

- (NSString*)dataPath
{
    NSString *dataPath = [NSString stringWithFormat:@"%@/Library/appdata/chatbuffer", NSHomeDirectory()];
    NSFileManager *fm = [NSFileManager defaultManager];
    if(![fm fileExistsAtPath:dataPath]){
        [fm createDirectoryAtPath:dataPath
      withIntermediateDirectories:YES
                       attributes:nil
                            error:nil];
    }
    return dataPath;
}

//获取系统model
-(NSString*)model
{
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString*platform = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if([platform isEqualToString:@"iPhone1,1"]) return@"iPhone 2G";
    
    if([platform isEqualToString:@"iPhone1,2"]) return@"iPhone 3G";
    
    if([platform isEqualToString:@"iPhone2,1"]) return@"iPhone 3GS";
    
    if([platform isEqualToString:@"iPhone3,1"]) return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone3,2"]) return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone3,3"]) return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone4,1"]) return@"iPhone 4S";
    
    if([platform isEqualToString:@"iPhone5,1"]) return@"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,2"]) return@"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,3"]) return@"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone5,4"]) return@"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone6,1"]) return@"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone6,2"]) return@"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone7,1"]) return@"iPhone 6 Plus";
    
    if([platform isEqualToString:@"iPhone7,2"]) return@"iPhone 6";
    
    if([platform isEqualToString:@"iPhone8,1"]) return@"iPhone 6s";
    
    if([platform isEqualToString:@"iPhone8,2"]) return@"iPhone 6s Plus";
    
    if([platform isEqualToString:@"iPhone8,4"]) return@"iPhone SE";
    
    if([platform isEqualToString:@"iPhone9,1"]) return@"iPhone 7";
    
    if([platform isEqualToString:@"iPhone9,2"]) return@"iPhone 7 Plus";
    
    if([platform isEqualToString:@"iPhone10,1"]) return@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,4"]) return@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,2"]) return@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,5"]) return@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,3"]) return@"iPhone X";
    
    if([platform isEqualToString:@"iPhone10,6"]) return@"iPhone X";
    
    if([platform isEqualToString:@"iPod1,1"]) return@"iPod Touch 1G";
    
    if([platform isEqualToString:@"iPod2,1"]) return@"iPod Touch 2G";
    
    if([platform isEqualToString:@"iPod3,1"]) return@"iPod Touch 3G";
    
    if([platform isEqualToString:@"iPod4,1"]) return@"iPod Touch 4G";
    
    if([platform isEqualToString:@"iPod5,1"]) return@"iPod Touch 5G";
    
    if([platform isEqualToString:@"iPad1,1"]) return@"iPad 1G";
    
    if([platform isEqualToString:@"iPad2,1"]) return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,2"]) return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,3"]) return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,4"]) return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,5"]) return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad2,6"]) return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad2,7"]) return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad3,1"]) return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,2"]) return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,3"]) return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,4"]) return@"iPad 4";
    
    if([platform isEqualToString:@"iPad3,5"]) return@"iPad 4";
    
    if([platform isEqualToString:@"iPad3,6"]) return@"iPad 4";
    
    if([platform isEqualToString:@"iPad4,1"]) return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,2"]) return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,3"]) return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,4"]) return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,5"]) return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,6"]) return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,7"]) return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad4,8"]) return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad4,9"]) return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad5,1"]) return@"iPad Mini 4";
    
    if([platform isEqualToString:@"iPad5,2"]) return@"iPad Mini 4";
    
    if([platform isEqualToString:@"iPad5,3"]) return@"iPad Air 2";
    
    if([platform isEqualToString:@"iPad5,4"]) return@"iPad Air 2";
    
    if([platform isEqualToString:@"iPad6,3"]) return@"iPad Pro 9.7";
    
    if([platform isEqualToString:@"iPad6,4"]) return@"iPad Pro 9.7";
    
    if([platform isEqualToString:@"iPad6,7"]) return@"iPad Pro 12.9";
    
    if([platform isEqualToString:@"iPad6,8"]) return@"iPad Pro 12.9";
    
    if([platform isEqualToString:@"i386"]) return@"iPhone Simulator";
    
    if([platform isEqualToString:@"x86_64"]) return@"iPhone Simulator";
    
    return platform;
    
}
////获取系统localizedModel
-(NSString*)localizedModel
{
    NSString* systemNameStr= [[UIDevice currentDevice] localizedModel];
    return  systemNameStr;
}


/*
 *  设置行间距和字间距
 *
 *  @param string    字符串
 *  @param lineSpace 行间距
 *  @param kern      字间距
 *  @param font      字体大小
 *
 *  @return 富文本
 */
- (NSAttributedString *)getAttributedWithString:(NSString *)string WithLineSpace:(CGFloat)lineSpace kern:(CGFloat)kern font:(UIFont *)font {
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    //调整行间距
    paragraphStyle.lineSpacing = lineSpace;
    NSDictionary *attriDict = @{NSParagraphStyleAttributeName:paragraphStyle,NSKernAttributeName:@(kern),
                                NSFontAttributeName:font};
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:string attributes:attriDict];
    return attributedString;
}

/* 获取富文本的高度
 *
 * @param string    文字
 * @param lineSpace 行间距
 * @param kern      字间距
 * @param font      字体大小
 * @param width     文本宽度
 *
 * @return size
 */
- (CGSize)getAttributionHeightWithString:(NSString *)string lineSpace:(CGFloat)lineSpace kern:(CGFloat)kern font:(UIFont *)font width:(CGFloat)width {
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = lineSpace;
    NSDictionary *attriDict = @{
                                NSParagraphStyleAttributeName:paragraphStyle,
                                NSKernAttributeName:@(kern),
                                NSFontAttributeName:font};
    CGSize size = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attriDict context:nil].size;
    return size;
}

@end
