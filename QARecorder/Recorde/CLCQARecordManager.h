//
//  CLCQARecordManager.h
//  QARecorder
//
//  Created by 陈乐诚 on 2021/10/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CLCQARecordManager : NSObject
+ (instancetype)shareInstance;

- (void)start;

- (void)clip;

- (void)stop;
@end

NS_ASSUME_NONNULL_END
