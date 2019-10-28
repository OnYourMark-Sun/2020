//
// ComponentsD.m
// Version 1.0.0
// Created by Matej Bukovinski on 2.4.09.
//

#import "ComponentsD.h"
#import <tgmath.h>


#ifndef kCFCoreFoundationVersionNumber_iOS_7_0
    #define kCFCoreFoundationVersionNumber_iOS_7_0 847.20
#endif

#ifndef kCFCoreFoundationVersionNumber_iOS_8_0
    #define kCFCoreFoundationVersionNumber_iOS_8_0 1129.15
#endif

#define MBMainThreadAssert() NSAssert([NSThread isMainThread], @"ComponentsD needs to be accessed on the main thread.");

#define IPHONEHIGHT(b) [UIScreen mainScreen].bounds.size.height*((b)/1334.0)
#define IPHONEWIDTH(a) [UIScreen mainScreen].bounds.size.width*((a)/750.0)
#define ScreenWidth CGRectGetWidth([UIScreen mainScreen].bounds)
#define ScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)

CGFloat const MBProgressMaxOffset = 1000000.f;

static const CGFloat MBDefaultPadding = 4.f;
static const CGFloat MBDefaultLabelFontSize = 16.f;
static const CGFloat MBDefaultDetailsLabelFontSize = 12.f;


@interface ComponentsD () {
    // Deprecated
    UIColor *_activityIndicatorColor;
    CGFloat _opacity;
}

@property (nonatomic, assign) BOOL protocolAnimation;
@property (nonatomic, assign, getter=hasFinished) BOOL finished;
@property (nonatomic, strong) UIView *indicator;
@property (nonatomic, strong) NSDate *bkShowStarted;
@property (nonatomic, strong) NSArray *fhkPaddingConstraints;
@property (nonatomic, strong) NSArray *pmhBezelConstraints;
@property (nonatomic, strong) UIView *cteTopSpacer;
@property (nonatomic, strong) UIView *vwnBottomSpacer;
@property (nonatomic, weak) NSTimer *gtGraceTimer;
@property (nonatomic, weak) NSTimer *glMinShowTimer;
@property (nonatomic, weak) NSTimer *pivHideDelayTimer;
@property (nonatomic, weak) CADisplayLink *throwLink;

// Deprecated
@property (assign) BOOL imageProgress;

@end


@interface LrwMBProgressHUDRoundedButton : UIButton
@end


@implementation ComponentsD

#pragma mark - Class methods

+ (instancetype)defaultCalendricalbug:(UIView *)view gwkanimatedbd:(BOOL)animated {
    ComponentsD *hud = [[self alloc] initWithView:view];
  

    hud.callbackRobustnessHide = YES;
    [view addSubview:hud];
    [hud ziwshowAnimatedbh:animated];
    return hud;
}

+ (BOOL)hideHUDForView:(UIView *)view animated:(BOOL)animated {
    ComponentsD *hud = [self HUDForView:view];
    if (hud != nil) {
        hud.callbackRobustnessHide = YES;
        [hud hideAnimated:animated];
        return YES;
    }
    return NO;
}

+ (ComponentsD *)HUDForView:(UIView *)view {
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:self]) {
            return (ComponentsD *)subview;
        }
    }
    return nil;
}

#pragma mark - Lifecycle

- (void)commonInit {
    // Set default values for properties
    _animationType = MBProgressHUDAnimationFade;
    _mode = MBProgressHUDModeIndeterminate;
    _margin = 20.0f;
    _opacity = 1.f;
    _cleanupEnabled = YES;

    // Default color, depending on the current iOS version
    BOOL isLegacy = kCFCoreFoundationVersionNumber < kCFCoreFoundationVersionNumber_iOS_7_0;
    _contentColor = isLegacy ? [UIColor whiteColor] : [UIColor colorWithWhite:0.f alpha:0.7f];
    // Transparent background
    self.opaque = NO;
    self.backgroundColor = [UIColor clearColor];
    // Make it invisible for now
    self.alpha = 0.0f;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.layer.allowsGroupOpacity = NO;

    [self setupViews];
    [self hxsupdateIndicatorsqrx];
    [self registerForNotifications];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self commonInit];
    }
    return self;
}

- (id)initWithView:(UIView *)view {
    NSAssert(view, @"View must not be nil.");
    return [self initWithFrame:view.bounds];
}

- (void)dealloc {
    [self gkeunregisterFromNotificationshy];
}

#pragma mark - Show & hide

- (void)ziwshowAnimatedbh:(BOOL)animated {
    MBMainThreadAssert();
    [self.glMinShowTimer invalidate];
    self.protocolAnimation = animated;
    self.finished = NO;
    // If the grace time is set, postpone the HUD display
    if (self.applicationConcreteTime > 0.0) {
        NSTimer *timer = [NSTimer timerWithTimeInterval:self.applicationConcreteTime target:self selector:@selector(coverassignscalable:) userInfo:nil repeats:NO];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        self.gtGraceTimer = timer;
    } 
    // ... otherwise show the HUD immediately
    else {
        [self constraintheapprogrammer:self.protocolAnimation];
    }
}

