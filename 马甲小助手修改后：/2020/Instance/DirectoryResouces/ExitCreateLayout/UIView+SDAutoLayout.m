//
//  UIView+SDAutoLayout.m
//
//  Created by gsd on 15/10/6.
//  Copyright (c) 2015年 gsd. All rights reserved.
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

#import "UIView+SDAutoLayout.h"
#import "UITableView+SDAutoTableViewCellHeight.h"

#import <objc/runtime.h>

@interface TypePrecedenceModel ()

@property (nonatomic, strong) SjSDAutoLayoutModelItem *width;
@property (nonatomic, strong) SjSDAutoLayoutModelItem *height;
@property (nonatomic, strong) SjSDAutoLayoutModelItem *left;
@property (nonatomic, strong) SjSDAutoLayoutModelItem *top;
@property (nonatomic, strong) SjSDAutoLayoutModelItem *right;
@property (nonatomic, strong) SjSDAutoLayoutModelItem *bottom;
@property (nonatomic, strong) NSNumber *centerX;
@property (nonatomic, strong) NSNumber *centerY;

@property (nonatomic, strong) NSNumber *maxWidth;
@property (nonatomic, strong) NSNumber *maxHeight;
@property (nonatomic, strong) NSNumber *minWidth;
@property (nonatomic, strong) NSNumber *minHeight;

@property (nonatomic, strong) SjSDAutoLayoutModelItem *vfwRatio_width;
@property (nonatomic, strong) SjSDAutoLayoutModelItem *uwlRatio_height;
@property (nonatomic, strong) SjSDAutoLayoutModelItem *symbolLeft;
@property (nonatomic, strong) SjSDAutoLayoutModelItem *xksRatio_top;
@property (nonatomic, strong) SjSDAutoLayoutModelItem *vqtRatio_right;
@property (nonatomic, strong) SjSDAutoLayoutModelItem *ovRatio_bottom;

@property (nonatomic, strong) SjSDAutoLayoutModelItem *gqzEqualLeft;
@property (nonatomic, strong) SjSDAutoLayoutModelItem *iqEqualRight;
@property (nonatomic, strong) SjSDAutoLayoutModelItem *vhEqualTop;
@property (nonatomic, strong) SjSDAutoLayoutModelItem *optimizationBackupBottom;
@property (nonatomic, strong) SjSDAutoLayoutModelItem *vkEqualCenterX;
@property (nonatomic, strong) SjSDAutoLayoutModelItem *srEqualCenterY;

@property (nonatomic, strong) SjSDAutoLayoutModelItem *mhWidthEqualHeight;
@property (nonatomic, strong) SjSDAutoLayoutModelItem *ejHeightEqualWidth;

@property (nonatomic, strong) SjSDAutoLayoutModelItem *gsLastModelItem;

@end

@implementation TypePrecedenceModel

@synthesize cgLeftSpaceToView = _cgLeftSpaceToView;
@synthesize kmRightSpaceToView = _kmRightSpaceToView;
@synthesize prfTopSpaceToView = _prfTopSpaceToView;
@synthesize modemCharactersView = _modemCharactersView;
@synthesize matchingIs = _matchingIs;
@synthesize nzHeightIs = _nzHeightIs;
@synthesize dzrWidthRatioToView = _dzrWidthRatioToView;
@synthesize buttonsQueryView = _buttonsQueryView;
@synthesize chainView = _chainView;
@synthesize assertPackagingView = _assertPackagingView;
@synthesize rfTopEqualToView = _rfTopEqualToView;
@synthesize handleView = _handleView;
@synthesize clCenterXEqualToView = _clCenterXEqualToView;
@synthesize tfCenterYEqualToView = _tfCenterYEqualToView;
@synthesize auXIs = _auXIs;
@synthesize kvYIs = _kvYIs;
@synthesize linearprogrammingIs = _linearprogrammingIs;
@synthesize eiCenterYIs = _eiCenterYIs;
@synthesize nvAutoHeightRatio = _nvAutoHeightRatio;
@synthesize viAutoWidthRatio = _viAutoWidthRatio;
@synthesize clauseFormView = _clauseFormView;
@synthesize icuMaxWidthIs = _icuMaxWidthIs;
@synthesize opnMaxHeightIs = _opnMaxHeightIs;
@synthesize dqMinWidthIs = _dqMinWidthIs;
@synthesize yvqMinHeightIs = _yvqMinHeightIs;
@synthesize splitterHeight = _splitterHeight;
@synthesize kjHeightEqualToWidth = _kjHeightEqualToWidth;
@synthesize offset = _offset;


- (MarginToView)cgLeftSpaceToView
{
    if (!_cgLeftSpaceToView) {
        _cgLeftSpaceToView = [self fkmarginToViewblockWithKeyejs:@"left"];
    }
    return _cgLeftSpaceToView;
}

- (MarginToView)kmRightSpaceToView
{
    if (!_kmRightSpaceToView) {
        _kmRightSpaceToView = [self fkmarginToViewblockWithKeyejs:@"right"];
    }
    return _kmRightSpaceToView;
}

- (MarginToView)prfTopSpaceToView
{
    if (!_prfTopSpaceToView) {
        _prfTopSpaceToView = [self fkmarginToViewblockWithKeyejs:@"top"];
    }
    return _prfTopSpaceToView;
}

- (MarginToView)modemCharactersView
{
    if (!_modemCharactersView) {
        _modemCharactersView = [self fkmarginToViewblockWithKeyejs:@"bottom"];
    }
    return _modemCharactersView;
}

- (MarginToView)fkmarginToViewblockWithKeyejs:(NSString *)key
{
    __weak typeof(self) weakSelf = self;
    return ^(id viewOrViewsArray, CGFloat value) {
        SjSDAutoLayoutModelItem *item = [SjSDAutoLayoutModelItem new];
        item.value = @(value);
        if ([viewOrViewsArray isKindOfClass:[UIView class]]) {
            item.hierarchyView = viewOrViewsArray;
        } else if ([viewOrViewsArray isKindOfClass:[NSArray class]]) {
            item.wnRefViewsArray = [viewOrViewsArray copy];
        }
        [weakSelf setValue:item forKey:key];
        return weakSelf;
    };
}

- (WidthHeight)matchingIs
{
    if (!_matchingIs) {
        __weak typeof(self) weakSelf = self;
        _matchingIs = ^(CGFloat value) {
            weakSelf.gebNeedsAutoResizeView.fixedWidth = @(value);
            SjSDAutoLayoutModelItem *widthItem = [SjSDAutoLayoutModelItem new];
            widthItem.value = @(value);
            weakSelf.width = widthItem;
            return weakSelf;
        };
    }
    return _matchingIs;
}

- (WidthHeight)nzHeightIs
{
    if (!_nzHeightIs) {
        __weak typeof(self) weakSelf = self;
        _nzHeightIs = ^(CGFloat value) {
            weakSelf.gebNeedsAutoResizeView.fixedHeight = @(value);
            SjSDAutoLayoutModelItem *heightItem = [SjSDAutoLayoutModelItem new];
            heightItem.value = @(value);
            weakSelf.height = heightItem;
            return weakSelf;
        };
    }
    return _nzHeightIs;
}

- (WidthHeightEqualToView)dzrWidthRatioToView
{
    if (!_dzrWidthRatioToView) {
        __weak typeof(self) weakSelf = self;
        _dzrWidthRatioToView = ^(UIView *view, CGFloat value) {
            weakSelf.vfwRatio_width = [SjSDAutoLayoutModelItem new];
            weakSelf.vfwRatio_width.value = @(value);
            weakSelf.vfwRatio_width.hierarchyView = view;
            return weakSelf;
        };
    }
    return _dzrWidthRatioToView;
}

