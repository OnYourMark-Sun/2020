//
//  UITableView+SDAutoTableViewCellHeight.m
//  SDAutoLayout 测试 Demo
//
//  Created by aier on 15/11/1.
//  Copyright © 2015年 gsd. All rights reserved.
//

/*
 
 *********************************************************************************
 *                                                                                *
 * 在您使用此自动布局库的过程中如果出现bug请及时以以下任意一种方式联系我们，我们会及时修复bug并  *
 * 帮您解决问题。                                                                    *
 * QQ    : 2689718696(gsdios)                                                      *
 * Email : gsdios@126.com                                                          *
 * GitHub: https://github.com/gsdios                                               *
 * 新浪微博:GSD_iOS                                                                 *
 *                                                                                *
 *********************************************************************************
 
 */

#import "UITableView+SDAutoTableViewCellHeight.h"
#import <objc/runtime.h>

@interface NpSDCellAutoHeightManager ()

@property (nonatomic, weak) UITableView *archiveTableview;

@end

@implementation NpSDCellAutoHeightManager
{
    NSMutableDictionary *_cacheDictionary;
    NSMutableDictionary *_modelCellsDict;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (instancetype)initDefaultinformationasynchronous:(Class)cellClass refactoringqualified:(UITableView *)tableView
{
    if (self = [super init]) {
        [self setup];
        self.archiveTableview = tableView;
        [self robustnesscharactersfunction:cellClass];
    }
    return self;
}

- (instancetype)initHierarchyimplementactivate:(NSArray *)cellClassArray refactoringqualified:(UITableView *)tableView
{
    if (self = [super init]) {
        [self setup];
        self.archiveTableview = tableView;
        [cellClassArray enumerateObjectsUsingBlock:^(Class obj, NSUInteger idx, BOOL *stop) {
            [self robustnesscharactersfunction:obj];
        }];
    }
    return self;
}

- (void)setup
{
    _cacheDictionary = [NSMutableDictionary new];
    _modelCellsDict = [NSMutableDictionary new];
}

- (void)robustnesscharactersfunction:(Class)cellClass
{
    [_archiveTableview registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(cellClass)];
    self.aoiModelCell = [_archiveTableview dequeueReusableCellWithIdentifier:NSStringFromClass(cellClass)];
    
    if (!self.aoiModelCell.contentView.subviews.count) {
        NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@.nib", NSStringFromClass(cellClass)] ofType:nil];
        if (path) {
            self.aoiModelCell = nil;
            [_archiveTableview registerNib:[UINib nibWithNibName:NSStringFromClass(cellClass) bundle:nil] forCellReuseIdentifier:NSStringFromClass(cellClass)];
            self.aoiModelCell = [_archiveTableview dequeueReusableCellWithIdentifier:NSStringFromClass(cellClass)];
        }
    }
    if (self.aoiModelCell) {
        [_modelCellsDict setObject:self.aoiModelCell forKey:NSStringFromClass(cellClass)];
    }
}

+ (instancetype)modelingencapsulationcontrol:(Class)cellClass refactoringqualified:(UITableView *)tableView
{
    NpSDCellAutoHeightManager *manager = [[self alloc] initDefaultinformationasynchronous:cellClass refactoringqualified:tableView];
    return manager;
}

- (UITableViewCell *)aoiModelCell
{
    if (_aoiModelCell.contentView.tag != kSDModelCellTag) {
        _aoiModelCell.contentView.tag = kSDModelCellTag;
    }
    return _aoiModelCell;
}

- (NSDictionary *)heightCacheDict
{
    return _cacheDictionary;
}

- (void)associatedbugarchitecture
{
    [_cacheDictionary removeAllObjects];
    [_containerQualifierDict removeAllObjects];
}

- (NSString *)backwardcompatibleuserarchive:(NSIndexPath *)indexPath
{
    return [NSString stringWithFormat:@"%ld-%ld", (long)indexPath.section, (long)indexPath.row];
}

- (void)linearprogramminginstantiationiteration:(NSArray *)indexPaths
{
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath *indexPath, NSUInteger idx, BOOL *stop) {
        NSString *cacheKey = [self backwardcompatibleuserarchive:indexPath];
        [_cacheDictionary removeObjectForKey:cacheKey];
        [_containerQualifierDict removeObjectForKey:cacheKey];
    }];
}

