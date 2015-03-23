    //
//  LogViewerController.m
//  TPad
//
//  Created by ZhangRujin on 3/30/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "LogViewerController.h"
#import "LogUtil.h"
#import <QuartzCore/QuartzCore.h>

#define LOG_PATH		@"Log.txt"
#define LOG_DIRECTORY	@"Logs"

@implementation LogViewerController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	self.view.backgroundColor = [UIColor blackColor];
	UIButton *clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	clearBtn.backgroundColor = [UIColor whiteColor];
	clearBtn.layer.masksToBounds = YES;
	clearBtn.layer.cornerRadius = 5;
	clearBtn.layer.borderWidth = 1;

	[clearBtn addTarget:self action:@selector(clearLog) forControlEvents:UIControlEventTouchUpInside];
	clearBtn.frame = CGRectMake(80, 5, 50, 30);
	clearBtn.titleLabel.textColor = [UIColor darkGrayColor];
	[clearBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
	[clearBtn setTitle:@"clear" forState:UIControlStateNormal];
	[self.view addSubview:clearBtn];
	
	
	UIButton *returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	returnBtn.backgroundColor = [UIColor whiteColor];
	returnBtn.titleLabel.textColor = [UIColor darkGrayColor];
	[returnBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
	returnBtn.layer.masksToBounds = YES;
	returnBtn.layer.cornerRadius = 5;
	returnBtn.layer.borderWidth = 1;
	[returnBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
	returnBtn.frame = CGRectMake(10, 5, 50, 30);
	[returnBtn setTitle:@"back" forState:UIControlStateNormal];
	[self.view addSubview:returnBtn];
	
	UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	saveBtn.backgroundColor = [UIColor whiteColor];
	saveBtn.titleLabel.textColor = [UIColor darkGrayColor];
	[saveBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
	saveBtn.layer.masksToBounds = YES;
	saveBtn.layer.cornerRadius = 5;
	saveBtn.layer.borderWidth = 1;
	[saveBtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
	saveBtn.frame = CGRectMake(150, 5, 50, 30);
	[saveBtn setTitle:@"save" forState:UIControlStateNormal];
	[self.view addSubview:saveBtn];
	CGRect mainRect = [[UIScreen mainScreen] bounds];
	UITextView *fileView = [[UITextView alloc] initWithFrame:CGRectMake(0, 44, mainRect.size.width, mainRect.size.height - 44)];
	m_fileView = fileView;
	fileView.editable = NO;
	[self.view addSubview:fileView];
	[fileView release];
	
    [super viewDidLoad];
    [self loadLogFile];
}
//加载日志文件
- (void)loadLogFile{
	//日志路径
	NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString* docDir = [paths objectAtIndex:0];
	NSString* logDir = [docDir stringByAppendingPathComponent:LOG_DIRECTORY];
	NSString* logFilePath = [logDir stringByAppendingPathComponent:LOG_PATH];
	//加载内容
	NSString *text = [NSString stringWithContentsOfFile:logFilePath encoding:NSUTF8StringEncoding error:nil];
	m_fileView.text = text;
	//设置显示位置
	m_fileView.contentOffset = CGPointMake(0, MAX(m_fileView.contentSize.height - m_fileView.frame.size.height,0));
}
//返回
//- (void)back{
//	[self.navigationController popViewControllerAnimated:YES];
//}
- (void)save{
	//日志路径
	NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString* docDir = [paths objectAtIndex:0];
	NSString* logDir = [docDir stringByAppendingPathComponent:LOG_DIRECTORY];
	NSString* logFilePath = [logDir stringByAppendingPathComponent:LOG_PATH];
	//加载内容
	NSString *text = [NSString stringWithContentsOfFile:logFilePath encoding:NSUTF8StringEncoding error:nil];
	
	NSString *subject = @"ishekou subject";
	NSString *body = text;
	NSString *address = @"ernest_luyi@163.com";
	NSString *cc = @"ernest_luyi@163.com";
	NSString *path = [NSString stringWithFormat:@"mailto:%@?cc=%@&subject=%@&body=%@", address, cc, subject, body];
	NSURL *url = [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	[[UIApplication sharedApplication] openURL:url];
	
	
	
}
//清空日志
- (void)clearLog{
	CLEAR_LOG();
	//重新加载
	[self loadLogFile];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
	return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