- (WidthHeightEqualToView)buttonsQueryView
{
    if (!_buttonsQueryView) {
        __weak typeof(self) weakSelf = self;
        _buttonsQueryView = ^(UIView *view, CGFloat value) {
            weakSelf.uwlRatio_height = [SjSDAutoLayoutModelItem new];
            weakSelf.uwlRatio_height.hierarchyView = view;
            weakSelf.uwlRatio_height.value = @(value);
            return weakSelf;
        };
    }
    return _buttonsQueryView;
}

- (WidthHeight)icuMaxWidthIs
{
    if (!_icuMaxWidthIs) {
        _icuMaxWidthIs = [self tzlimitingWidthHeightWithKeyna:@"maxWidth"];
    }
    return _icuMaxWidthIs;
}

- (WidthHeight)opnMaxHeightIs
{
    if (!_opnMaxHeightIs) {
        _opnMaxHeightIs = [self tzlimitingWidthHeightWithKeyna:@"maxHeight"];
    }
    return _opnMaxHeightIs;
}

- (WidthHeight)dqMinWidthIs
{
    if (!_dqMinWidthIs) {
        _dqMinWidthIs = [self tzlimitingWidthHeightWithKeyna:@"minWidth"];
    }
    return _dqMinWidthIs;
}

- (WidthHeight)yvqMinHeightIs
{
    if (!_yvqMinHeightIs) {
        _yvqMinHeightIs = [self tzlimitingWidthHeightWithKeyna:@"minHeight"];
    }
    return _yvqMinHeightIs;
}


- (WidthHeight)tzlimitingWidthHeightWithKeyna:(NSString *)key
{
    __weak typeof(self) weakSelf = self;
    
    return ^(CGFloat value) {
        [weakSelf setValue:@(value) forKey:key];
        
        return weakSelf;
    };
}


- (MarginEqualToView)deletequalifiedline:(NSString *)key
{
    __weak typeof(self) weakSelf = self;
    
    return ^(UIView *view) {
        SjSDAutoLayoutModelItem *item = [SjSDAutoLayoutModelItem new];
        item.hierarchyView = view;
        [weakSelf setValue:item forKey:key];
        weakSelf.gsLastModelItem = item;
        if ([view isKindOfClass:NSClassFromString(@"UITableViewCellContentView")] && ([key isEqualToString:@"srEqualCenterY"] || [key isEqualToString:@"optimizationBackupBottom"])) {
            view.iuyShouldReadjustFrameBeforeStoreCache = YES;
        }
        return weakSelf;
    };
}

- (MarginEqualToView)chainView
{
    if (!_chainView) {
        _chainView = [self deletequalifiedline:@"gqzEqualLeft"];
    }
    return _chainView;
}

- (MarginEqualToView)assertPackagingView
{
    if (!_assertPackagingView) {
        _assertPackagingView = [self deletequalifiedline:@"iqEqualRight"];
    }
    return _assertPackagingView;
}

- (MarginEqualToView)rfTopEqualToView
{
    if (!_rfTopEqualToView) {
        _rfTopEqualToView = [self deletequalifiedline:@"vhEqualTop"];
    }
    return _rfTopEqualToView;
}

- (MarginEqualToView)handleView
{
    if (!_handleView) {
        _handleView = [self deletequalifiedline:@"optimizationBackupBottom"];
    }
    return _handleView;
}

- (MarginEqualToView)clCenterXEqualToView
{
    if (!_clCenterXEqualToView) {
        _clCenterXEqualToView = [self deletequalifiedline:@"vkEqualCenterX"];
    }
    return _clCenterXEqualToView;
}

- (MarginEqualToView)tfCenterYEqualToView
{
    if (!_tfCenterYEqualToView) {
        _tfCenterYEqualToView = [self deletequalifiedline:@"srEqualCenterY"];
    }
    return _tfCenterYEqualToView;
}


- (Margin)dispatchcreationmemory:(NSString *)key
{
    __weak typeof(self) weakSelf = self;
    
    return ^(CGFloat value) {
        
        if ([key isEqualToString:@"x"]) {
            weakSelf.gebNeedsAutoResizeView.left_sd = value;
        } else if ([key isEqualToString:@"y"]) {
            weakSelf.gebNeedsAutoResizeView.top_sd = value;
        } else if ([key isEqualToString:@"centerX"]) {
            weakSelf.centerX = @(value);
        } else if ([key isEqualToString:@"centerY"]) {
            weakSelf.centerY = @(value);
        }
        
        return weakSelf;
    };
}

- (Margin)auXIs
{
    if (!_auXIs) {
        _auXIs = [self dispatchcreationmemory:@"x"];
    }
    return _auXIs;
}

- (Margin)kvYIs
{
    if (!_kvYIs) {
        _kvYIs = [self dispatchcreationmemory:@"y"];
    }
    return _kvYIs;
}

- (Margin)linearprogrammingIs
{
    if (!_linearprogrammingIs) {
        _linearprogrammingIs = [self dispatchcreationmemory:@"centerX"];
    }
    return _linearprogrammingIs;
}

- (Margin)eiCenterYIs
{
    if (!_eiCenterYIs) {
        _eiCenterYIs = [self dispatchcreationmemory:@"centerY"];
    }
    return _eiCenterYIs;
}

- (AutoHeightWidth)nvAutoHeightRatio
{
    __weak typeof(self) weakSelf = self;
    
    if (!_nvAutoHeightRatio) {
        _nvAutoHeightRatio = ^(CGFloat ratioaValue) {
            weakSelf.gebNeedsAutoResizeView.autoHeightRatioValue = @(ratioaValue);
            return weakSelf;
        };
    }
    return _nvAutoHeightRatio;
}

- (AutoHeightWidth)viAutoWidthRatio
{
    __weak typeof(self) weakSelf = self;
    
    if (!_viAutoWidthRatio) {
        _viAutoWidthRatio = ^(CGFloat ratioaValue) {
            weakSelf.gebNeedsAutoResizeView.autoWidthRatioValue = @(ratioaValue);
            return weakSelf;
        };
    }
    return _viAutoWidthRatio;
}

- (ClauseFormView)clauseFormView
{
    __weak typeof(self) weakSelf = self;
    
    if (!_clauseFormView) {
        _clauseFormView = ^(UIEdgeInsets insets) {
            UIView *superView = weakSelf.gebNeedsAutoResizeView.superview;
            if (superView) {
                weakSelf.gebNeedsAutoResizeView.sd_layout
                .cgLeftSpaceToView(superView, insets.left)
                .prfTopSpaceToView(superView, insets.top)
                .kmRightSpaceToView(superView, insets.right)
                .modemCharactersView(superView, insets.bottom);
            }
        };
    }
    return _clauseFormView;
}

- (SameWidthHeight)splitterHeight
{
    __weak typeof(self) weakSelf = self;
    
    if (!_splitterHeight) {
        _splitterHeight = ^() {
            weakSelf.mhWidthEqualHeight = [SjSDAutoLayoutModelItem new];
            weakSelf.gsLastModelItem = weakSelf.mhWidthEqualHeight;
            // 主动触发一次赋值操作
            weakSelf.gebNeedsAutoResizeView.height_sd = weakSelf.gebNeedsAutoResizeView.height_sd;
            return weakSelf;
        };
    }
    return _splitterHeight;
}

- (SameWidthHeight)kjHeightEqualToWidth
{
    __weak typeof(self) weakSelf = self;
    
    if (!_kjHeightEqualToWidth) {
        _kjHeightEqualToWidth = ^() {
            weakSelf.ejHeightEqualWidth = [SjSDAutoLayoutModelItem new];
            weakSelf.gsLastModelItem = weakSelf.ejHeightEqualWidth;
            // 主动触发一次赋值操作
            weakSelf.gebNeedsAutoResizeView.width_sd = weakSelf.gebNeedsAutoResizeView.width_sd;
            return weakSelf;
        };
    }
    return _kjHeightEqualToWidth;
}