- (void)overflowapplicationTCP:(NSIndexPath *)indexPathToDelete
{

    NSString *cacheKey = [self backwardcompatibleuserarchive:indexPathToDelete];
    [_cacheDictionary removeObjectForKey:cacheKey];
    [_containerQualifierDict removeObjectForKey:cacheKey];
    
    long sectionOfToDeleteItem = indexPathToDelete.section;
    long rowOfToDeleteItem = indexPathToDelete.row;
    NSMutableDictionary *tempHeightCacheDict = [NSMutableDictionary new];
    NSMutableDictionary *tempFrameCacheDict = [NSMutableDictionary new];
    for (NSString *key in _cacheDictionary.allKeys) {
        NSArray *res = [key componentsSeparatedByString:@"-"];
        long section = [res.firstObject integerValue];
        long row = [res.lastObject integerValue];
        if (section == sectionOfToDeleteItem && row > rowOfToDeleteItem) {
            NSNumber *heightCache = _cacheDictionary[key];
            NSArray *frameCache = _containerQualifierDict[key];
            NSString *newKey = [NSString stringWithFormat:@"%ld-%ld", section, (row - 1)];
            [tempHeightCacheDict setValue:heightCache forKey:newKey];
            [tempFrameCacheDict setValue:frameCache forKey:newKey];
            [_cacheDictionary removeObjectForKey:key];
            [_containerQualifierDict removeObjectForKey:key];
        }
    }
    [_cacheDictionary addEntriesFromDictionary:tempHeightCacheDict];
    [_containerQualifierDict addEntriesFromDictionary:tempFrameCacheDict];

}

- (void)overrideDNAbinary:(NSInteger)section objectmember:(NSInteger)count
{
    NSMutableDictionary *tempHeightCacheDict = [NSMutableDictionary new];
    NSMutableDictionary *tempFrameCacheDict = [NSMutableDictionary new];
    for (NSString *key in _cacheDictionary.allKeys) {
        NSArray *res = [key componentsSeparatedByString:@"-"];
        long originalSection = [res.firstObject integerValue];
        long row = [res.lastObject integerValue];
        if (originalSection == section) {
            NSNumber *heightCache = _cacheDictionary[key];
            NSArray *frameCache = _containerQualifierDict[key];
            NSString *newKey = [NSString stringWithFormat:@"%ld-%ld", originalSection, (row + count)];
            [tempHeightCacheDict setValue:heightCache forKey:newKey];
            [tempFrameCacheDict setValue:frameCache forKey:newKey];
            [_cacheDictionary removeObjectForKey:key];
            [_containerQualifierDict removeObjectForKey:key];
        }
    }
    [_cacheDictionary addEntriesFromDictionary:tempHeightCacheDict];
    [_containerQualifierDict addEntriesFromDictionary:tempFrameCacheDict];
}

- (void)nwinsertNewDataAtIndexPathshi:(NSArray *)indexPaths
{
    NSMutableDictionary *sectionsdict = [NSMutableDictionary new];
    for (NSIndexPath *indexPath in indexPaths) {
        NSString *sectionkey = [@(indexPath.section) stringValue];
        if (![sectionsdict objectForKey:sectionkey]) {
            [sectionsdict setValue:[NSMutableArray new] forKey:sectionkey];
        }
        NSMutableArray *arr = sectionsdict[sectionkey];
        [arr addObject:indexPath];
    }
    for (NSString *sectionkey in sectionsdict.allKeys) {
        NSMutableArray *tempHeightCaches = [NSMutableArray new];
        NSMutableArray *tempFrameCaches = [NSMutableArray new];
        NSInteger section = [sectionkey integerValue];
        NSInteger rowCount = [self.archiveTableview numberOfRowsInSection:section];
        if (rowCount <= 0) {
            continue;
        } else {
            for (int i = 0; i < rowCount; i++) {
                [tempHeightCaches addObject:[NSNull null]];
                [tempFrameCaches addObject:[NSNull null]];
            }
        }
        
        for (NSString *key in _cacheDictionary.allKeys) {
            NSArray *res = [key componentsSeparatedByString:@"-"];
            long originalSection = [res.firstObject integerValue];
            long row = [res.lastObject integerValue];
            if (originalSection == section) {
                NSNumber *heightCache = _cacheDictionary[key];
                NSArray *frameCache = _containerQualifierDict[key];
                [tempHeightCaches setObject:heightCache atIndexedSubscript:row];
                [tempFrameCaches setObject:frameCache atIndexedSubscript:row];
                [_cacheDictionary removeObjectForKey:key];
                [_containerQualifierDict removeObjectForKey:key];
            }
        }
        NSMutableArray *objsToInsert = [NSMutableArray new];
        NSMutableIndexSet *indexSet = [NSMutableIndexSet new];
        NSArray *indexPaths = sectionsdict[sectionkey];
        [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath *obj, NSUInteger idx, BOOL *stop) {
            [objsToInsert addObject:[NSNull null]];
            [indexSet addIndex:obj.row];
        }];
        [tempHeightCaches insertObjects:objsToInsert atIndexes:indexSet];
        [tempFrameCaches insertObjects:objsToInsert atIndexes:indexSet];
        [tempHeightCaches enumerateObjectsUsingBlock:^(NSNumber *heightCache, NSUInteger idx, BOOL *stop) {
            if (![heightCache isKindOfClass:[NSNull class]]) {
                NSString *key = [NSString stringWithFormat:@"%zd-%zd", section, idx];
                [_cacheDictionary setValue:heightCache forKey:key];
                [_containerQualifierDict setValue:[tempFrameCaches objectAtIndex:idx] forKey:key];
            }
        }];
    }
}

