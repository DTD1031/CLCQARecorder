//
//  CLCQAResponseClipRecorder.m
//  NetEasePlay
//
//  Created by 陈乐诚 on 2021/10/14.
//  Copyright © 2021 NetEase. All rights reserved.
//

#import "CLCQAResponseClipRecorder.h"

@interface CLCQAResponseClipRecorder ()

@end

@implementation CLCQAResponseClipRecorder

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark - NMLQARecordProtocol

///启动录制
- (void)startRecord {
    
    //与网络库连接，记录请求
}

///生成片段
- (void)exportClip:(void(^)(NSString *))complete {
    
    //导出当前记录的请求，写入文件
}

///结束录制
- (void)stopRecord {

    //与网络库断开连接
}


@end