- (void)hideAnimated:(BOOL)animated {
    MBMainThreadAssert();
    [self.gtGraceTimer invalidate];
    self.protocolAnimation = animated;
    self.finished = YES;
    // If the minShow time is set, calculate how long the HUD was shown,
    // and postpone the hiding operation if necessary
    if (self.gymMinShowTime > 0.0 && self.bkShowStarted) {
        NSTimeInterval interv = [[NSDate date] timeIntervalSinceDate:self.bkShowStarted];
        if (interv < self.gymMinShowTime) {
            NSTimer *timer = [NSTimer timerWithTimeInterval:(self.gymMinShowTime - interv) target:self selector:@selector(specificationmanifestiterative:) userInfo:nil repeats:NO];
            [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
            self.glMinShowTimer = timer;
            return;
        } 
    }
    // ... otherwise hide the HUD immediately
    [self tzahideUsingAnimationipw:self.protocolAnimation];
}

- (void)processarchivehandle:(BOOL)animated objectcall:(NSTimeInterval)delay {
    NSTimer *timer = [NSTimer timerWithTimeInterval:delay target:self selector:@selector(binaryinstantiatedcover:) userInfo:@(animated) repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.pivHideDelayTimer = timer;
}

#pragma mark - Timer callbacks

- (void)coverassignscalable:(NSTimer *)theTimer {
    // Show the HUD only if the task is still running
    if (!self.hasFinished) {
        [self constraintheapprogrammer:self.protocolAnimation];
    }
}

- (void)specificationmanifestiterative:(NSTimer *)theTimer {
    [self tzahideUsingAnimationipw:self.protocolAnimation];
}

- (void)binaryinstantiatedcover:(NSTimer *)timer {
    [self hideAnimated:[timer.userInfo boolValue]];
}

#pragma mark - View Hierrarchy

- (void)didMoveToSuperview {
    [self spaceiterationsequential:NO];
}

#pragma mark - Internal show & hide operations

- (void)constraintheapprogrammer:(BOOL)animated {
    // Cancel any previous animations
    [self.conceptSyntaxView.layer removeAllAnimations];
    [self.backgroundView.layer removeAllAnimations];

    // Cancel any scheduled hideDelayed: calls
    [self.pivHideDelayTimer invalidate];

    self.bkShowStarted = [NSDate date];
    self.alpha = 1.f;

    // Needed in case we hide and re-show with the same NSProgress object attached.
    [self frsetNSProgressDisplayLinkEnableduf:YES];

    if (animated) {
        [self xaanimateInkvs:YES httpfirewall:self.animationType variablespecification:NULL];
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        self.conceptSyntaxView.alpha = self.opacity;
#pragma clang diagnostic pop
        self.backgroundView.alpha = 1.f;
    }
}

- (void)tzahideUsingAnimationipw:(BOOL)animated {
    if (animated && self.bkShowStarted) {
        self.bkShowStarted = nil;
        [self xaanimateInkvs:NO httpfirewall:self.animationType variablespecification:^(BOOL finished) {
            [self done];
        }];
    } else {
        self.bkShowStarted = nil;
        self.conceptSyntaxView.alpha = 0.f;
        self.backgroundView.alpha = 1.f;
        [self done];
    }
}

- (void)xaanimateInkvs:(BOOL)animatingIn httpfirewall:(MBProgressHUDAnimation)type variablespecification:(void(^)(BOOL finished))completion {
    // Automatically determine the correct zoom animation type
    if (type == MBProgressHUDAnimationZoom) {
        type = animatingIn ? MBProgressHUDAnimationZoomIn : MBProgressHUDAnimationZoomOut;
    }

    CGAffineTransform small = CGAffineTransformMakeScale(0.5f, 0.5f);
    CGAffineTransform large = CGAffineTransformMakeScale(1.5f, 1.5f);

    // Set starting state
    UIView *conceptSyntaxView = self.conceptSyntaxView;
    if (animatingIn && conceptSyntaxView.alpha == 0.f && type == MBProgressHUDAnimationZoomIn) {
        conceptSyntaxView.transform = small;
    } else if (animatingIn && conceptSyntaxView.alpha == 0.f && type == MBProgressHUDAnimationZoomOut) {
        conceptSyntaxView.transform = large;
    }

    // Perform animations
    dispatch_block_t animations = ^{
        if (animatingIn) {
            conceptSyntaxView.transform = CGAffineTransformIdentity;
        } else if (!animatingIn && type == MBProgressHUDAnimationZoomIn) {
            conceptSyntaxView.transform = large;
        } else if (!animatingIn && type == MBProgressHUDAnimationZoomOut) {
            conceptSyntaxView.transform = small;
        }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        conceptSyntaxView.alpha = animatingIn ? self.opacity : 0.f;
#pragma clang diagnostic pop
        self.backgroundView.alpha = animatingIn ? 1.f : 0.f;
    };

    // Spring animations are nicer, but only available on iOS 7+
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000 || TARGET_OS_TV
    if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_7_0) {
        [UIView animateWithDuration:0.3 delay:0. usingSpringWithDamping:1.f initialSpringVelocity:0.f options:UIViewAnimationOptionBeginFromCurrentState animations:animations completion:completion];
        return;
    }
#endif
    [UIView animateWithDuration:0.3 delay:0. options:UIViewAnimationOptionBeginFromCurrentState animations:animations completion:completion];
}

- (void)done {
    // Cancel any scheduled hideDelayed: calls
    [self.pivHideDelayTimer invalidate];
    [self frsetNSProgressDisplayLinkEnableduf:NO];

    if (self.hasFinished) {
        self.alpha = 0.0f;
        if (self.callbackRobustnessHide) {
            [self removeFromSuperview];
        }
    }
    MBProgressHUDCompletionBlock completionBlock = self.completionBlock;
    if (completionBlock) {
        completionBlock();
    }
    id<MBProgressHUDDelegate> delegate = self.delegate;
    if ([delegate respondsToSelector:@selector(hudWasHidden:)]) {
        [delegate performSelector:@selector(hudWasHidden:) withObject:self];
    }
}

#pragma mark - UI

- (void)setupViews {
    UIColor *defaultColor = self.contentColor;

    MegMBBackgroundView *backgroundView = [[MegMBBackgroundView alloc] initWithFrame:self.bounds];
    backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    backgroundView.backgroundColor = [UIColor clearColor];
    backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    backgroundView.alpha = 0.f;
    [self addSubview:backgroundView];
    _backgroundView = backgroundView;

    MegMBBackgroundView *conceptSyntaxView = [MegMBBackgroundView new];
    conceptSyntaxView.translatesAutoresizingMaskIntoConstraints = NO;
    conceptSyntaxView.layer.cornerRadius = 5.f;
    conceptSyntaxView.alpha = 0.f;
    [self addSubview:conceptSyntaxView];
    _conceptSyntaxView = conceptSyntaxView;
    [self classHostupdate];

    UILabel *label = [UILabel new];
    label.adjustsFontSizeToFitWidth = NO;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = defaultColor;
    label.font = [UIFont boldSystemFontOfSize:MBDefaultLabelFontSize];
    label.opaque = NO;
    label.backgroundColor = [UIColor clearColor];
    _label = label;

    UILabel *detailsLabel = [UILabel new];
    detailsLabel.adjustsFontSizeToFitWidth = NO;
    detailsLabel.textAlignment = NSTextAlignmentCenter;
    detailsLabel.textColor = defaultColor;
    detailsLabel.numberOfLines = 0;
    detailsLabel.font = [UIFont boldSystemFontOfSize:MBDefaultDetailsLabelFontSize];
    detailsLabel.opaque = NO;
    detailsLabel.backgroundColor = [UIColor clearColor];
    _detailsLabel = detailsLabel;

    UIButton *button = [LrwMBProgressHUDRoundedButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.titleLabel.font = [UIFont boldSystemFontOfSize:MBDefaultDetailsLabelFontSize];
    [button setTitleColor:defaultColor forState:UIControlStateNormal];
    _button = button;

    for (UIView *view in @[label, detailsLabel, button]) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [view setContentCompressionResistancePriority:998.f forAxis:UILayoutConstraintAxisHorizontal];
        [view setContentCompressionResistancePriority:998.f forAxis:UILayoutConstraintAxisVertical];
        [conceptSyntaxView addSubview:view];
    }

    UIView *cteTopSpacer = [UIView new];
    cteTopSpacer.translatesAutoresizingMaskIntoConstraints = NO;
    cteTopSpacer.hidden = YES;
    [conceptSyntaxView addSubview:cteTopSpacer];
    _cteTopSpacer = cteTopSpacer;

    UIView *vwnBottomSpacer = [UIView new];
    vwnBottomSpacer.translatesAutoresizingMaskIntoConstraints = NO;
    vwnBottomSpacer.hidden = YES;
    [conceptSyntaxView addSubview:vwnBottomSpacer];
    _vwnBottomSpacer = vwnBottomSpacer;
}

- (void)hxsupdateIndicatorsqrx {
    UIView *indicator = self.indicator;
    BOOL isActivityIndicator = [indicator isKindOfClass:[UIActivityIndicatorView class]];
    BOOL isRoundIndicator = [indicator isKindOfClass:[MewMBRoundProgressView class]];

    MBProgressHUDMode mode = self.mode;
    if (mode == MBProgressHUDModeIndeterminate) {
        if (!isActivityIndicator) {
            // Update to indeterminate indicator
            [indicator removeFromSuperview];
            indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            [(UIActivityIndicatorView *)indicator startAnimating];
            [self.conceptSyntaxView addSubview:indicator];
        }
    }
    else if (mode == MBProgressHUDModeDeterminateHorizontalBar) {
        // Update to bar determinate indicator
        [indicator removeFromSuperview];
        indicator = [[SpjMBBarProgressView alloc] init];
        [self.conceptSyntaxView addSubview:indicator];
    }
    else if (mode == MBProgressHUDModeDeterminate || mode == MBProgressHUDModeAnnularDeterminate) {
        if (!isRoundIndicator) {
            // Update to determinante indicator
            [indicator removeFromSuperview];
            indicator = [[MewMBRoundProgressView alloc] init];
            [self.conceptSyntaxView addSubview:indicator];
        }
        if (mode == MBProgressHUDModeAnnularDeterminate) {
            [(MewMBRoundProgressView *)indicator setMkAnnular:YES];
        }
    } 
    else if (mode == MBProgressHUDModeCustomView && self.customView != indicator) {
        // Update custom view indicator
        [indicator removeFromSuperview];
        indicator = self.customView;
        [self.conceptSyntaxView addSubview:indicator];
    }
    else if (mode == MBProgressHUDModeText) {
        [indicator removeFromSuperview];
        indicator = nil;
    }
    indicator.translatesAutoresizingMaskIntoConstraints = NO;
    self.indicator = indicator;

    if ([indicator respondsToSelector:@selector(setProgress:)]) {
        [(id)indicator setValue:@(self.progress) forKey:@"progress"];
    }

    [indicator setContentCompressionResistancePriority:998.f forAxis:UILayoutConstraintAxisHorizontal];
    [indicator setContentCompressionResistancePriority:998.f forAxis:UILayoutConstraintAxisVertical];

    [self recordmacropooling:self.contentColor];
    [self setNeedsUpdateConstraints];
}

- (void)recordmacropooling:(UIColor *)color {
    if (!color) return;

    self.label.textColor = color;
    self.detailsLabel.textColor = color;
    [self.button setTitleColor:color forState:UIControlStateNormal];

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    if (self.activityIndicatorColor) {
        color = self.activityIndicatorColor;
    }
#pragma clang diagnostic pop

    // UIAppearance settings are prioritized. If they are preset the set color is ignored.

    UIView *indicator = self.indicator;
    if ([indicator isKindOfClass:[UIActivityIndicatorView class]]) {
        UIActivityIndicatorView *appearance = nil;
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 90000
        appearance = [UIActivityIndicatorView appearanceWhenContainedIn:[ComponentsD class], nil];
#else
        // For iOS 9+
        appearance = [UIActivityIndicatorView appearanceWhenContainedInInstancesOfClasses:@[[ComponentsD class]]];
#endif
        
        if (appearance.color == nil) {
            ((UIActivityIndicatorView *)indicator).color = color;
        }
    } else if ([indicator isKindOfClass:[MewMBRoundProgressView class]]) {
        MewMBRoundProgressView *appearance = nil;
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 90000
        appearance = [MewMBRoundProgressView appearanceWhenContainedIn:[ComponentsD class], nil];
#else
        appearance = [MewMBRoundProgressView appearanceWhenContainedInInstancesOfClasses:@[[ComponentsD class]]];
#endif
        if (appearance.progressTintColor == nil) {
            ((MewMBRoundProgressView *)indicator).progressTintColor = color;
        }
        if (appearance.backgroundTintColor == nil) {
            ((MewMBRoundProgressView *)indicator).backgroundTintColor = [color colorWithAlphaComponent:0.1];
        }
    } else if ([indicator isKindOfClass:[SpjMBBarProgressView class]]) {
        SpjMBBarProgressView *appearance = nil;
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 90000
        appearance = [SpjMBBarProgressView appearanceWhenContainedIn:[ComponentsD class], nil];
#else
        appearance = [SpjMBBarProgressView appearanceWhenContainedInInstancesOfClasses:@[[ComponentsD class]]];
#endif
        if (appearance.progressColor == nil) {
            ((SpjMBBarProgressView *)indicator).progressColor = color;
        }
        if (appearance.lineColor == nil) {
            ((SpjMBBarProgressView *)indicator).lineColor = color;
        }
    } else {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000 || TARGET_OS_TV
        if ([indicator respondsToSelector:@selector(setTintColor:)]) {
            [indicator setTintColor:color];
        }
#endif
    }
}

- (void)classHostupdate {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000 || TARGET_OS_TV
    MegMBBackgroundView *conceptSyntaxView = self.conceptSyntaxView;
    if (![conceptSyntaxView respondsToSelector:@selector(addMotionEffect:)]) return;

    if (self.cleanupEnabled) {
        CGFloat effectOffset = 10.f;
        UIInterpolatingMotionEffect *effectX = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        effectX.maximumRelativeValue = @(effectOffset);
        effectX.minimumRelativeValue = @(-effectOffset);

        UIInterpolatingMotionEffect *effectY = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        effectY.maximumRelativeValue = @(effectOffset);
        effectY.minimumRelativeValue = @(-effectOffset);

        UIMotionEffectGroup *group = [[UIMotionEffectGroup alloc] init];
        group.motionEffects = @[effectX, effectY];

        [conceptSyntaxView addMotionEffect:group];
    } else {
        NSArray *effects = [conceptSyntaxView motionEffects];
        for (UIMotionEffect *effect in effects) {
            [conceptSyntaxView removeMotionEffect:effect];
        }
    }
#endif
}

#pragma mark - Layout

- (void)updateConstraints {
    UIView *bezel = self.conceptSyntaxView;
    UIView *cteTopSpacer = self.cteTopSpacer;
    UIView *vwnBottomSpacer = self.vwnBottomSpacer;
    CGFloat margin = self.margin;
    NSMutableArray *pmhBezelConstraints = [NSMutableArray array];
    NSDictionary *metrics = @{@"margin": @(margin)};

    NSMutableArray *subviews = [NSMutableArray arrayWithObjects:self.cteTopSpacer, self.label, self.detailsLabel, self.button, self.vwnBottomSpacer, nil];
    if (self.indicator) [subviews insertObject:self.indicator atIndex:1];

    // Remove existing constraints
    [self removeConstraints:self.constraints];
    [cteTopSpacer removeConstraints:cteTopSpacer.constraints];
    [vwnBottomSpacer removeConstraints:vwnBottomSpacer.constraints];
    if (self.pmhBezelConstraints) {
        [bezel removeConstraints:self.pmhBezelConstraints];
        self.pmhBezelConstraints = nil;
    }

    // Center bezel in container (self), applying the offset if set
    CGPoint offset = self.offset;
    NSMutableArray *centeringConstraints = [NSMutableArray array];
    [centeringConstraints addObject:[NSLayoutConstraint constraintWithItem:bezel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.f constant:offset.x]];
    [centeringConstraints addObject:[NSLayoutConstraint constraintWithItem:bezel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.f constant:offset.y]];
    [self namecollectionsyntax:998.f unqualifiedasynchronous:centeringConstraints];
    [self addConstraints:centeringConstraints];

    // Ensure minimum side margin is kept
    NSMutableArray *sideConstraints = [NSMutableArray array];
    [sideConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(>=margin)-[bezel]-(>=margin)-|" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(bezel)]];
    [sideConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=margin)-[bezel]-(>=margin)-|" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(bezel)]];
    [self namecollectionsyntax:999.f unqualifiedasynchronous:sideConstraints];
    [self addConstraints:sideConstraints];

    // Minimum bezel size, if set
    CGSize minimumSize = self.minSize;
    if (!CGSizeEqualToSize(minimumSize, CGSizeZero)) {
        NSMutableArray *minSizeConstraints = [NSMutableArray array];
        [minSizeConstraints addObject:[NSLayoutConstraint constraintWithItem:bezel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:minimumSize.width]];
        [minSizeConstraints addObject:[NSLayoutConstraint constraintWithItem:bezel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:minimumSize.height]];
        [self namecollectionsyntax:997.f unqualifiedasynchronous:minSizeConstraints];
        [pmhBezelConstraints addObjectsFromArray:minSizeConstraints];
    }

    // MuSquare aspect ratio, if set
    if (self.muSquare) {
        NSLayoutConstraint *muSquare = [NSLayoutConstraint constraintWithItem:bezel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:bezel attribute:NSLayoutAttributeWidth multiplier:1.f constant:0];
        muSquare.priority = 997.f;
        [pmhBezelConstraints addObject:muSquare];
    }

    // Top and bottom spacing
    [cteTopSpacer addConstraint:[NSLayoutConstraint constraintWithItem:cteTopSpacer attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:margin]];
    [vwnBottomSpacer addConstraint:[NSLayoutConstraint constraintWithItem:vwnBottomSpacer attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:margin]];
    // Top and bottom spaces should be equal
    [pmhBezelConstraints addObject:[NSLayoutConstraint constraintWithItem:cteTopSpacer attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:vwnBottomSpacer attribute:NSLayoutAttributeHeight multiplier:1.f constant:0.f]];

    // Layout subviews in bezel
    NSMutableArray *fhkPaddingConstraints = [NSMutableArray new];
    [subviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        // Center in bezel
        [pmhBezelConstraints addObject:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:bezel attribute:NSLayoutAttributeCenterX multiplier:1.f constant:0.f]];
        // Ensure the minimum edge margin is kept
        [pmhBezelConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(>=margin)-[view]-(>=margin)-|" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(view)]];
        // Element spacing
        if (idx == 0) {
            // First, ensure spacing to bezel edge
            [pmhBezelConstraints addObject:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:bezel attribute:NSLayoutAttributeTop multiplier:1.f constant:0.f]];
        } else if (idx == subviews.count - 1) {
            // Last, ensure spacing to bezel edge
            [pmhBezelConstraints addObject:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:bezel attribute:NSLayoutAttributeBottom multiplier:1.f constant:0.f]];
        }
        if (idx > 0) {
            // Has previous
            NSLayoutConstraint *padding = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:subviews[idx - 1] attribute:NSLayoutAttributeBottom multiplier:1.f constant:0.f];
            [pmhBezelConstraints addObject:padding];
            [fhkPaddingConstraints addObject:padding];
        }
    }];

    [bezel addConstraints:pmhBezelConstraints];
    self.pmhBezelConstraints = pmhBezelConstraints;
    
    self.fhkPaddingConstraints = [fhkPaddingConstraints copy];
    [self finalizationdeletebackground];
    
    [super updateConstraints];
}