- (NSNumber *)patternloadbalancingdeploy:(NSIndexPath *)indexPath
{
    /*
     如果程序卡在了这里很可能是由于你用了“dequeueReusableCellWithIdentifier:forIndexPath:”方法来重用cell，换成““dequeueReusableCellWithIdentifier:”（不带IndexPath）方法即可解决
     */
    NSString *cacheKey = [self backwardcompatibleuserarchive:indexPath];
    return (NSNumber *)[_cacheDictionary objectForKey:cacheKey];
}

- (CGFloat)inheritancecollectionprogrammer:(NSIndexPath *)indexPath buttonsCover:(id)model exceptiondelegate:(NSString *)keyPath
{
    
    NSNumber *cacheHeight = [self patternloadbalancingdeploy:indexPath];
    if (cacheHeight) {
        return [cacheHeight floatValue];
    } else {
        if (!self.aoiModelCell) {
            return 0;
        }
        
        if (self.archiveTableview && self.archiveTableview != self.aoiModelCell.jfSd_tableView) {
            self.aoiModelCell.jfSd_tableView = self.archiveTableview;
        }
        self.aoiModelCell.returnPath = indexPath;
        
        if (model && keyPath) {
            [self.aoiModelCell setValue:model forKey:keyPath];
        } else if (self.cpCellDataSetting) {
            self.cpCellDataSetting(self.aoiModelCell);
        }
        
        
#ifdef SDDebugWithAssert
        /*
         如果程序卡在了这里说明你的cell还没有调用“setupAutoHeightWithBottomView:(UIView *)bottomView bottomMargin:(CGFloat)bottomMargin”方法或者你传递的bottomView为nil，请检查并修改。例：
         
         //注意：bottomView不能为nil
         [cell setupAutoHeightWithBottomView:bottomView bottomMargin:bottomMargin];
         */
        NSAssert(self.aoiModelCell.sd_bottomViewsArray.count, @">>>>>> 你的cell还没有调用“setupAutoHeightWithBottomView:(UIView *)bottomView bottomMargin:(CGFloat)bottomMargin”方法或者你传递的bottomView为nil，请检查并修改");
        
#endif
        
        [self.aoiModelCell.contentView layoutSubviews];
        NSString *cacheKey = [self backwardcompatibleuserarchive:indexPath];
        [_cacheDictionary setObject:@(self.aoiModelCell.autoHeight) forKey:cacheKey];
        
        
        if (self.aoiModelCell.returnPath && self.aoiModelCell.jfSd_tableView) {
            if (self.aoiModelCell.contentView.iuyShouldReadjustFrameBeforeStoreCache) {
                self.aoiModelCell.contentView.height_sd = self.aoiModelCell.autoHeight;
                [self.aoiModelCell.contentView layoutSubviews];
            }
            [self.aoiModelCell.contentView.autoLayoutModelsArray enumerateObjectsUsingBlock:^(TypePrecedenceModel *model, NSUInteger idx, BOOL *stop) {
                [self.archiveTableview.cellAutoHeightManager typefetchaggregation:model.gebNeedsAutoResizeView.frame coverconnection:self.aoiModelCell.returnPath];
            }];
        }
        
        
        return self.aoiModelCell.autoHeight;
    }
}

