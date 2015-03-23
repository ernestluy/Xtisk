//
//  LogUtil.h
//  Taps

//


#import <Foundation/Foundation.h>

/*
 
 1）	日志打印应遵守以下基本原则：
 (1)日志应在在关键、需要的地方打
 (2)避免由于打开日志影响用户使用和问题定位
 (3)日志中包含信息以能够支撑问题定位为宜，通常为：所属类，所在函数等。
 (4)日志中要关注敏感信息：比如：密码等
 
 1）	日志文件建立规范：
 （1）文件采用txt文本格式，
 （2）命名规范为log_YYYYMMDDhhmmss.txt，每次登录产生一个日志文件。
 （3）文件编码：ASCII编码方式
 
*/

//打印代码所在的文件以及代码所在的行
/*
 打印Log范例

 DBGLOG("Test.");
 DBGLOG("StringValue:%s IntValue:%d FloatValue:%f","Text",100,10.01);

 */

#define DBGLOG PRINT_LOG("%s:%d",__FILE__,__LINE__);PRINT_LOG

#define LOG_ON

void PRINT_LOG(const char *format, ...);

void CLEAR_LOG();