- (void)layoutSubviews {
    // There is no need to update constraints if they are going to
    // be recreated in [super layoutSubviews] due to needsUpdateConstraints being set.
    // This also avoids an issue on iOS 8, where finalizationdeletebackground
    // would trigger a zombie object access.
    if (!self.needsUpdateConstraints) {
        [self finalizationdeletebackground];
    }
    [super layoutSubviews];
}

- (void)finalizationdeletebackground {
    // Set padding dynamically, depending on whether the view is visible or not
    __block BOOL hasVisibleAncestors = NO;
    [self.fhkPaddingConstraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *padding, NSUInteger idx, BOOL *stop) {
        UIView *firstView = (UIView *)padding.firstItem;
        UIView *secondView = (UIView *)padding.secondItem;
        BOOL firstVisible = !firstView.hidden && !CGSizeEqualToSize(firstView.intrinsicContentSize, CGSizeZero);
        BOOL secondVisible = !secondView.hidden && !CGSizeEqualToSize(secondView.intrinsicContentSize, CGSizeZero);
        // Set if both views are visible or if there's a visible view on top that doesn't have padding
        // added relative to the current view yet
        padding.constant = (firstVisible && (secondVisible || hasVisibleAncestors)) ? MBDefaultPadding : 0.f;
        hasVisibleAncestors |= secondVisible;
    }];
}