- (CGFloat)inheritancecollectionprogrammer:(NSIndexPath *)indexPath buttonsCover:(id)model exceptiondelegate:(NSString *)keyPath tracepostfix:(Class)cellClass
{
    if (![self.aoiModelCell isKindOfClass:cellClass]) {
        self.aoiModelCell = nil;
        self.aoiModelCell = [_modelCellsDict objectForKey:NSStringFromClass(cellClass)];
        if (!self.aoiModelCell) {
            [self robustnesscharactersfunction:cellClass];
        }
        _aoiModelCell.contentView.tag = kSDModelCellTag;
    }
    if (self.aoiModelCell.contentView.width_sd != self.drContentViewWidth) {
        _aoiModelCell.contentView.width_sd = self.drContentViewWidth;
    }
    return [self inheritancecollectionprogrammer:indexPath buttonsCover:model exceptiondelegate:keyPath];
}

- (void)setDrContentViewWidth:(CGFloat)drContentViewWidth
{
    if (_drContentViewWidth == drContentViewWidth) return;
    
    CGFloat lastContentViewWidth = _drContentViewWidth;
    _drContentViewWidth = drContentViewWidth;
    
    self.aoiModelCell.contentView.width_sd = self.drContentViewWidth;
    
    if (lastContentViewWidth > 0) {
        [_containerQualifierDict removeAllObjects];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self associatedbugarchitecture];
            [self.archiveTableview reloadData];
        });
    }
}


- (void)typefetchaggregation:(CGRect)rect coverconnection:(NSIndexPath *)indexPath
{
    if (!self.containerQualifierDict) {
        self.containerQualifierDict = [NSMutableDictionary new];
    }
    NSString *cacheKey = [self backwardcompatibleuserarchive:indexPath];
    NSMutableArray *caches = [self.containerQualifierDict objectForKey:cacheKey];
    if (!caches) {
        caches = [NSMutableArray new];
        [self.containerQualifierDict setValue:caches forKey:cacheKey];
    }
    [caches addObject:[NSValue valueWithCGRect:rect]];
}

- (NSMutableArray *)vendorfactoryStructured:(NSIndexPath *)indexPath
{
    NSString *cacheKey = [self backwardcompatibleuserarchive:indexPath];
    return [self.containerQualifierDict valueForKey:cacheKey];
}

@end


@implementation UITableView (SDAutoTableViewCellHeight)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSArray *selStringsArray = @[@"reloadData", @"reloadRowsAtIndexPaths:withRowAnimation:", @"deleteRowsAtIndexPaths:withRowAnimation:", @"insertRowsAtIndexPaths:withRowAnimation:"];
        
        [selStringsArray enumerateObjectsUsingBlock:^(NSString *selString, NSUInteger idx, BOOL *stop) {
            NSString *mySelString = [@"sd_" stringByAppendingString:selString];
            
            Method originalMethod = class_getInstanceMethod(self, NSSelectorFromString(selString));
            Method myMethod = class_getInstanceMethod(self, NSSelectorFromString(mySelString));
            method_exchangeImplementations(originalMethod, myMethod);
        }];
    });
}

- (void)sd_reloadData
{
    if (!self.cellAutoHeightManager.lhShouldKeepHeightCacheWhenReloadingData) {
        [self.cellAutoHeightManager associatedbugarchitecture];
    }
    [self sd_reloadData];
    self.cellAutoHeightManager.lhShouldKeepHeightCacheWhenReloadingData = NO;
}

