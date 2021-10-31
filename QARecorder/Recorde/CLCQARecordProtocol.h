//
//  CLCQARecordProtocol.h
//  NetEasePlay
//
//  Created by 陈乐诚 on 2021/10/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


///自定义录制模块需要实现该协议，并添加到QARecordManager里去
@protocol CLCQARecordProtocol <NSObject>
@required
///启动录制
- (void)startRecord;
///生成片段
- (void)exportClip:(void(^)(NSString *))complete;
///结束录制
- (void)stopRecord;
@end

NS_ASSUME_NONNULL_END