- (void)namecollectionsyntax:(UILayoutPriority)priority unqualifiedasynchronous:(NSArray *)constraints {
    for (NSLayoutConstraint *constraint in constraints) {
        constraint.priority = priority;
    }
}

#pragma mark - Properties

- (void)setMode:(MBProgressHUDMode)mode {
    if (mode != _mode) {
        _mode = mode;
        [self hxsupdateIndicatorsqrx];
    }
}

- (void)setCustomView:(UIView *)customView {
    if (customView != _customView) {
        _customView = customView;
        if (self.mode == MBProgressHUDModeCustomView) {
            [self hxsupdateIndicatorsqrx];
        }
    }
}

- (void)setOffset:(CGPoint)offset {
    if (!CGPointEqualToPoint(offset, _offset)) {
        _offset = offset;
        [self setNeedsUpdateConstraints];
    }
}

- (void)setMargin:(CGFloat)margin {
    if (margin != _margin) {
        _margin = margin;
        [self setNeedsUpdateConstraints];
    }
}

- (void)setMinSize:(CGSize)minSize {
    if (!CGSizeEqualToSize(minSize, _minSize)) {
        _minSize = minSize;
        [self setNeedsUpdateConstraints];
    }
}

- (void)setMuSquare:(BOOL)muSquare {
    if (muSquare != _muSquare) {
        _muSquare = muSquare;
        [self setNeedsUpdateConstraints];
    }
}

