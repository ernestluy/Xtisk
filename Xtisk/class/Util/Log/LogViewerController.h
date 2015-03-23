/********************************************************************
 文件名称 : LogViewerController.h 文件
 文件描述 : 日志查看器
 修改历史 : 2012-03-30 1.00 初始版本
 *********************************************************************/

#import <UIKit/UIKit.h>


@interface LogViewerController : UIViewController {
	//文字显示
	UITextView *m_fileView;
}
//加载日志文件
- (void)loadLogFile;
@end
