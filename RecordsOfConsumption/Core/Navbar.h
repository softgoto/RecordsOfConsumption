

//
//  Created by YeJian on 13-8-12.
//  Copyright (c) 2013年 YeJian. All rights reserved.
//

#define SysNavbarHeight 44

#define DefaultStateBarColor [UIColor whiteColor]
#define DefaultStateBarSytle UIBarStyleBlackOpaque

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@interface Navbar : UINavigationBar

 /**< 适用于ios7*/
@property (nonatomic,strong)UIColor *stateBarColor;/**< 默认black*/
@property (nonatomic,assign)UIBarStyle cusBarStyele;/**< 默认UIBarStyleBlackOpaque*/

- (void)setDefault;

@end




/**
 * @brief 自定义barbuttonitem
 *
 * @param
 * @return 
 */

#define TitleFont 17
#define TitleColor [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:1]

#define BackgroundImage @"bg_navigation_bar"        //背景

#define BackItemImage @"common_icon_back"           //返回
#define BackItemSelectedImage @"common_icon_back"   //返回选中

#define LeftItemImage @"product_icon_collect"          //左边
#define LeftItemSelectedImage @"product_icon_collect"  //左边选中

#define RightItemImage @"product_icon_type"         //右边
#define RightItemSelectedImage @"product_icon_type" //右边选中


//#define ItemSelectedImage @"product_icon_type"

#define LeftItemOffset UIEdgeInsetsMake(0, 5, 0, 0)
#define RightItemOffset UIEdgeInsetsMake(0, 0, 0, 5)

#define ItemLeftMargin 10
#define ItemWidth 35
#define ItemHeight 25
#define ItemTextFont 12
//#define ItemTextNormalColot [UIColor whiteColor]
//#define ItemTextSelectedColot [UIColor colorWithWhite:0.7 alpha:1]


typedef enum {
    
    NavBarButtonItemTypeDefault = 0,
    NavBarButtonItemTypeBack = 1,
    NavBarButtonItemTypeLeft = 2
    
}NavBarButtonItemType;


@interface NavBarButtonItem : NSObject
@property (nonatomic,assign)NavBarButtonItemType itemType;
@property (nonatomic,strong)UIButton *button;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *image;
@property (nonatomic,strong)UIFont *font;
@property (nonatomic,strong)UIColor *normalColor;
@property (nonatomic,strong)UIColor *selectedColor;
@property (nonatomic,strong)id target;
@property (nonatomic,assign)SEL selector;
@property (nonatomic,assign)BOOL highlightedWhileSwitch;

- (id)initWithType:(NavBarButtonItemType)itemType;

+ (id)defauleItemWithTarget:(id)target action:(SEL)action title:(NSString *)title type:(NavBarButtonItemType)type;
+ (id)defauleItemWithTarget:(id)target action:(SEL)action image:(NSString *)image;
+ (id)backItemWithTarget:(id)target action:(SEL)action title:(NSString *)title;

- (void)setTarget:(id)target withAction:(SEL)action;


@end


@interface UINavigationItem (CustomBarButtonItem)

- (void)setNewTitle:(NSString *)title;
- (void)setNewTitleImage:(UIImage *)image;
- (void)setNewTitleSearch:(UIView *)view;

- (void)setLeftItemWithTarget:(id)target action:(SEL)action title:(NSString *)title;
- (void)setLeftItemWithTarget:(id)target action:(SEL)action image:(NSString *)image;
- (void)setLeftItemWithButtonItem:(NavBarButtonItem *)item;


- (void)setRightItemWithTarget:(id)target action:(SEL)action title:(NSString *)title;
- (void)setRightItemWithTarget:(id)target action:(SEL)action image:(NSString *)image;
- (void)setRightItemWithButtonItem:(NavBarButtonItem *)item;


- (void)setBackItemWithTarget:(id)target action:(SEL)action;
- (void)setBackItemWithTarget:(id)target action:(SEL)action title:(NSString *)title;

@end