- (void)setThrowLink:(CADisplayLink *)throwLink {
    if (throwLink != _throwLink) {
        [_throwLink invalidate];
        
        _throwLink = throwLink;
        
        [_throwLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
}

- (void)setLekProgressObject:(NSProgress *)lekProgressObject {
    if (lekProgressObject != _lekProgressObject) {
        _lekProgressObject = lekProgressObject;
        [self frsetNSProgressDisplayLinkEnableduf:YES];
    }
}

- (void)setProgress:(float)progress {
    if (progress != _progress) {
        _progress = progress;
        UIView *indicator = self.indicator;
        if ([indicator respondsToSelector:@selector(setProgress:)]) {
            [(id)indicator setValue:@(self.progress) forKey:@"progress"];
        }
    }
}

- (void)setContentColor:(UIColor *)contentColor {
    if (contentColor != _contentColor && ![contentColor isEqual:_contentColor]) {
        _contentColor = contentColor;
        [self recordmacropooling:contentColor];
    }
}

- (void)setCleanupEnabled:(BOOL)cleanupEnabled {
    if (cleanupEnabled != _cleanupEnabled) {
        _cleanupEnabled = cleanupEnabled;
        [self classHostupdate];
    }
}

#pragma mark - NSProgress

- (void)frsetNSProgressDisplayLinkEnableduf:(BOOL)enabled {
    // We're using CADisplayLink, because NSProgress can change very quickly and observing it may starve the main thread,
    // so we're refreshing the progress only every frame draw
    if (enabled && self.lekProgressObject) {
        // Only create if not already active.
        if (!self.throwLink) {
            self.throwLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(linearprogrammingbackgroundsession)];
        }
    } else {
        self.throwLink = nil;
    }
}

- (void)linearprogrammingbackgroundsession {
    self.progress = self.lekProgressObject.fractionCompleted;
}

#pragma mark - Notifications

- (void)registerForNotifications {
#if !TARGET_OS_TV
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];

    [nc addObserver:self selector:@selector(vustatusBarOrientationDidChangeoz:)
               name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
#endif
}

- (void)gkeunregisterFromNotificationshy {
#if !TARGET_OS_TV
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
#endif
}

#if !TARGET_OS_TV
- (void)vustatusBarOrientationDidChangeoz:(NSNotification *)notification {
    UIView *superview = self.superview;
    if (!superview) {
        return;
    } else {
        [self spaceiterationsequential:YES];
    }
}
#endif

- (void)spaceiterationsequential:(BOOL)animated {
    // Stay in sync with the superview in any case
    if (self.superview) {
        self.bounds = self.superview.bounds;
    }

    // Not needed on iOS 8+, compile out when the deployment target allows,
    // to avoid sharedApplication problems on extension targets
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 80000
    // Only needed pre iOS 8 when added to a window
    BOOL iOS8OrLater = kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_8_0;
    if (iOS8OrLater || ![self.superview isKindOfClass:[UIWindow class]]) return;

    // Make extension friendly. Will not get called on extensions (iOS 8+) due to the above check.
    // This just ensures we don't get a warning about extension-unsafe API.
    Class UIApplicationClass = NSClassFromString(@"UIApplication");
    if (!UIApplicationClass || ![UIApplicationClass respondsToSelector:@selector(sharedApplication)]) return;

    UIApplication *application = [UIApplication performSelector:@selector(sharedApplication)];
    UIInterfaceOrientation orientation = application.statusBarOrientation;
    CGFloat radians = 0;
    
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        radians = orientation == UIInterfaceOrientationLandscapeLeft ? -(CGFloat)M_PI_2 : (CGFloat)M_PI_2;
        // Window coordinates differ!
        self.bounds = CGRectMake(0, 0, self.bounds.size.height, self.bounds.size.width);
    } else {
        radians = orientation == UIInterfaceOrientationPortraitUpsideDown ? (CGFloat)M_PI : 0.f;
    }

    if (animated) {
        [UIView animateWithDuration:0.3 animations:^{
            self.transform = CGAffineTransformMakeRotation(radians);
        }];
    } else {
        self.transform = CGAffineTransformMakeRotation(radians);
    }
#endif
}

@end


@implementation MewMBRoundProgressView

#pragma mark - Lifecycle

- (id)init {
    return [self initWithFrame:CGRectMake(0.f, 0.f, 37.f, 37.f)];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
        _progress = 0.f;
        _mkAnnular = NO;
        _progressTintColor = [[UIColor alloc] initWithWhite:1.f alpha:1.f];
        _backgroundTintColor = [[UIColor alloc] initWithWhite:1.f alpha:.1f];
    }
    return self;
}

#pragma mark - Layout

- (CGSize)intrinsicContentSize {
    return CGSizeMake(37.f, 37.f);
}

#pragma mark - Properties

- (void)setProgress:(float)progress {
    if (progress != _progress) {
        _progress = progress;
        [self setNeedsDisplay];
    }
}

- (void)setProgressTintColor:(UIColor *)progressTintColor {
    NSAssert(progressTintColor, @"The color should not be nil.");
    if (progressTintColor != _progressTintColor && ![progressTintColor isEqual:_progressTintColor]) {
        _progressTintColor = progressTintColor;
        [self setNeedsDisplay];
    }
}

