//
//  PDALog.h
//  MyLibrary
//
//  Created by Panda on 15/9/23.
//  Copyright (c) 2015年 Panda. All rights reserved.
//

#ifndef MyLibrary_PDALog_h
#define MyLibrary_PDALog_h


//-------------------打印日志-------------------------
//重写NSLOG  打印文件  打印行 打印函数
#define NSLog(format, ...) do { \
fprintf(stderr, "<%s : %d> %s\t", \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], \
__LINE__, __func__); \
(NSLog)((format), ##__VA_ARGS__); \
fprintf(stderr, "\n"); \
} while (0)



//DEBUG  模式下打印日志,当前行 并弹出一个警告
#ifdef DEBUG
#   define ALERTLog(fmt, ...)  { UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%s\n [Line %d] ", __PRETTY_FUNCTION__, __LINE__] message:[NSString stringWithFormat:fmt, ##__VA_ARGS__]  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil]; [alert show]; }
#else
#   define ALERTLog(...)
#endif


// 自定义Log代码
#ifdef DEBUG //调试状态
#define ALLLog(...) NSLog(__VA_ARGS__)
#else //发布状态
#define ALLLog(...)
#endif

/**Log调用的函数  2 >*/
#define LogFunc             NSLog(@"%s", __func__);
/**Log指定视图的边界 3 >*/
#define LogFrame(view)      NSLog(@"%@", NSStringFromCGRect(view.frame));
/**Log指定视图中的所有子视图 4 >*/
#define LogSubViews(view)   NSLog(@"%@", view.subviews);

#endif
