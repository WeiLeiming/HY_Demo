//
//  HYMembershipPurchaseViewController.m
//  HYPageView
//
//  Created by leiming on 2018/8/10.
//  Copyright © 2018年 haiyungroup. All rights reserved.
//

#import "HYMembershipPurchaseViewController.h"

static NSInteger const kHYUndefinedIndex = -1;
static NSInteger const kHYModelsCountUndefined = -1;

@interface HYMembershipPurchaseViewController () {
    CGRect _menuViewFrame;
}

// 顶部导航栏
@property (nonatomic, nullable, weak) WMMenuView *menuView;
// 当前展示的会籍卡
@property (nonatomic, strong) HYMembershipPurchaseModel *currentMembershipModel;
// 设置选中几号 item
@property (nonatomic, assign) NSInteger selectIndex;
// 会籍卡数量
@property (nonatomic, assign) NSInteger membershipCount;
// 选中时的标题尺寸
@property (nonatomic, assign) CGFloat titleSizeSelected;
// 非选中时的标题尺寸
@property (nonatomic, assign) CGFloat titleSizeNormal;
// 标题选中时的颜色, 颜色是可动画的.
@property (nonatomic, strong) UIColor *titleColorSelected;
// 标题非选择时的颜色, 颜色是可动画的.
@property (nonatomic, strong) UIColor *titleColorNormal;

@end

@implementation HYMembershipPurchaseViewController

#pragma mark - Setter
- (void)setSelectIndex:(NSInteger)selectIndex {
    _selectIndex = selectIndex;
    if (self.menuView) {
        [self.menuView selectItemAtIndex:selectIndex];
    }
    self.currentMembershipModel = self.membershipModels[selectIndex];
}

#pragma mark - Getter
- (NSInteger)modelsCount {
    if (_membershipCount == kHYModelsCountUndefined) {
        _membershipCount = self.membershipModels.count;
    }
    return _membershipCount;
}

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (!self.membershipCount) return;
    [self hy_addMenuView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Public Methods
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self hy_setup];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self hy_setup];
    }
    return self;
}

# pragma mark - Private Methods
/**
 初始化一些参数，在init中调用
 */
- (void)hy_setup {
    _membershipModels = @[];
    _titles = @[@"银卡", @"金卡", @"翡翠卡", @"钻石卡", @"黑金卡"];
    _membershipCount = kHYModelsCountUndefined;
    _menuViewFrame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44);
    
    _titleSizeSelected  = 16.f;
    _titleSizeNormal    = 16.f;
    _titleColorSelected = [UIColor colorWithRed:183/255.0 green:154/255.0 blue:83/255.0 alpha:1];
    _titleColorNormal   = [UIColor colorWithRed:130/255.0 green:143/255.0 blue:159/255.0 alpha:1];
}

/**
 添加MenuView视图
 */
- (void)hy_addMenuView {
    WMMenuView *menuView = [[WMMenuView alloc] initWithFrame:CGRectZero];
    menuView.frame = _menuViewFrame;
    menuView.delegate = self;
    menuView.dataSource = self;
    menuView.style = WMMenuViewStyleLine;
    menuView.layoutMode = WMMenuViewLayoutModeScatter;
    menuView.progressHeight = 4.f;
    menuView.contentMargin = 0.f;
    menuView.progressWidths = @[@(20), @(20), @(20), @(20), @(20)];
    menuView.progressHeight = 2.f;
    menuView.progressViewIsNaughty = YES;
    menuView.progressViewCornerRadius = 0.f;
    menuView.showOnNavigationBar = YES;
    menuView.lineColor = [UIColor colorWithRed:183/255.0 green:154/255.0 blue:83/255.0 alpha:1];
    self.navigationItem.titleView = menuView;
    self.menuView = menuView;
}

/**
 计算item宽度

 @param index item位置
 @return 宽度
 */
- (CGFloat)hy_calculateItemWithAtIndex:(NSInteger)index {
    NSString *title = self.titles[index];
    UIFont *titleFont = [UIFont systemFontOfSize:self.titleSizeSelected];
    NSDictionary *attrs = @{NSFontAttributeName: titleFont};
    CGFloat itemWidth = [title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) attributes:attrs context:nil].size.width;
    return ceil(itemWidth);
}

#pragma mark - WMMenuViewDelegate
- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    return [self hy_calculateItemWithAtIndex:index];
}

- (CGFloat)menuView:(WMMenuView *)menu itemMarginAtIndex:(NSInteger)index {
    return 24.f;
}

- (CGFloat)menuView:(WMMenuView *)menu titleSizeForState:(WMMenuItemState)state atIndex:(NSInteger)index {
    switch (state) {
        case WMMenuItemStateSelected: return self.titleSizeSelected;
        case WMMenuItemStateNormal: return self.titleSizeNormal;
    }
}

- (UIColor *)menuView:(WMMenuView *)menu titleColorForState:(WMMenuItemState)state atIndex:(NSInteger)index {
    switch (state) {
        case WMMenuItemStateSelected: return self.titleColorSelected;
        case WMMenuItemStateNormal: return self.titleColorNormal;
    }
}

# pragma mark - WMMenuViewDataSource
- (NSInteger)numbersOfTitlesInMenuView:(WMMenuView *)menu {
//    return self.membershipCount;
    return self.titles.count;
}

- (NSString *)menuView:(WMMenuView *)menu titleAtIndex:(NSInteger)index {
    return [self.titles objectAtIndex:index];
}

@end