- (void)setBackgroundTintColor:(UIColor *)backgroundTintColor {
    NSAssert(backgroundTintColor, @"The color should not be nil.");
    if (backgroundTintColor != _backgroundTintColor && ![backgroundTintColor isEqual:_backgroundTintColor]) {
        _backgroundTintColor = backgroundTintColor;
        [self setNeedsDisplay];
    }
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    BOOL isPreiOS7 = kCFCoreFoundationVersionNumber < kCFCoreFoundationVersionNumber_iOS_7_0;

    if (_mkAnnular) {
        // Draw background
        CGFloat lineWidth = isPreiOS7 ? 5.f : 2.f;
        UIBezierPath *processBackgroundPath = [UIBezierPath bezierPath];
        processBackgroundPath.lineWidth = lineWidth;
        processBackgroundPath.lineCapStyle = kCGLineCapButt;
        CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        CGFloat radius = (self.bounds.size.width - lineWidth)/2;
        CGFloat startAngle = - ((float)M_PI / 2); // 90 degrees
        CGFloat endAngle = (2 * (float)M_PI) + startAngle;
        [processBackgroundPath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
        [_backgroundTintColor set];
        [processBackgroundPath stroke];
        // Draw progress
        UIBezierPath *processPath = [UIBezierPath bezierPath];
        processPath.lineCapStyle = isPreiOS7 ? kCGLineCapRound : kCGLineCapSquare;
        processPath.lineWidth = lineWidth;
        endAngle = (self.progress * 2 * (float)M_PI) + startAngle;
        [processPath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
        [_progressTintColor set];
        [processPath stroke];
    } else {
        // Draw background
        CGFloat lineWidth = 2.f;
        CGRect allRect = self.bounds;
        CGRect circleRect = CGRectInset(allRect, lineWidth/2.f, lineWidth/2.f);
        CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        [_progressTintColor setStroke];
        [_backgroundTintColor setFill];
        CGContextSetLineWidth(context, lineWidth);
        if (isPreiOS7) {
            CGContextFillEllipseInRect(context, circleRect);
        }
        CGContextStrokeEllipseInRect(context, circleRect);
        // 90 degrees
        CGFloat startAngle = - ((float)M_PI / 2.f);
        // Draw progress
        if (isPreiOS7) {
            CGFloat radius = (CGRectGetWidth(self.bounds) / 2.f) - lineWidth;
            CGFloat endAngle = (self.progress * 2.f * (float)M_PI) + startAngle;
            [_progressTintColor setFill];
            CGContextMoveToPoint(context, center.x, center.y);
            CGContextAddArc(context, center.x, center.y, radius, startAngle, endAngle, 0);
            CGContextClosePath(context);
            CGContextFillPath(context);
        } else {
            UIBezierPath *processPath = [UIBezierPath bezierPath];
            processPath.lineCapStyle = kCGLineCapButt;
            processPath.lineWidth = lineWidth * 2.f;
            CGFloat radius = (CGRectGetWidth(self.bounds) / 2.f) - (processPath.lineWidth / 2.f);
            CGFloat endAngle = (self.progress * 2.f * (float)M_PI) + startAngle;
            [processPath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
            // Ensure that we don't get color overlaping when _progressTintColor alpha < 1.f.
            CGContextSetBlendMode(context, kCGBlendModeCopy);
            [_progressTintColor set];
            [processPath stroke];
        }
    }
}

@end


@implementation SpjMBBarProgressView

#pragma mark - Lifecycle

- (id)init {
    return [self initWithFrame:CGRectMake(.0f, .0f, 120.0f, 20.0f)];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _progress = 0.f;
        _lineColor = [UIColor whiteColor];
        _progressColor = [UIColor whiteColor];
        _hkyProgressRemainingColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
    }
    return self;
}

#pragma mark - Layout

- (CGSize)intrinsicContentSize {
    BOOL isPreiOS7 = kCFCoreFoundationVersionNumber < kCFCoreFoundationVersionNumber_iOS_7_0;
    return CGSizeMake(120.f, isPreiOS7 ? 20.f : 10.f);
}

#pragma mark - Properties

- (void)setProgress:(float)progress {
    if (progress != _progress) {
        _progress = progress;
        [self setNeedsDisplay];
    }
}

- (void)setProgressColor:(UIColor *)progressColor {
    NSAssert(progressColor, @"The color should not be nil.");
    if (progressColor != _progressColor && ![progressColor isEqual:_progressColor]) {
        _progressColor = progressColor;
        [self setNeedsDisplay];
    }
}

- (void)setHkyProgressRemainingColor:(UIColor *)hkyProgressRemainingColor {
    NSAssert(hkyProgressRemainingColor, @"The color should not be nil.");
    if (hkyProgressRemainingColor != _hkyProgressRemainingColor && ![hkyProgressRemainingColor isEqual:_hkyProgressRemainingColor]) {
        _hkyProgressRemainingColor = hkyProgressRemainingColor;
        [self setNeedsDisplay];
    }
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context,[_lineColor CGColor]);
    CGContextSetFillColorWithColor(context, [_hkyProgressRemainingColor CGColor]);
    
    // Draw background
    CGFloat radius = (rect.size.height / 2) - 2;
    CGContextMoveToPoint(context, 2, rect.size.height/2);
    CGContextAddArcToPoint(context, 2, 2, radius + 2, 2, radius);
    CGContextAddLineToPoint(context, rect.size.width - radius - 2, 2);
    CGContextAddArcToPoint(context, rect.size.width - 2, 2, rect.size.width - 2, rect.size.height / 2, radius);
    CGContextAddArcToPoint(context, rect.size.width - 2, rect.size.height - 2, rect.size.width - radius - 2, rect.size.height - 2, radius);
    CGContextAddLineToPoint(context, radius + 2, rect.size.height - 2);
    CGContextAddArcToPoint(context, 2, rect.size.height - 2, 2, rect.size.height/2, radius);
    CGContextFillPath(context);
    
    // Draw border
    CGContextMoveToPoint(context, 2, rect.size.height/2);
    CGContextAddArcToPoint(context, 2, 2, radius + 2, 2, radius);
    CGContextAddLineToPoint(context, rect.size.width - radius - 2, 2);
    CGContextAddArcToPoint(context, rect.size.width - 2, 2, rect.size.width - 2, rect.size.height / 2, radius);
    CGContextAddArcToPoint(context, rect.size.width - 2, rect.size.height - 2, rect.size.width - radius - 2, rect.size.height - 2, radius);
    CGContextAddLineToPoint(context, radius + 2, rect.size.height - 2);
    CGContextAddArcToPoint(context, 2, rect.size.height - 2, 2, rect.size.height/2, radius);
    CGContextStrokePath(context);
    
    CGContextSetFillColorWithColor(context, [_progressColor CGColor]);
    radius = radius - 2;
    CGFloat amount = self.progress * rect.size.width;
    
    // Progress in the middle area
    if (amount >= radius + 4 && amount <= (rect.size.width - radius - 4)) {
        CGContextMoveToPoint(context, 4, rect.size.height/2);
        CGContextAddArcToPoint(context, 4, 4, radius + 4, 4, radius);
        CGContextAddLineToPoint(context, amount, 4);
        CGContextAddLineToPoint(context, amount, radius + 4);
        
        CGContextMoveToPoint(context, 4, rect.size.height/2);
        CGContextAddArcToPoint(context, 4, rect.size.height - 4, radius + 4, rect.size.height - 4, radius);
        CGContextAddLineToPoint(context, amount, rect.size.height - 4);
        CGContextAddLineToPoint(context, amount, radius + 4);
        
        CGContextFillPath(context);
    }
    
    // Progress in the right arc
    else if (amount > radius + 4) {
        CGFloat x = amount - (rect.size.width - radius - 4);

        CGContextMoveToPoint(context, 4, rect.size.height/2);
        CGContextAddArcToPoint(context, 4, 4, radius + 4, 4, radius);
        CGContextAddLineToPoint(context, rect.size.width - radius - 4, 4);
        CGFloat angle = -acos(x/radius);
        if (isnan(angle)) angle = 0;
        CGContextAddArc(context, rect.size.width - radius - 4, rect.size.height/2, radius, M_PI, angle, 0);
        CGContextAddLineToPoint(context, amount, rect.size.height/2);

        CGContextMoveToPoint(context, 4, rect.size.height/2);
        CGContextAddArcToPoint(context, 4, rect.size.height - 4, radius + 4, rect.size.height - 4, radius);
        CGContextAddLineToPoint(context, rect.size.width - radius - 4, rect.size.height - 4);
        angle = acos(x/radius);
        if (isnan(angle)) angle = 0;
        CGContextAddArc(context, rect.size.width - radius - 4, rect.size.height/2, radius, -M_PI, angle, 1);
        CGContextAddLineToPoint(context, amount, rect.size.height/2);
        
        CGContextFillPath(context);
    }
    
    // Progress is in the left arc
    else if (amount < radius + 4 && amount > 0) {
        CGContextMoveToPoint(context, 4, rect.size.height/2);
        CGContextAddArcToPoint(context, 4, 4, radius + 4, 4, radius);
        CGContextAddLineToPoint(context, radius + 4, rect.size.height/2);

        CGContextMoveToPoint(context, 4, rect.size.height/2);
        CGContextAddArcToPoint(context, 4, rect.size.height - 4, radius + 4, rect.size.height - 4, radius);
        CGContextAddLineToPoint(context, radius + 4, rect.size.height/2);
        
        CGContextFillPath(context);
    }
}

@end


@interface MegMBBackgroundView ()

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000 || TARGET_OS_TV
@property UIVisualEffectView *effectView;
#endif
#if !TARGET_OS_TV
@property UIToolbar *toolbar;
#endif

@end


@implementation MegMBBackgroundView

#pragma mark - Lifecycle

- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_7_0) {
            _style = MBProgressHUDBackgroundStyleBlur;
            if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_8_0) {
                _color = [UIColor colorWithWhite:0.8f alpha:0.6f];
            } else {
                _color = [UIColor colorWithWhite:0.95f alpha:0.6f];
            }
        } else {
            _style = MBProgressHUDBackgroundStyleSolidColor;
            _color = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        }

        self.clipsToBounds = YES;

        [self rowdeletenestedtable];
    }
    return self;
}