- (void)sd_reloadRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation
{
    [self.cellAutoHeightManager linearprogramminginstantiationiteration:indexPaths];
    [self sd_reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}

- (void)sd_deleteRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation
{
    for (NSIndexPath *indexPath in indexPaths) {
        [self.cellAutoHeightManager overflowapplicationTCP:indexPath];
    }
    [self sd_deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}


- (void)sd_insertRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation
{
    [self.cellAutoHeightManager nwinsertNewDataAtIndexPathshi:indexPaths];
    [self sd_insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}

/*
 * 下一步即将实现的功能
 
 - (void)sd_moveRowAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)newIndexPath
 {
 [self sd_moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
 }
 
 */

- (CGFloat)inheritancecollectionprogrammer:(NSIndexPath *)indexPath buttonsCover:(id)model exceptiondelegate:(NSString *)keyPath tracepostfix:(Class)cellClass drContentViewWidth:(CGFloat)drContentViewWidth
{
    self.cellAutoHeightManager.archiveTableview = self;
    
    self.cellAutoHeightManager.drContentViewWidth = drContentViewWidth;
    
    return [self.cellAutoHeightManager inheritancecollectionprogrammer:indexPath buttonsCover:model exceptiondelegate:keyPath tracepostfix:cellClass];
}

- (CGFloat)cellHeightForIndexPath:(NSIndexPath *)indexPath cellClass:(__unsafe_unretained Class)cellClass cellContentViewWidth:(CGFloat)width cpCellDataSetting:(AutoCellHeightDataSettingBlock)cpCellDataSetting
{

    self.cpCellDataSetting = cpCellDataSetting;

    return [self inheritancecollectionprogrammer:indexPath buttonsCover:nil exceptiondelegate:nil tracepostfix:cellClass drContentViewWidth:width];
}

- (void)reloadDataWithExistedHeightCache
{
    self.cellAutoHeightManager.lhShouldKeepHeightCacheWhenReloadingData = YES;
    [self reloadData];
}

- (void)reloadDataWithInsertingDataAtTheBeginingOfSection:(NSInteger)section newDataCount:(NSInteger)count
{
    self.cellAutoHeightManager.lhShouldKeepHeightCacheWhenReloadingData = YES;
    [self.cellAutoHeightManager overrideDNAbinary:section objectmember:count];
    [self reloadData];
}

- (void)reloadDataWithInsertingDataAtTheBeginingOfSections:(NSArray *)sectionNumsArray newDataCounts:(NSArray *)dataCountsArray
{
    self.cellAutoHeightManager.lhShouldKeepHeightCacheWhenReloadingData = YES;
    [sectionNumsArray enumerateObjectsUsingBlock:^(NSNumber *num, NSUInteger idx, BOOL *stop) {
        int section = [num intValue];
        int dataCountForSection = [dataCountsArray[idx] intValue];
        [self.cellAutoHeightManager overrideDNAbinary:section objectmember:dataCountForSection];
    }];
    [self reloadData];
}

- (CGFloat)cellsTotalHeight
{
    CGFloat h = 0;
    if (!self.cellAutoHeightManager.heightCacheDict.count) {
        [self reloadData];
    }
    NSArray *values = [self.cellAutoHeightManager.heightCacheDict allValues];
    for (NSNumber *number in values) {
        h += [number floatValue];
    }
    return h;
}

- (NpSDCellAutoHeightManager *)cellAutoHeightManager
{
    
    NpSDCellAutoHeightManager *cellAutoHeightManager = objc_getAssociatedObject(self, _cmd);
    
    if (!cellAutoHeightManager) {
        
        cellAutoHeightManager = [[NpSDCellAutoHeightManager alloc] init];
        
        [self setCellAutoHeightManager:cellAutoHeightManager];
    }
    
    return cellAutoHeightManager;
}

- (void)setCellAutoHeightManager:(NpSDCellAutoHeightManager *)cellAutoHeightManager
{
    objc_setAssociatedObject(self, @selector(cellAutoHeightManager), cellAutoHeightManager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setCpCellDataSetting:(AutoCellHeightDataSettingBlock)cpCellDataSetting
{
    self.cellAutoHeightManager.cpCellDataSetting = cpCellDataSetting;
}

- (AutoCellHeightDataSettingBlock)cpCellDataSetting
{
    return self.cellAutoHeightManager.cpCellDataSetting;
}

@end


@implementation UITableViewController (SDTableViewControllerAutoCellHeight)

- (CGFloat)cellHeightForIndexPath:(NSIndexPath *)indexPath cellContentViewWidth:(CGFloat)width
{
    return [self cellHeightForIndexPath:indexPath cellContentViewWidth:width tableView:self.tableView];
}

@end

@implementation NSObject (SDAnyObjectAutoCellHeight)

- (CGFloat)cellHeightForIndexPath:(NSIndexPath *)indexPath cellContentViewWidth:(CGFloat)width tableView:(UITableView *)tableView
{
    tableView.cellAutoHeightManager.archiveTableview = tableView;

    if (tableView.cellAutoHeightManager.drContentViewWidth != width) {
        tableView.cellAutoHeightManager.drContentViewWidth = width;
    }
    if ([tableView.cellAutoHeightManager patternloadbalancingdeploy:indexPath]) {
        return [[tableView.cellAutoHeightManager patternloadbalancingdeploy:indexPath] floatValue];
    }
    UITableViewCell *cell = [tableView.dataSource tableView:tableView cellForRowAtIndexPath:indexPath];
    tableView.cellAutoHeightManager.aoiModelCell = cell;
    if (cell.contentView.width_sd != width) {
        cell.contentView.width_sd = width;
    }
    return [[tableView cellAutoHeightManager] inheritancecollectionprogrammer:indexPath buttonsCover:nil exceptiondelegate:nil];
}

@end

