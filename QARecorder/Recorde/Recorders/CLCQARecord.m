//
//  CLCQARecord.m
//  QARecorder
//
//  Created by 陈乐诚 on 2021/10/31.
//

#import "CLCQARecord.h"
#import <ReplayKit/ReplayKit.h>
#import "CLCQAResponseClipRecorder.h"

@interface CLCQARecord ()

@end

@implementation CLCQARecord

- (instancetype)init {
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)startRecord {
    if (@available(iOS 15.0, *)) {
        [[RPScreenRecorder sharedRecorder] startClipBufferingWithCompletionHandler:^(NSError * _Nullable error) {
            NSLog(@"rpclip - 录制开启");
        }];
    } else {
        // Fallback on earlier versions
    }
}

- (void)exportClip:(void(^)(NSString *))complete {
    [self saveVideoWithComplete:complete];
}

- (void)stopRecord {
    if (@available(iOS 15.0, *)) {
        [[RPScreenRecorder sharedRecorder] stopClipBufferingWithCompletionHandler:^(NSError * _Nullable error) {
            NSLog(@"rpclip - 录制停止");
        }];
    } else {
        // Fallback on earlier versions
    }
}

- (void)saveVideoWithComplete:(void(^)(NSString *))completion {
    
    NSURL *tempPath = [NSURL fileURLWithPath:NSTemporaryDirectory()];
    NSString *dateString = [NSString stringWithFormat:@"%@", [NSDate date]];
    NSURL *fileUrl = [tempPath URLByAppendingPathComponent:[NSString stringWithFormat:@"output-%@.mp4",dateString]];

    NSLog(@"pppath = %@", fileUrl);
    if (@available(iOS 15.0, *)) {
        [[RPScreenRecorder sharedRecorder] exportClipToURL:fileUrl duration:10 completionHandler:^(NSError * _Nullable error) {
            if (error) {
                NSLog(@"保存失败");
                if (completion) {
                    completion(nil);
                }
            } else {
                NSLog(@"保存成功");
                if (completion) {
                    completion(fileUrl.absoluteString);
                }
            }
        }];
    } else {
        // Fallback on earlier versions
    }
}


@end