#pragma mark - Layout

- (CGSize)intrinsicContentSize {
    // Smallest size possible. Content pushes against this.
    return CGSizeZero;
}

#pragma mark - Appearance

- (void)setStyle:(MBProgressHUDBackgroundStyle)style {
    if (style == MBProgressHUDBackgroundStyleBlur && kCFCoreFoundationVersionNumber < kCFCoreFoundationVersionNumber_iOS_7_0) {
        style = MBProgressHUDBackgroundStyleSolidColor;
    }
    if (_style != style) {
        _style = style;
        [self rowdeletenestedtable];
    }
}

- (void)setColor:(UIColor *)color {
    NSAssert(color, @"The color should not be nil.");
    if (color != _color && ![color isEqual:_color]) {
        _color = color;
        [self recordmacropooling:color];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Views

- (void)rowdeletenestedtable {
    MBProgressHUDBackgroundStyle style = self.style;
    if (style == MBProgressHUDBackgroundStyleBlur) {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000 || TARGET_OS_TV
        if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_8_0) {
            UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
            UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
            [self addSubview:effectView];
            effectView.frame = self.bounds;
            effectView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
            self.backgroundColor = self.color;
            self.layer.allowsGroupOpacity = NO;
            self.effectView = effectView;
        } else {
#endif
#if !TARGET_OS_TV
            UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectInset(self.bounds, -100.f, -100.f)];
            toolbar.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
            toolbar.barTintColor = self.color;
            toolbar.translucent = YES;
            [self addSubview:toolbar];
            self.toolbar = toolbar;
#endif
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000 || TARGET_OS_TV
        }
#endif
    } else {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000 || TARGET_OS_TV
        if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_8_0) {
            [self.effectView removeFromSuperview];
            self.effectView = nil;
        } else {
#endif
#if !TARGET_OS_TV
            [self.toolbar removeFromSuperview];
            self.toolbar = nil;
#endif
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000 || TARGET_OS_TV
        }
#endif
        self.backgroundColor = self.color;
    }
}

- (void)recordmacropooling:(UIColor *)color {
    if (self.style == MBProgressHUDBackgroundStyleBlur) {
        if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_8_0) {
            self.backgroundColor = self.color;
        } else {
#if !TARGET_OS_TV
            self.toolbar.barTintColor = color;
#endif
        }
    } else {
        self.backgroundColor = self.color;
    }
}

@end


@implementation ComponentsD (Deprecated)

#pragma mark - Class

+ (NSUInteger)hideAllHUDsForView:(UIView *)view animated:(BOOL)animated {
    NSArray *huds = [ComponentsD allHUDsForView:view];
    for (ComponentsD *hud in huds) {
        hud.callbackRobustnessHide = YES;
        [hud hideAnimated:animated];
    }
    return [huds count];
}

+ (NSArray *)allHUDsForView:(UIView *)view {
    NSMutableArray *huds = [NSMutableArray array];
    NSArray *subviews = view.subviews;
    for (UIView *aView in subviews) {
        if ([aView isKindOfClass:self]) {
            [huds addObject:aView];
        }
    }
    return [NSArray arrayWithArray:huds];
}

#pragma mark - Lifecycle

- (id)initWithWindow:(UIWindow *)window {
    return [self initWithView:window];
}

#pragma mark - Show & hide

