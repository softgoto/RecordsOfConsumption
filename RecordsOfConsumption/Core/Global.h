//
//  Global.h
//  RecordsOfConsumption
//
//  Created by xuhui on 14/11/24.
//  Copyright (c) 2014年 xuhui. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "Navbar.h"

//#import "EncryptUtil.h"


#define NavigationBar_HEIGHT 64

//屏幕尺寸
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

//version
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

//Image Name
#undef TTIMAGE
#define TTIMAGE(URL) [UIImage imageNamed:URL]

//Font Size
#define fontWithBoldSize(size) [UIFont boldSystemFontOfSize:size]
#define fontWithSize(size) [UIFont systemFontOfSize:size]

//RGB颜色
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

//清除背景色
#define CLEARCOLOR [UIColor clearColor]



NSString* TTPathForDocumentsResource(NSString* relativePath);

