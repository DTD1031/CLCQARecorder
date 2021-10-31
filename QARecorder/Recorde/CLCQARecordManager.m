//
//  CLCQARecordManager.m
//  QARecorder
//
//  Created by 陈乐诚 on 2021/10/21.
//

#import "CLCQARecordManager.h"
#import "CLCQARecordProtocol.h"
#import "CLCQARecord.h"
#import "CLCQAResponseClipRecorder.h"

//一次录制行为
@interface CLCQARecordEvent : NSObject
@property (nonatomic) NSMutableArray<id<CLCQARecordProtocol>> *preparingRecorders;

@property (nonatomic) NSMutableArray<NSString *> *filePaths;
@property (nonatomic) void(^completionHandler)(void);

@end

@implementation CLCQARecordEvent

- (instancetype)initWithRecorders:(NSMutableArray <id<CLCQARecordProtocol>>*)recorders {
    self = [super init];
    if (self) {
        _preparingRecorders = recorders.mutableCopy;
    }
    return self;
}

- (void)start {
    for (id<CLCQARecordProtocol> recorder in self.preparingRecorders) {
        
        [recorder exportClip:^(NSString *fileUrl) {
            if (fileUrl) {
                [self.filePaths addObject:fileUrl];
                [self recorderFinished:recorder];
            }
        }];
    }
}

- (void)recorderFinished:(id<CLCQARecordProtocol>)recorder {
    if (recorder) {
        [self.preparingRecorders removeObject:recorder];
    }
    
    if (self.preparingRecorders.count == 0) {
        [self collectionFinished];
    }
}

- (void)collectionFinished {
    //打包上传等逻辑在这里执行
    
    if (self.completionHandler) {
        self.completionHandler();
    }
}

@end


@interface CLCQARecordManager ()

@property (nonatomic) NSMutableArray <id<CLCQARecordProtocol>>*recorders;
@property (nonatomic) BOOL recording;
@end

@implementation CLCQARecordManager

static CLCQARecordManager *shareInstance;
+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [CLCQARecordManager new];
    });
    return shareInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    
    if (!self.recorders) {
        self.recorders = @[].mutableCopy;
        //屏幕录制
        [self.recorders addObject:[CLCQARecord new]];
        //网络请求录制
        [self.recorders addObject:[CLCQAResponseClipRecorder new]];
    }
}

- (void)start {
    
    for (id<CLCQARecordProtocol> recorder in self.recorders) {
        [recorder startRecord];
    }
}

- (void)clip {
 
    if (self.recording) {
        return;
    }
    
    self.recording = YES;
    CLCQARecordEvent *event = [[CLCQARecordEvent alloc] initWithRecorders:self.recorders];
    __weak CLCQARecordManager *weakManager = self;
    
    event.completionHandler = ^{
        CLCQARecordManager *strong = weakManager;
        strong.recording = NO;
    };
    [event start];
}

- (void)stop {
    for (id<CLCQARecordProtocol> recorder in self.recorders) {
        [recorder stopRecord];
    }
}

@end
