//
//  HYMembershipPurchaseViewController.h
//  HYPageView
//
//  Created by leiming on 2018/8/10.
//  Copyright © 2018年 haiyungroup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WMMenuView.h"
#import "HYMembershipPurchaseModel.h"

@interface HYMembershipPurchaseViewController : UIViewController <WMMenuViewDelegate, WMMenuViewDataSource>

/**
 数据模型
 */
@property (nonatomic, nullable, copy) NSArray<HYMembershipPurchaseModel *> *membershipModels;

/**
 导航栏标题
 */
@property (nonatomic, nullable, copy) NSArray<NSString *> *titles;

@end