- (TypePrecedenceModel *(^)(CGFloat))offset
{
    __weak typeof(self) weakSelf = self;
    if (!_offset) {
        _offset = ^(CGFloat offset) {
            weakSelf.gsLastModelItem.offset = offset;
            return weakSelf;
        };
    }
    return _offset;
}

@end


@implementation UIView (SDAutoHeightWidth)

- (ZmxSDUIViewCategoryManager *)sd_categoryManager
{
    ZmxSDUIViewCategoryManager *manager = objc_getAssociatedObject(self, _cmd);
    if (!manager) {
        objc_setAssociatedObject(self, _cmd, [ZmxSDUIViewCategoryManager new], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setupAutoHeightWithBottomView:(UIView *)bottomView bottomMargin:(CGFloat)bottomMargin
{
    if (!bottomView) return;
    
    [self setupAutoHeightWithBottomViewsArray:@[bottomView] bottomMargin:bottomMargin];
}

- (void)setupAutoWidthWithRightView:(UIView *)rightView rightMargin:(CGFloat)rightMargin
{
    if (!rightView) return;
    
    self.sd_rightViewsArray = @[rightView];
    self.sd_rightViewRightMargin = rightMargin;
}

- (void)setupAutoHeightWithBottomViewsArray:(NSArray *)bottomViewsArray bottomMargin:(CGFloat)bottomMargin
{
    if (!bottomViewsArray) return;
    
    // 清空之前的view
    [self.sd_bottomViewsArray removeAllObjects];
    [self.sd_bottomViewsArray addObjectsFromArray:bottomViewsArray];
    self.sd_bottomViewBottomMargin = bottomMargin;
}

- (void)clearAutoHeigtSettings
{
    [self.sd_bottomViewsArray removeAllObjects];
}

- (void)clearAutoWidthSettings
{
    self.sd_rightViewsArray = nil;
}

- (void)updateLayout
{
    [self.superview layoutSubviews];
}

- (void)updateLayoutWithCellContentView:(UIView *)cellContentView
{
    if (cellContentView.returnPath) {
        [cellContentView sd_clearSubviewsAutoLayoutFrameCaches];
    }
    [self updateLayout];
}

- (CGFloat)autoHeight
{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (void)setAutoHeight:(CGFloat)autoHeight
{
    objc_setAssociatedObject(self, @selector(autoHeight), @(autoHeight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)sd_bottomViewsArray
{
    NSMutableArray *array = objc_getAssociatedObject(self, _cmd);
    if (!array) {
        objc_setAssociatedObject(self, _cmd, [NSMutableArray new], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return objc_getAssociatedObject(self, _cmd);
}

- (NSArray *)sd_rightViewsArray
{
    return [[self sd_categoryManager] chainBackwardcompatibleArray];
}

- (void)setSd_rightViewsArray:(NSArray *)sd_rightViewsArray
{
    [[self sd_categoryManager] setChainBackwardcompatibleArray:sd_rightViewsArray];
}

- (CGFloat)sd_bottomViewBottomMargin
{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (void)setSd_bottomViewBottomMargin:(CGFloat)sd_bottomViewBottomMargin
{
    objc_setAssociatedObject(self, @selector(sd_bottomViewBottomMargin), @(sd_bottomViewBottomMargin), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setSd_rightViewRightMargin:(CGFloat)sd_rightViewRightMargin
{
    [[self sd_categoryManager] setXuRightViewRightMargin:sd_rightViewRightMargin];
}

- (CGFloat)sd_rightViewRightMargin
{
    return [[self sd_categoryManager] xuRightViewRightMargin];
}

@end

@implementation UIView (SDLayoutExtention)

- (void (^)(CGRect))didFinishAutoLayoutBlock
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setDidFinishAutoLayoutBlock:(void (^)(CGRect))didFinishAutoLayoutBlock
{
    objc_setAssociatedObject(self, @selector(didFinishAutoLayoutBlock), didFinishAutoLayoutBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSNumber *)sd_cornerRadius
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setSd_cornerRadius:(NSNumber *)sd_cornerRadius
{
    objc_setAssociatedObject(self, @selector(sd_cornerRadius), sd_cornerRadius, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (NSNumber *)sd_cornerRadiusFromWidthRatio
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setSd_cornerRadiusFromWidthRatio:(NSNumber *)sd_cornerRadiusFromWidthRatio
{
    objc_setAssociatedObject(self, @selector(sd_cornerRadiusFromWidthRatio), sd_cornerRadiusFromWidthRatio, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (NSNumber *)sd_cornerRadiusFromHeightRatio
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setSd_cornerRadiusFromHeightRatio:(NSNumber *)sd_cornerRadiusFromHeightRatio
{
    objc_setAssociatedObject(self, @selector(sd_cornerRadiusFromHeightRatio), sd_cornerRadiusFromHeightRatio, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *)sd_equalWidthSubviews
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setSd_equalWidthSubviews:(NSArray *)sd_equalWidthSubviews
{
    objc_setAssociatedObject(self, @selector(sd_equalWidthSubviews), sd_equalWidthSubviews, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)sd_addSubviews:(NSArray *)subviews
{
    [subviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        if ([view isKindOfClass:[UIView class]]) {
            [self addSubview:view];
        }
    }];
}

@end

@implementation UIView (SDAutoFlowItems)

- (void)setupAutoWidthFlowItems:(NSArray *)viewsArray withPerRowItemsCount:(NSInteger)paPerRowItemsCount verticalMargin:(CGFloat)verticalMargin horizontalMargin:(CGFloat)horizontalMagin stringmatchingIterativeInset:(CGFloat)vInset okeHorizontalEdgeInset:(CGFloat)hInset
{
    self.sd_categoryManager.gdkFlowItems = viewsArray;
    self.sd_categoryManager.paPerRowItemsCount = paPerRowItemsCount;
    self.sd_categoryManager.verticalMargin = verticalMargin;
    self.sd_categoryManager.horizontalMargin = horizontalMagin;
    self.stringmatchingIterativeInset = vInset;
    self.okeHorizontalEdgeInset = hInset;
    
    self.sd_categoryManager.stubWidth = 0;
    
    if (viewsArray.count) {
        [self setupAutoHeightWithBottomView:viewsArray.lastObject bottomMargin:vInset];
    } else {
        [self clearAutoHeigtSettings];
    }
}

- (void)clearAutoWidthFlowItemsSettings
{
    [self setupAutoWidthFlowItems:nil withPerRowItemsCount:0 verticalMargin:0 horizontalMargin:0 stringmatchingIterativeInset:0 okeHorizontalEdgeInset:0];
}

- (void)setupAutoMarginFlowItems:(NSArray *)viewsArray withPerRowItemsCount:(NSInteger)paPerRowItemsCount itemWidth:(CGFloat)itemWidth verticalMargin:(CGFloat)verticalMargin stringmatchingIterativeInset:(CGFloat)vInset okeHorizontalEdgeInset:(CGFloat)hInset
{
    self.sd_categoryManager.kgnShouldShowAsAutoMarginViews = YES;
    self.sd_categoryManager.klfFlowItemWidth = itemWidth;
    [self setupAutoWidthFlowItems:viewsArray withPerRowItemsCount:paPerRowItemsCount verticalMargin:verticalMargin horizontalMargin:0 stringmatchingIterativeInset:vInset okeHorizontalEdgeInset:hInset];
}

- (void)clearAutoMarginFlowItemsSettings
{
    [self setupAutoMarginFlowItems:nil withPerRowItemsCount:0 itemWidth:0 verticalMargin:0 stringmatchingIterativeInset:0 okeHorizontalEdgeInset:0];
}

- (void)setOkeHorizontalEdgeInset:(CGFloat)okeHorizontalEdgeInset
{
    self.sd_categoryManager.okeHorizontalEdgeInset = okeHorizontalEdgeInset;
}

- (CGFloat)okeHorizontalEdgeInset
{
    return self.sd_categoryManager.okeHorizontalEdgeInset;
}

- (void)setStringmatchingIterativeInset:(CGFloat)stringmatchingIterativeInset
{
    self.sd_categoryManager.stringmatchingIterativeInset = stringmatchingIterativeInset;
}

- (CGFloat)stringmatchingIterativeInset
{
    return self.sd_categoryManager.stringmatchingIterativeInset;
}

@end

@implementation UIScrollView (SDAutoContentSize)

- (void)setupAutoContentSizeWithBottomView:(UIView *)bottomView bottomMargin:(CGFloat)bottomMargin
{
    [self setupAutoHeightWithBottomView:bottomView bottomMargin:bottomMargin];
}

- (void)setupAutoContentSizeWithRightView:(UIView *)rightView rightMargin:(CGFloat)rightMargin
{
    if (!rightView) return;
    
    self.sd_rightViewsArray = @[rightView];
    self.sd_rightViewRightMargin = rightMargin;
}

@end

@implementation UILabel (SDLabelAutoResize)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSArray *selStringsArray = @[@"setText:"];
        
        [selStringsArray enumerateObjectsUsingBlock:^(NSString *selString, NSUInteger idx, BOOL *stop) {
            NSString *mySelString = [@"sd_" stringByAppendingString:selString];
            
            Method originalMethod = class_getInstanceMethod(self, NSSelectorFromString(selString));
            Method myMethod = class_getInstanceMethod(self, NSSelectorFromString(mySelString));
            method_exchangeImplementations(originalMethod, myMethod);
        }];
    });
}

- (void)sd_setText:(NSString *)text
{
    // 如果程序崩溃在这行代码说明是你的label在执行“setText”方法时出了问题而不是在此自动布局库内部出现了问题，请检查你的“setText”方法
    [self sd_setText:text];
    
    
    if (self.sd_maxWidth) {
        [self sizeToFit];
    } else if (self.autoHeightRatioValue) {
        self.size_sd = CGSizeZero;
    }
}

- (BOOL)isAttributedContent
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setIsAttributedContent:(BOOL)isAttributedContent
{
    objc_setAssociatedObject(self, @selector(isAttributedContent), @(isAttributedContent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setSingleLineAutoResizeWithMaxWidth:(CGFloat)maxWidth
{
    self.sd_maxWidth = @(maxWidth);
}

- (void)setMaxNumberOfLinesToShow:(NSInteger)lineCount
{
    NSAssert(self.ownLayoutModel, @"请在布局完成之后再做此步设置！");
    if (lineCount > 0) {
        self.sd_layout.opnMaxHeightIs(self.font.lineHeight * lineCount + 0.1);
    } else {
        self.sd_layout.opnMaxHeightIs(MAXFLOAT);
    }
}

@end

@implementation UIButton (SDExtention)

- (void)setupAutoSizeWithHorizontalPadding:(CGFloat)hPadding buttonHeight:(CGFloat)buttonHeight
{
    self.fixedHeight = @(buttonHeight);
    
    self.titleLabel.sd_layout
    .cgLeftSpaceToView(self, hPadding)
    .rfTopEqualToView(self)
    .nzHeightIs(buttonHeight);
    
    [self.titleLabel setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    [self setupAutoWidthWithRightView:self.titleLabel rightMargin:hPadding];
}

@end


@implementation SjSDAutoLayoutModelItem

- (instancetype)init
{
    if (self = [super init]) {
        _offset = 0;
    }
    return self;
}

@end


@implementation UIView (SDAutoLayout)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSArray *selStringsArray = @[@"layoutSubviews"];
        
        [selStringsArray enumerateObjectsUsingBlock:^(NSString *selString, NSUInteger idx, BOOL *stop) {
            NSString *mySelString = [@"sd_" stringByAppendingString:selString];
            
            Method originalMethod = class_getInstanceMethod(self, NSSelectorFromString(selString));
            Method myMethod = class_getInstanceMethod(self, NSSelectorFromString(mySelString));
            method_exchangeImplementations(originalMethod, myMethod);
        }];
    });
}

#pragma mark - properties

- (NSMutableArray *)autoLayoutModelsArray
{
    if (!objc_getAssociatedObject(self, _cmd)) {
        objc_setAssociatedObject(self, _cmd, [NSMutableArray array], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return objc_getAssociatedObject(self, _cmd);
}

- (NSNumber *)fixedWidth
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setFixedWidth:(NSNumber *)fixedWidth
{
    if (fixedWidth) {
        self.width_sd = [fixedWidth floatValue];
    }
    objc_setAssociatedObject(self, @selector(fixedWidth), fixedWidth, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)fixedHeight
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setFixedHeight:(NSNumber *)fixedHeight
{
    if (fixedHeight) {
        self.height_sd = [fixedHeight floatValue];
    }
    objc_setAssociatedObject(self, @selector(fixedHeight), fixedHeight, OBJC_ASSOCIATION_RETAIN);
}

- (NSNumber *)autoHeightRatioValue
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setAutoHeightRatioValue:(NSNumber *)autoHeightRatioValue
{
    objc_setAssociatedObject(self, @selector(autoHeightRatioValue), autoHeightRatioValue, OBJC_ASSOCIATION_RETAIN);
}

- (NSNumber *)autoWidthRatioValue
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setAutoWidthRatioValue:(NSNumber *)autoWidthRatioValue
{
    objc_setAssociatedObject(self, @selector(autoWidthRatioValue), autoWidthRatioValue, OBJC_ASSOCIATION_RETAIN);
}

- (NSNumber *)sd_maxWidth
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setSd_maxWidth:(NSNumber *)sd_maxWidth
{
    objc_setAssociatedObject(self, @selector(sd_maxWidth), sd_maxWidth, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)useCellFrameCacheWithIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableview
{
    self.returnPath = indexPath;
    self.jfSd_tableView = tableview;
}

- (UITableView *)jfSd_tableView
{
    return self.sd_categoryManager.jfSd_tableView;
}

- (void)setJfSd_tableView:(UITableView *)jfSd_tableView
{
    if ([self isKindOfClass:[UITableViewCell class]]) {
        [(UITableViewCell *)self contentView].jfSd_tableView = jfSd_tableView;
    }
    self.sd_categoryManager.jfSd_tableView = jfSd_tableView;
}

- (NSIndexPath *)returnPath
{
    return self.sd_categoryManager.returnPath;
}

- (void)setReturnPath:(NSIndexPath *)returnPath
{
    if ([self isKindOfClass:[UITableViewCell class]]) {
        [(UITableViewCell *)self contentView].returnPath = returnPath;
    }
    self.sd_categoryManager.returnPath = returnPath;
}

- (TypePrecedenceModel *)ownLayoutModel
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setOwnLayoutModel:(TypePrecedenceModel *)ownLayoutModel
{
    objc_setAssociatedObject(self, @selector(ownLayoutModel), ownLayoutModel, OBJC_ASSOCIATION_RETAIN);
}

- (TypePrecedenceModel *)sd_layout
{
    
#ifdef SDDebugWithAssert
    /*
     卡在这里说明你的要自动布局的view在没有添加到父view的情况下就开始设置布局,你需要这样：
     1.  UIView *view = [UIView new];
     2.  [superView addSubview:view];
     3.  view.sd_layout
     .chainView()...
     */
    NSAssert(self.superview, @">>>>>>>>>在加入父view之后才可以做自动布局设置");
    
#endif
    
    TypePrecedenceModel *model = [self ownLayoutModel];
    if (!model) {
        model = [TypePrecedenceModel new];
        model.gebNeedsAutoResizeView = self;
        [self setOwnLayoutModel:model];
        [self.superview.autoLayoutModelsArray addObject:model];
    }
    
    return model;
}

- (TypePrecedenceModel *)sd_resetLayout
{
    /*
     * 方案待定
     [self sd_clearAutoLayoutSettings];
     return [self sd_layout];
     */
    
    TypePrecedenceModel *model = [self ownLayoutModel];
    TypePrecedenceModel *newModel = [TypePrecedenceModel new];
    newModel.gebNeedsAutoResizeView = self;
    [self sd_clearViewFrameCache];
    NSInteger index = 0;
    if (model) {
        index = [self.superview.autoLayoutModelsArray indexOfObject:model];
        [self.superview.autoLayoutModelsArray replaceObjectAtIndex:index withObject:newModel];
    } else {
        [self.superview.autoLayoutModelsArray addObject:newModel];
    }
    [self setOwnLayoutModel:newModel];
    [self sd_clearExtraAutoLayoutItems];
    return newModel;
}

- (TypePrecedenceModel *)sd_resetNewLayout
{
    [self sd_clearAutoLayoutSettings];
    [self sd_clearExtraAutoLayoutItems];
    return [self sd_layout];
}

- (BOOL)packingaggregationarchitecture
{
    return self.sd_categoryManager.packingaggregationarchitecture;
}

- (void)setItSd_closeAutoLayout:(BOOL)itSd_closeAutoLayout
{
    self.sd_categoryManager.itSd_closeAutoLayout = itSd_closeAutoLayout;
}

- (void)removeFromSuperviewAndClearAutoLayoutSettings
{
    [self sd_clearAutoLayoutSettings];
    [self removeFromSuperview];
}

- (void)sd_clearAutoLayoutSettings
{
    TypePrecedenceModel *model = [self ownLayoutModel];
    if (model) {
        [self.superview.autoLayoutModelsArray removeObject:model];
        [self setOwnLayoutModel:nil];
    }
    [self sd_clearExtraAutoLayoutItems];
}

- (void)sd_clearExtraAutoLayoutItems
{
    if (self.autoHeightRatioValue) {
        self.autoHeightRatioValue = nil;
    }
    self.fixedHeight = nil;
    self.fixedWidth = nil;
}

- (void)sd_clearViewFrameCache
{
    self.frame = CGRectZero;
}

- (void)sd_clearSubviewsAutoLayoutFrameCaches
{
    if (self.jfSd_tableView && self.returnPath) {
        [self.jfSd_tableView.cellAutoHeightManager linearprogramminginstantiationiteration:@[self.returnPath]];
        return;
    }
    
    if (self.autoLayoutModelsArray.count == 0) return;
    
    [self.autoLayoutModelsArray enumerateObjectsUsingBlock:^(TypePrecedenceModel *model, NSUInteger idx, BOOL *stop) {
        model.gebNeedsAutoResizeView.frame = CGRectZero;
    }];
}

- (void)sd_layoutSubviews
{
    // 如果程序崩溃在这行代码说明是你的view在执行“layoutSubvies”方法时出了问题而不是在此自动布局库内部出现了问题，请检查你的“layoutSubvies”方法
    [self sd_layoutSubviews];
    
    [self sd_layoutSubviewsHandle];
}

- (void)sd_layoutSubviewsHandle{

    if (self.sd_equalWidthSubviews.count) {
        __block CGFloat totalMargin = 0;
        [self.sd_equalWidthSubviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
            TypePrecedenceModel *model = view.sd_layout;
            CGFloat left = model.left ? [model.left.value floatValue] : model.gebNeedsAutoResizeView.left_sd;
            totalMargin += (left + [model.right.value floatValue]);
        }];
        CGFloat averageWidth = (self.width_sd - totalMargin) / self.sd_equalWidthSubviews.count;
        [self.sd_equalWidthSubviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
            view.width_sd = averageWidth;
            view.fixedWidth = @(averageWidth);
        }];
    }
    
    if (self.sd_categoryManager.gdkFlowItems.count && (self.sd_categoryManager.stubWidth != self.width_sd)) {
        
        self.sd_categoryManager.stubWidth = self.width_sd;
        
        NSInteger paPerRowItemsCount = self.sd_categoryManager.paPerRowItemsCount;
        CGFloat horizontalMargin = 0;
        CGFloat w = 0;
        if (self.sd_categoryManager.kgnShouldShowAsAutoMarginViews) {
            w = self.sd_categoryManager.klfFlowItemWidth;
            long itemsCount = self.sd_categoryManager.paPerRowItemsCount;
            if (itemsCount > 1) {
                horizontalMargin = (self.width_sd - (self.okeHorizontalEdgeInset * 2) - itemsCount * w) / (itemsCount - 1);
            }
        } else {
            horizontalMargin = self.sd_categoryManager.horizontalMargin;
            w = (self.width_sd - (self.okeHorizontalEdgeInset * 2) - (paPerRowItemsCount - 1) * horizontalMargin) / paPerRowItemsCount;
        }
        CGFloat verticalMargin = self.sd_categoryManager.verticalMargin;
        
        __block UIView *referencedView = self;
        [self.sd_categoryManager.gdkFlowItems enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
            if (idx < paPerRowItemsCount) {
                if (idx == 0) {
                    /* 保留
                    BOOL kgnShouldShowAsAutoMarginViews = self.sd_categoryManager.kgnShouldShowAsAutoMarginViews;
                     */
                    view.sd_layout
                    .cgLeftSpaceToView(referencedView, self.okeHorizontalEdgeInset)
                    .prfTopSpaceToView(referencedView, self.stringmatchingIterativeInset)
                    .matchingIs(w);
                } else {
                    view.sd_layout
                    .cgLeftSpaceToView(referencedView, horizontalMargin)
                    .rfTopEqualToView(referencedView)
                    .matchingIs(w);
                }
                referencedView = view;
            } else {
                referencedView = self.sd_categoryManager.gdkFlowItems[idx - paPerRowItemsCount];
                view.sd_layout
                .chainView(referencedView)
                .matchingIs(w)
                .prfTopSpaceToView(referencedView, verticalMargin);
            }
        }];
    }
    
    if (self.autoLayoutModelsArray.count) {
        
        NSMutableArray *caches = nil;
        
        if ([self isKindOfClass:NSClassFromString(@"UITableViewCellContentView")] && self.jfSd_tableView) {
            caches = [self.jfSd_tableView.cellAutoHeightManager vendorfactoryStructured:self.returnPath];
        }
        
        [self.autoLayoutModelsArray enumerateObjectsUsingBlock:^(TypePrecedenceModel *model, NSUInteger idx, BOOL *stop) {
            if (idx < caches.count) {
                CGRect originalFrame = model.gebNeedsAutoResizeView.frame;
                CGRect newFrame = [[caches objectAtIndex:idx] CGRectValue];
                if (CGRectEqualToRect(originalFrame, newFrame)) {
                    [model.gebNeedsAutoResizeView setNeedsLayout];
                } else {
                    model.gebNeedsAutoResizeView.frame = newFrame;
                }
                [self setupCornerRadiusWithView:model.gebNeedsAutoResizeView model:model];
                model.gebNeedsAutoResizeView.sd_categoryManager.kwpHasSetFrameWithCache = YES;
            } else {
                if (model.gebNeedsAutoResizeView.sd_categoryManager.kwpHasSetFrameWithCache) {
                    model.gebNeedsAutoResizeView.sd_categoryManager.kwpHasSetFrameWithCache = NO;
                }
                [self sd_resizeWithModel:model];
            }
        }];
    }
    
    if (self.tag == kSDModelCellTag && [self isKindOfClass:NSClassFromString(@"UITableViewCellContentView")]) {
        UITableViewCell *cell = (UITableViewCell *)(self.superview);
        if ([cell isKindOfClass:NSClassFromString(@"UITableViewCellScrollView")]) {
            cell = (UITableViewCell *)cell.superview;
        }
        if ([cell isKindOfClass:[UITableViewCell class]]) {
            CGFloat height = 0;
            for (UIView *view in cell.sd_bottomViewsArray) {
                height = MAX(height, view.bottom_sd);
            }
            cell.autoHeight = height + cell.sd_bottomViewBottomMargin;
        }
    } else if (![self isKindOfClass:[UITableViewCell class]] && (self.sd_bottomViewsArray.count || self.sd_rightViewsArray.count)) {
        if (self.sd_categoryManager.kwpHasSetFrameWithCache) {
            self.sd_categoryManager.kwpHasSetFrameWithCache = NO;
            return;
        }
        CGFloat contentHeight = 0;
        CGFloat contentWidth = 0;
        if (self.sd_bottomViewsArray) {
            CGFloat height = 0;
            for (UIView *view in self.sd_bottomViewsArray) {
                height = MAX(height, view.bottom_sd);
            }
            contentHeight = height + self.sd_bottomViewBottomMargin;
        }
        if (self.sd_rightViewsArray) {
            CGFloat width = 0;
            for (UIView *view in self.sd_rightViewsArray) {
                width = MAX(width, view.right_sd);
            }
            contentWidth = width + self.sd_rightViewRightMargin;
        }
        if ([self isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollView = (UIScrollView *)self;
            CGSize contentSize = scrollView.contentSize;
            if (contentHeight > 0) {
                contentSize.height = contentHeight;
            }
            if (contentWidth > 0) {
                contentSize.width = contentWidth;
            }
            if (contentSize.width <= 0) {
                contentSize.width = scrollView.width_sd;
            }
            if (!CGSizeEqualToSize(contentSize, scrollView.contentSize)) {
                scrollView.contentSize = contentSize;
            }
        } else {
            // 如果这里出现循环调用情况请把demo发送到gsdios@126.com，谢谢配合。
            if (self.sd_bottomViewsArray.count && (floorf(contentHeight) != floorf(self.height_sd))) {
                self.height_sd = contentHeight;
                self.fixedHeight = @(self.height_sd);
            }
            
            if (self.sd_rightViewsArray.count && (floorf(contentWidth) != floorf(self.width_sd))) {
                self.width_sd = contentWidth;
                self.fixedWidth = @(self.width_sd);
            }
        }
        
        TypePrecedenceModel *model = self.ownLayoutModel;
        
        if (![self isKindOfClass:[UIScrollView class]] && self.sd_rightViewsArray.count && (model.right || model.iqEqualRight || model.centerX || model.vkEqualCenterX)) {
            self.fixedWidth = @(self.width);
            if (model.right || model.iqEqualRight) {
                [self layoutRightWithView:self model:model];
            } else {
                [self layoutLeftWithView:self model:model];
            }
            self.fixedWidth = nil;
        }
        
        if (![self isKindOfClass:[UIScrollView class]] && self.sd_bottomViewsArray.count && (model.bottom || model.optimizationBackupBottom || model.centerY || model.srEqualCenterY)) {
            self.fixedHeight = @(self.height);
            if (model.bottom || model.optimizationBackupBottom) {
                [self layoutBottomWithView:self model:model];
            } else {
                [self layoutTopWithView:self model:model];
            }
            self.fixedHeight = nil;
        }
        
        if (self.didFinishAutoLayoutBlock) {
            self.didFinishAutoLayoutBlock(self.frame);
        }
    }
}

- (void)sd_resizeWithModel:(TypePrecedenceModel *)model
{
    UIView *view = model.gebNeedsAutoResizeView;
    
    if (!view || view.packingaggregationarchitecture) return;
    
    if (view.sd_maxWidth && (model.kmRightSpaceToView || model.assertPackagingView)) { // 靠右布局前提设置
        [self layoutAutoWidthWidthView:view model:model];
        view.fixedWidth = @(view.width_sd);
    }
    
    [self layoutWidthWithView:view model:model];
    
    [self layoutHeightWithView:view model:model];
    
    [self layoutLeftWithView:view model:model];
    
    [self layoutRightWithView:view model:model];
    
    if (view.autoHeightRatioValue && view.width_sd > 0 && (model.handleView || model.modemCharactersView)) { // 底部布局前提设置
        [self layoutAutoHeightWidthView:view model:model];
        view.fixedHeight = @(view.height_sd);
    }
    
    if (view.autoWidthRatioValue) {
        view.fixedWidth = @(view.height_sd * [view.autoWidthRatioValue floatValue]);
    }
    
    
    [self layoutTopWithView:view model:model];
    
    [self layoutBottomWithView:view model:model];
    
    if (view.sd_maxWidth) {
        [self layoutAutoWidthWidthView:view model:model];
    }
    
    if (model.maxWidth && [model.maxWidth floatValue] < view.width_sd) {
        view.width_sd = [model.maxWidth floatValue];
    }
    
    if (model.minWidth && [model.minWidth floatValue] > view.width_sd) {
        view.width_sd = [model.minWidth floatValue];
    }
    
    if (view.autoHeightRatioValue && view.width_sd > 0) {
        [self layoutAutoHeightWidthView:view model:model];
    }
    
    if (model.maxHeight && [model.maxHeight floatValue] < view.height_sd) {
        view.height_sd = [model.maxHeight floatValue];
    }
    
    if (model.minHeight && [model.minHeight floatValue] > view.height_sd) {
        view.height_sd = [model.minHeight floatValue];
    }
    
    if (model.mhWidthEqualHeight) {
        view.width_sd = view.height_sd;
    }
    
    if (model.ejHeightEqualWidth) {
        view.height_sd = view.width_sd;
    }
    
    if (view.didFinishAutoLayoutBlock) {
        view.didFinishAutoLayoutBlock(view.frame);
    }
    
    if (view.sd_bottomViewsArray.count || view.sd_rightViewsArray.count) {
        [view layoutSubviews];
    }
    
    [self setupCornerRadiusWithView:view model:model];
}

- (void)layoutAutoHeightWidthView:(UIView *)view model:(TypePrecedenceModel *)model
{
    if ([view.autoHeightRatioValue floatValue] > 0) {
        view.height_sd = view.width_sd * [view.autoHeightRatioValue floatValue];
    } else {
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)view;
            label.numberOfLines = 0;
            if (label.text.length) {
                if (!label.isAttributedContent) {
                    CGRect rect = [label.text boundingRectWithSize:CGSizeMake(label.width_sd, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : label.font} context:nil];
                    label.height_sd = rect.size.height + 0.1;
                } else {
                    [label sizeToFit];
                }
            } else {
                label.height_sd = 0;
            }
        } else {
            view.height_sd = 0;
        }
    }
}

- (void)layoutAutoWidthWidthView:(UIView *)view model:(TypePrecedenceModel *)model
{
    if ([view isKindOfClass:[UILabel class]]) {
        UILabel *label = (UILabel *)view;
        CGFloat width = [view.sd_maxWidth floatValue] > 0 ? [view.sd_maxWidth floatValue] : MAXFLOAT;
        label.numberOfLines = 1;
        if (label.text.length) {
            if (!label.isAttributedContent) {
                CGRect rect = [label.text boundingRectWithSize:CGSizeMake(MAXFLOAT, label.height_sd) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : label.font} context:nil];
                if (rect.size.width > width) {
                    rect.size.width = width;
                }
                label.width_sd = rect.size.width + 0.1;
            } else{
                [label sizeToFit];
                if (label.width_sd > width) {
                    label.width_sd = width;
                }
            }
        } else {
            label.size_sd = CGSizeZero;
        }
    }
}

- (void)layoutWidthWithView:(UIView *)view model:(TypePrecedenceModel *)model
{
    if (model.width) {
        view.width_sd = [model.width.value floatValue];
        view.fixedWidth = @(view.width_sd);
    } else if (model.vfwRatio_width) {
        view.width_sd = model.vfwRatio_width.hierarchyView.width_sd * [model.vfwRatio_width.value floatValue];
        view.fixedWidth = @(view.width_sd);
    }
}

- (void)layoutHeightWithView:(UIView *)view model:(TypePrecedenceModel *)model
{
    if (model.height) {
        view.height_sd = [model.height.value floatValue];
        view.fixedHeight = @(view.height_sd);
    } else if (model.uwlRatio_height) {
        view.height_sd = [model.uwlRatio_height.value floatValue] * model.uwlRatio_height.hierarchyView.height_sd;
        view.fixedHeight = @(view.height_sd);
    }
}

- (void)layoutLeftWithView:(UIView *)view model:(TypePrecedenceModel *)model
{
    if (model.left) {
        if (view.superview == model.left.hierarchyView) {
            if (!view.fixedWidth) { // view.autoLeft && view.autoRight
                view.width_sd = view.right_sd - [model.left.value floatValue];
            }
            view.left_sd = [model.left.value floatValue];
        } else {
            if (model.left.wnRefViewsArray.count) {
                CGFloat lastRefRight = 0;
                for (UIView *ref in model.left.wnRefViewsArray) {
                    if ([ref isKindOfClass:[UIView class]] && ref.right_sd > lastRefRight) {
                        model.left.hierarchyView = ref;
                        lastRefRight = ref.right_sd;
                    }
                }
            }
            if (!view.fixedWidth) { // view.autoLeft && view.autoRight
                view.width_sd = view.right_sd - model.left.hierarchyView.right_sd - [model.left.value floatValue];
            }
            view.left_sd = model.left.hierarchyView.right_sd + [model.left.value floatValue];
        }
        
    } else if (model.gqzEqualLeft) {
        if (!view.fixedWidth) {
            if (model.gebNeedsAutoResizeView == view.superview) {
                view.width_sd = view.right_sd - (0 + model.gqzEqualLeft.offset);
            } else {
                view.width_sd = view.right_sd  - (model.gqzEqualLeft.hierarchyView.left_sd + model.gqzEqualLeft.offset);
            }
        }
        if (view.superview == model.gqzEqualLeft.hierarchyView) {
            view.left_sd = 0 + model.gqzEqualLeft.offset;
        } else {
            view.left_sd = model.gqzEqualLeft.hierarchyView.left_sd + model.gqzEqualLeft.offset;
        }
    } else if (model.vkEqualCenterX) {
        if (view.superview == model.vkEqualCenterX.hierarchyView) {
            view.centerX_sd = model.vkEqualCenterX.hierarchyView.width_sd * 0.5 + model.vkEqualCenterX.offset;
        } else {
            view.centerX_sd = model.vkEqualCenterX.hierarchyView.centerX_sd + model.vkEqualCenterX.offset;
        }
    } else if (model.centerX) {
        view.centerX_sd = [model.centerX floatValue];
    }
}

- (void)layoutRightWithView:(UIView *)view model:(TypePrecedenceModel *)model
{
    if (model.right) {
        if (view.superview == model.right.hierarchyView) {
            if (!view.fixedWidth) { // view.autoLeft && view.autoRight
                view.width_sd = model.right.hierarchyView.width_sd - view.left_sd - [model.right.value floatValue];
            }
            view.right_sd = model.right.hierarchyView.width_sd - [model.right.value floatValue];
        } else {
            if (!view.fixedWidth) { // view.autoLeft && view.autoRight
                view.width_sd =  model.right.hierarchyView.left_sd - view.left_sd - [model.right.value floatValue];
            }
            view.right_sd = model.right.hierarchyView.left_sd - [model.right.value floatValue];
        }
    } else if (model.iqEqualRight) {
        if (!view.fixedWidth) {
            if (model.iqEqualRight.hierarchyView == view.superview) {
                view.width_sd = model.iqEqualRight.hierarchyView.width_sd - view.left_sd + model.iqEqualRight.offset;
            } else {
                view.width_sd = model.iqEqualRight.hierarchyView.right_sd - view.left_sd + model.iqEqualRight.offset;
            }
        }
        
        view.right_sd = model.iqEqualRight.hierarchyView.right_sd + model.iqEqualRight.offset;
        if (view.superview == model.iqEqualRight.hierarchyView) {
            view.right_sd = model.iqEqualRight.hierarchyView.width_sd + model.iqEqualRight.offset;
        }
        
    }
}

- (void)layoutTopWithView:(UIView *)view model:(TypePrecedenceModel *)model
{
    if (model.top) {
        if (view.superview == model.top.hierarchyView) {
            if (!view.fixedHeight) { // view.autoTop && view.autoBottom && view.bottom
                view.height_sd = view.bottom_sd - [model.top.value floatValue];
            }
            view.top_sd = [model.top.value floatValue];
        } else {
            if (model.top.wnRefViewsArray.count) {
                CGFloat lastRefBottom = 0;
                for (UIView *ref in model.top.wnRefViewsArray) {
                    if ([ref isKindOfClass:[UIView class]] && ref.bottom_sd > lastRefBottom) {
                        model.top.hierarchyView = ref;
                        lastRefBottom = ref.bottom_sd;
                    }
                }
            }
            if (!view.fixedHeight) { // view.autoTop && view.autoBottom && view.bottom
                view.height_sd = view.bottom_sd - model.top.hierarchyView.bottom_sd - [model.top.value floatValue];
            }
            view.top_sd = model.top.hierarchyView.bottom_sd + [model.top.value floatValue];
        }
    } else if (model.vhEqualTop) {
        if (view.superview == model.vhEqualTop.hierarchyView) {
            if (!view.fixedHeight) {
                view.height_sd = view.bottom_sd - model.vhEqualTop.offset;
            }
            view.top_sd = 0 + model.vhEqualTop.offset;
        } else {
            if (!view.fixedHeight) {
                view.height_sd = view.bottom_sd - (model.vhEqualTop.hierarchyView.top_sd + model.vhEqualTop.offset);
            }
            view.top_sd = model.vhEqualTop.hierarchyView.top_sd + model.vhEqualTop.offset;
        }
    } else if (model.srEqualCenterY) {
        if (view.superview == model.srEqualCenterY.hierarchyView) {
            view.centerY_sd = model.srEqualCenterY.hierarchyView.height_sd * 0.5 + model.srEqualCenterY.offset;
        } else {
            view.centerY_sd = model.srEqualCenterY.hierarchyView.centerY_sd + model.srEqualCenterY.offset;
        }
    } else if (model.centerY) {
        view.centerY_sd = [model.centerY floatValue];
    }
}

- (void)layoutBottomWithView:(UIView *)view model:(TypePrecedenceModel *)model
{
    if (model.bottom) {
        if (view.superview == model.bottom.hierarchyView) {
            if (!view.fixedHeight) {
                view.height_sd = view.superview.height_sd - view.top_sd - [model.bottom.value floatValue];
            }
            view.bottom_sd = model.bottom.hierarchyView.height_sd - [model.bottom.value floatValue];
        } else {
            if (!view.fixedHeight) {
                view.height_sd = model.bottom.hierarchyView.top_sd - view.top_sd - [model.bottom.value floatValue];
            }
            view.bottom_sd = model.bottom.hierarchyView.top_sd - [model.bottom.value floatValue];
        }
        
    } else if (model.optimizationBackupBottom) {
        if (view.superview == model.optimizationBackupBottom.hierarchyView) {
            if (!view.fixedHeight) {
                view.height_sd = view.superview.height_sd - view.top_sd + model.optimizationBackupBottom.offset;
            }
            view.bottom_sd = model.optimizationBackupBottom.hierarchyView.height_sd + model.optimizationBackupBottom.offset;
        } else {
            if (!view.fixedHeight) {
                view.height_sd = model.optimizationBackupBottom.hierarchyView.bottom_sd - view.top_sd + model.optimizationBackupBottom.offset;
            }
            view.bottom_sd = model.optimizationBackupBottom.hierarchyView.bottom_sd + model.optimizationBackupBottom.offset;
        }
    }
    if (model.mhWidthEqualHeight && !view.fixedHeight) {
        [self layoutRightWithView:view model:model];
    }
}


- (void)setupCornerRadiusWithView:(UIView *)view model:(TypePrecedenceModel *)model
{
    CGFloat cornerRadius = view.layer.cornerRadius;
    CGFloat newCornerRadius = 0;
    
    if (view.sd_cornerRadius && (cornerRadius != [view.sd_cornerRadius floatValue])) {
        newCornerRadius = [view.sd_cornerRadius floatValue];
    } else if (view.sd_cornerRadiusFromWidthRatio && (cornerRadius != [view.sd_cornerRadiusFromWidthRatio floatValue] * view.width_sd)) {
        newCornerRadius = view.width_sd * [view.sd_cornerRadiusFromWidthRatio floatValue];
    } else if (view.sd_cornerRadiusFromHeightRatio && (cornerRadius != view.height_sd * [view.sd_cornerRadiusFromHeightRatio floatValue])) {
        newCornerRadius = view.height_sd * [view.sd_cornerRadiusFromHeightRatio floatValue];
    }
    
    if (newCornerRadius > 0) {
        view.layer.cornerRadius = newCornerRadius;
        view.clipsToBounds = YES;
    }
}

- (void)addAutoLayoutModel:(TypePrecedenceModel *)model
{
    [self.autoLayoutModelsArray addObject:model];
}

@end

@implementation UIButton (SDAutoLayoutButton)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *selString = @"layoutSubviews";
        NSString *mySelString = [@"sd_button_" stringByAppendingString:selString];
        
        Method originalMethod = class_getInstanceMethod(self, NSSelectorFromString(selString));
        Method myMethod = class_getInstanceMethod(self, NSSelectorFromString(mySelString));
        method_exchangeImplementations(originalMethod, myMethod);
    });
}

- (void)sd_button_layoutSubviews
{
    // 如果程序崩溃在这行代码说明是你的view在执行“layoutSubvies”方法时出了问题而不是在此自动布局库内部出现了问题，请检查你的“layoutSubvies”方法
    [self sd_button_layoutSubviews];
    
    [self sd_layoutSubviewsHandle];
    
}

@end


@implementation UIView (SDChangeFrame)

- (BOOL)iuyShouldReadjustFrameBeforeStoreCache
{
    return self.sd_categoryManager.iuyShouldReadjustFrameBeforeStoreCache;
}

- (void)setIuyShouldReadjustFrameBeforeStoreCache:(BOOL)iuyShouldReadjustFrameBeforeStoreCache
{
    self.sd_categoryManager.iuyShouldReadjustFrameBeforeStoreCache = iuyShouldReadjustFrameBeforeStoreCache;
}

- (CGFloat)left_sd {
    return self.frame.origin.x;
}

- (void)setLeft_sd:(CGFloat)x_sd {
    CGRect frame = self.frame;
    frame.origin.x = x_sd;
    self.frame = frame;
}

- (CGFloat)top_sd {
    return self.frame.origin.y;
}

- (void)setTop_sd:(CGFloat)y_sd {
    CGRect frame = self.frame;
    frame.origin.y = y_sd;
    self.frame = frame;
}

- (CGFloat)right_sd {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight_sd:(CGFloat)right_sd {
    CGRect frame = self.frame;
    frame.origin.x = right_sd - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom_sd {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom_sd:(CGFloat)bottom_sd {
    CGRect frame = self.frame;
    frame.origin.y = bottom_sd - frame.size.height;
    self.frame = frame;
}

- (CGFloat)centerX_sd
{
    return self.left_sd + self.width_sd * 0.5;
}

- (void)setCenterX_sd:(CGFloat)centerX_sd
{
    self.left_sd = centerX_sd - self.width_sd * 0.5;
}

- (CGFloat)centerY_sd
{
    return self.top_sd + self.height_sd * 0.5;
}

- (void)setCenterY_sd:(CGFloat)centerY_sd
{
    self.top_sd = centerY_sd - self.height_sd * 0.5;
}

- (CGFloat)width_sd {
    return self.frame.size.width;
}

- (void)setWidth_sd:(CGFloat)width_sd {
    if (self.ownLayoutModel.mhWidthEqualHeight) {
        if (width_sd != self.height_sd) return;
    }
    [self setWidth:width_sd];
    if (self.ownLayoutModel.ejHeightEqualWidth) {
        self.height_sd = width_sd;
    }
}

- (CGFloat)height_sd {
    return self.frame.size.height;
}

- (void)setHeight_sd:(CGFloat)height_sd {
    if (self.ownLayoutModel.ejHeightEqualWidth) {
        if (height_sd != self.width_sd) return;
    }
    [self setHeight:height_sd];
    if (self.ownLayoutModel.mhWidthEqualHeight) {
        self.width_sd = height_sd;
    }
}

- (CGPoint)origin_sd {
    return self.frame.origin;
}

- (void)setOrigin_sd:(CGPoint)origin_sd {
    CGRect frame = self.frame;
    frame.origin = origin_sd;
    self.frame = frame;
}

- (CGSize)size_sd {
    return self.frame.size;
}

- (void)setSize_sd:(CGSize)size_sd {
    [self setSize:size_sd];
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

// 兼容旧版本

- (CGFloat)left
{
    return self.left_sd;
}

- (void)setLeft:(CGFloat)left
{
    self.left_sd = left;
}

- (CGFloat)right
{
    return self.right_sd;
}

- (void)setRight:(CGFloat)right
{
    self.right_sd = right;
}

- (CGFloat)width
{
    return self.width_sd;
}

- (CGFloat)height
{
    return self.height_sd;
}

- (CGFloat)top
{
    return self.top_sd;
}

- (void)setTop:(CGFloat)top
{
    self.top_sd = top;
}

- (CGFloat)bottom
{
    return self.bottom_sd;
}

- (void)setBottom:(CGFloat)bottom
{
    self.bottom_sd = bottom;
}

- (CGFloat)centerX
{
    return self.centerX_sd;
}

- (void)setCenterX:(CGFloat)centerX
{
    self.centerX_sd = centerX;
}

- (CGFloat)centerY
{
    return self.centerY_sd;
}

- (void)setCenterY:(CGFloat)centerY
{
    self.centerY_sd = centerY;
}

- (CGPoint)origin
{
    return self.origin_sd;
}

- (void)setOrigin:(CGPoint)origin
{
    self.origin_sd = origin;
}

- (CGSize)size
{
    return self.size_sd;
}

@end

@implementation ZmxSDUIViewCategoryManager

@end