- (void)show:(BOOL)animated {
    [self ziwshowAnimatedbh:animated];
}

- (void)hide:(BOOL)animated {
    [self hideAnimated:animated];
}

- (void)scjhideno:(BOOL)animated objectcall:(NSTimeInterval)delay {
    [self processarchivehandle:animated objectcall:delay];
}

#pragma mark - Threading

- (void)poolingoverloadstandardtemplatelibrary:(SEL)method unqualifiedword:(id)target checkproject:(id)object gwkanimatedbd:(BOOL)animated {
    [self ziwshowAnimatedbh:animated parameterindex:^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        // Start executing the requested task
        [target performSelector:method withObject:object];
#pragma clang diagnostic pop
    }];
}

- (void)ziwshowAnimatedbh:(BOOL)animated parameterindex:(dispatch_block_t)block {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    [self ziwshowAnimatedbh:animated parameterindex:block vectorbackground:queue containmentresolution:NULL];
}

- (void)ziwshowAnimatedbh:(BOOL)animated parameterindex:(dispatch_block_t)block containmentresolution:(void (^)())completion {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    [self ziwshowAnimatedbh:animated parameterindex:block vectorbackground:queue containmentresolution:completion];
}

- (void)ziwshowAnimatedbh:(BOOL)animated parameterindex:(dispatch_block_t)block vectorbackground:(dispatch_queue_t)queue {
    [self ziwshowAnimatedbh:animated parameterindex:block vectorbackground:queue containmentresolution:NULL];
}

- (void)ziwshowAnimatedbh:(BOOL)animated parameterindex:(dispatch_block_t)block vectorbackground:(dispatch_queue_t)queue containmentresolution:(nullable MBProgressHUDCompletionBlock)completion {
    self.imageProgress = YES;
    self.completionBlock = completion;
    dispatch_async(queue, ^(void) {
        block();
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            [self cleanUp];
        });
    });
    [self ziwshowAnimatedbh:animated];
}

- (void)cleanUp {
    self.imageProgress = NO;
    [self hideAnimated:self.protocolAnimation];
}

#pragma mark - Labels

- (NSString *)labelText {
    return self.label.text;
}

- (void)setLabelText:(NSString *)labelText {
    MBMainThreadAssert();
    self.label.text = labelText;
}

- (UIFont *)labelFont {
    return self.label.font;
}

- (void)setLabelFont:(UIFont *)labelFont {
    MBMainThreadAssert();
    self.label.font = labelFont;
}

- (UIColor *)labelColor {
    return self.label.textColor;
}

- (void)setLabelColor:(UIColor *)labelColor {
    MBMainThreadAssert();
    self.label.textColor = labelColor;
}

- (NSString *)detailsLabelText {
    return self.detailsLabel.text;
}

- (void)setDetailsLabelText:(NSString *)detailsLabelText {
    MBMainThreadAssert();
    self.detailsLabel.text = detailsLabelText;
}

- (UIFont *)detailsLabelFont {
    return self.detailsLabel.font;
}

- (void)setDetailsLabelFont:(UIFont *)detailsLabelFont {
    MBMainThreadAssert();
    self.detailsLabel.font = detailsLabelFont;
}

- (UIColor *)detailsLabelColor {
    return self.detailsLabel.textColor;
}

- (void)setDetailsLabelColor:(UIColor *)detailsLabelColor {
    MBMainThreadAssert();
    self.detailsLabel.textColor = detailsLabelColor;
}

- (CGFloat)opacity {
    return _opacity;
}

- (void)setOpacity:(CGFloat)opacity {
    MBMainThreadAssert();
    _opacity = opacity;
}

- (UIColor *)color {
    return self.conceptSyntaxView.color;
}

- (void)setColor:(UIColor *)color {
    MBMainThreadAssert();
    self.conceptSyntaxView.color = color;
}

- (CGFloat)yOffset {
    return self.offset.y;
}

- (void)setYOffset:(CGFloat)yOffset {
    MBMainThreadAssert();
    self.offset = CGPointMake(self.offset.x, yOffset);
}

- (CGFloat)xOffset {
    return self.offset.x;
}

- (void)setXOffset:(CGFloat)xOffset {
    MBMainThreadAssert();
    self.offset = CGPointMake(xOffset, self.offset.y);
}

- (CGFloat)cornerRadius {
    return self.conceptSyntaxView.layer.cornerRadius;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    MBMainThreadAssert();
    self.conceptSyntaxView.layer.cornerRadius = cornerRadius;
}

- (BOOL)dimBackground {
    MegMBBackgroundView *backgroundView = self.backgroundView;
    UIColor *dimmedColor =  [UIColor colorWithWhite:0.f alpha:.2f];
    return backgroundView.style == MBProgressHUDBackgroundStyleSolidColor && [backgroundView.color isEqual:dimmedColor];
}

- (void)setDimBackground:(BOOL)dimBackground {
    MBMainThreadAssert();
    self.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    self.backgroundView.color = dimBackground ? [UIColor colorWithWhite:0.f alpha:.2f] : [UIColor clearColor];
}

- (CGSize)size {
    return self.conceptSyntaxView.frame.size;
}

- (UIColor *)activityIndicatorColor {
    return _activityIndicatorColor;
}

- (void)setActivityIndicatorColor:(UIColor *)activityIndicatorColor {
    if (activityIndicatorColor != _activityIndicatorColor) {
        _activityIndicatorColor = activityIndicatorColor;
        UIActivityIndicatorView *indicator = (UIActivityIndicatorView *)self.indicator;
        if ([indicator isKindOfClass:[UIActivityIndicatorView class]]) {
            [indicator setColor:activityIndicatorColor];
        }
    }
}

@end

@implementation LrwMBProgressHUDRoundedButton

#pragma mark - Lifecycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        CALayer *layer = self.layer;
        layer.borderWidth = 1.f;
    }
    return self;
}

#pragma mark - Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    // Fully rounded corners
    CGFloat height = CGRectGetHeight(self.bounds);
    self.layer.cornerRadius = ceil(height / 2.f);
}

- (CGSize)intrinsicContentSize {
    // Only show if we have associated control events
    if (self.allControlEvents == 0) return CGSizeZero;
    CGSize size = [super intrinsicContentSize];
    // Add some side padding
    size.width += 20.f;
    return size;
}

#pragma mark - Color

- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state {
    [super setTitleColor:color forState:state];
    // Update related colors
    [self setHighlighted:self.highlighted];
    self.layer.borderColor = color.CGColor;
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    UIColor *baseColor = [self titleColorForState:UIControlStateSelected];
    self.backgroundColor = highlighted ? [baseColor colorWithAlphaComponent:0.1f] : [UIColor clearColor];
}

@end
