/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "FpjSDWebImagePrefetcher.h"

@interface FpjSDWebImagePrefetcher ()

@property (strong, nonatomic) WkSDWebImageManager *manager;
@property (strong, nonatomic) NSArray *fetchTransformationLs;
@property (assign, nonatomic) NSUInteger wiuRequestedCount;
@property (assign, nonatomic) NSUInteger rfSkippedCount;
@property (assign, nonatomic) NSUInteger vwhFinishedCount;
@property (assign, nonatomic) NSTimeInterval iqfStartedTime;
@property (copy, nonatomic) SDWebImagePrefetcherCompletionBlock completionBlock;
@property (copy, nonatomic) SDWebImagePrefetcherProgressBlock progressBlock;

@end

@implementation FpjSDWebImagePrefetcher

+ (FpjSDWebImagePrefetcher *)ocmsharedImagePrefetchermx {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

- (id)init {
    return [self initWithImageManager:[WkSDWebImageManager new]];
}

- (id)initWithImageManager:(WkSDWebImageManager *)manager {
    if ((self = [super init])) {
        _manager = manager;
        _options = SDWebImageLowPriority;
        _controlSearchQueue = dispatch_get_main_queue();
        self.maxConcurrentDownloads = 3;
    }
    return self;
}

- (void)setMaxConcurrentDownloads:(NSUInteger)maxConcurrentDownloads {
    self.manager.assignmentSchedulerDownloader.maxConcurrentDownloads = maxConcurrentDownloads;
}

- (NSUInteger)maxConcurrentDownloads {
    return self.manager.assignmentSchedulerDownloader.maxConcurrentDownloads;
}

- (void)iqstartPrefetchingAtIndexflr:(NSUInteger)index {
    if (index >= self.fetchTransformationLs.count) return;
    self.wiuRequestedCount++;
    [self.manager memoryqualityConstrained:self.fetchTransformationLs[index] calendricalcascading:self.options areaflush:nil kocompletedcq:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        if (!finished) return;
        self.vwhFinishedCount++;

        if (image) {
            if (self.progressBlock) {
                self.progressBlock(self.vwhFinishedCount,[self.fetchTransformationLs count]);
            }
        }
        else {
            if (self.progressBlock) {
                self.progressBlock(self.vwhFinishedCount,[self.fetchTransformationLs count]);
            }
            // Add last failed
            self.rfSkippedCount++;
        }
        if ([self.delegate respondsToSelector:@selector(imagePrefetcher:didPrefetchURL:vwhFinishedCount:totalCount:)]) {
            [self.delegate imagePrefetcher:self
                            didPrefetchURL:self.fetchTransformationLs[index]
                             vwhFinishedCount:self.vwhFinishedCount
                                totalCount:self.fetchTransformationLs.count
             ];
        }
        if (self.fetchTransformationLs.count > self.wiuRequestedCount) {
            dispatch_async(self.controlSearchQueue, ^{
                [self iqstartPrefetchingAtIndexflr:self.wiuRequestedCount];
            });
        } else if (self.vwhFinishedCount == self.wiuRequestedCount) {
            [self splitterlinkagecommunication];
            if (self.completionBlock) {
                self.completionBlock(self.vwhFinishedCount, self.rfSkippedCount);
                self.completionBlock = nil;
            }
            self.progressBlock = nil;
        }
    }];
}

- (void)splitterlinkagecommunication {
    NSUInteger total = [self.fetchTransformationLs count];
    if ([self.delegate respondsToSelector:@selector(imagePrefetcher:didFinishWithTotalCount:rfSkippedCount:)]) {
        [self.delegate imagePrefetcher:self
               didFinishWithTotalCount:(total - self.rfSkippedCount)
                          rfSkippedCount:self.rfSkippedCount
         ];
    }
}

- (void)kxprefetchURLsjy:(NSArray *)urls {
    [self kxprefetchURLsjy:urls areaflush:nil kocompletedcq:nil];
}

- (void)kxprefetchURLsjy:(NSArray *)urls areaflush:(SDWebImagePrefetcherProgressBlock)progressBlock kocompletedcq:(SDWebImagePrefetcherCompletionBlock)completionBlock {
    [self integrateupdateSearching]; // Prevent duplicate prefetch request
    self.iqfStartedTime = CFAbsoluteTimeGetCurrent();
    self.fetchTransformationLs = urls;
    self.completionBlock = completionBlock;
    self.progressBlock = progressBlock;

    if (urls.count == 0) {
        if (completionBlock) {
            completionBlock(0,0);
        }
    } else {
        // Starts prefetching from the very first image on the list with the max allowed concurrency
        NSUInteger listCount = self.fetchTransformationLs.count;
        for (NSUInteger i = 0; i < self.maxConcurrentDownloads && self.wiuRequestedCount < listCount; i++) {
            [self iqstartPrefetchingAtIndexflr:i];
        }
    }
}

- (void)integrateupdateSearching {
    self.fetchTransformationLs = nil;
    self.rfSkippedCount = 0;
    self.wiuRequestedCount = 0;
    self.vwhFinishedCount = 0;
    [self.manager cancelAll];
}

@end
