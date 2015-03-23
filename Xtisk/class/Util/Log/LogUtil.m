//
//  LogUtil.m
//  Taps
//


#include "LogUtil.h"

#ifdef LOG_ON

static char kLogFilePath[1024] = {'\0'};
#define TIME_FORMAT		"[%04d-%02d-%02d %02d:%02d:%02d]"
#define LOG_DIRECTORY	@"Logs"
#define LOG_PATH		@"Log.txt"
#define LOG_SAVE_PATH	@"LogSave%s.txt"
#define LOG_SIZE		1*256*1024
#endif
char *getTimeString(){
	char* timeStr = nil;
	time_t cur_time;
	cur_time = time(&cur_time);
	struct tm* date = localtime(&cur_time);
	asprintf(&timeStr, TIME_FORMAT
			 ,date->tm_year + 1900
			 ,date->tm_mon + 1
			 ,date->tm_mday
			 ,date->tm_hour
			 ,date->tm_min
			 ,date->tm_sec);
	return timeStr;
}

void PRINT_LOG(const char *format, ...)
{
#ifdef LOG_ON
	NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString* docDir = [paths objectAtIndex:0];
	NSString* logDir = [docDir stringByAppendingPathComponent:LOG_DIRECTORY];
	NSString* logFilePath = [logDir stringByAppendingPathComponent:LOG_PATH];
	[[NSFileManager defaultManager] createDirectoryAtPath:logDir withIntermediateDirectories:NO attributes:nil error:nil];
	
	if ([[NSFileManager defaultManager] fileExistsAtPath:logFilePath] == YES) {
		NSData * fileData = [[NSData alloc] initWithContentsOfFile:logFilePath];
		NSUInteger length = [fileData length];
		if(length >= LOG_SIZE){
			CLEAR_LOG();
		}
		[fileData release];
	}else{
		BOOL success = [[NSFileManager defaultManager] createFileAtPath:logFilePath contents:nil attributes:nil];
		printf("Create File:%s %s.",[logFilePath UTF8String], success ? "Success" : "Error");
	}
	strcpy(kLogFilePath, [logFilePath UTF8String]);
	
	char* message = nil;
	char* timeStr = nil;
	va_list args;
	va_start(args,format);
	vasprintf(&message, format,args);
	va_end(args);
	
	time_t cur_time;
	cur_time = time(&cur_time);
	struct tm* date = localtime(&cur_time);
	asprintf(&timeStr, TIME_FORMAT
			 ,date->tm_year + 1900
			 ,date->tm_mon + 1
			 ,date->tm_mday
			 ,date->tm_hour
			 ,date->tm_min
			 ,date->tm_sec);

	FILE* handle  = fopen(kLogFilePath, "r+");
	char* log = nil;
	asprintf(&log,"\n%s: %s\t",timeStr,message);
	
	if (handle != nil) {
		fseek(handle,0,SEEK_END); 
		fwrite(log, 1, strlen(log), handle);
		fclose(handle);
	}
	free(timeStr);
    free(message);
	free(log);
	
#endif
}

void CLEAR_LOG(){
#ifdef LOG_ON
	NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString* docDir = [paths objectAtIndex:0];
	NSString* logDir = [docDir stringByAppendingPathComponent:LOG_DIRECTORY];
	NSString* logFilePath = [logDir stringByAppendingPathComponent:LOG_PATH];
	NSString* savePath = [logDir stringByAppendingPathComponent:[NSString stringWithFormat:LOG_SAVE_PATH,getTimeString()]];
	[[NSFileManager defaultManager] moveItemAtPath:logFilePath toPath:savePath error:nil];
	NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:logDir error:nil];
	while ([files count] > 20) {
		[[NSFileManager defaultManager] removeItemAtPath:[logDir stringByAppendingPathComponent:[files objectAtIndex:0]] error:nil];
		files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:logDir error:nil];
	}
	BOOL success = [[NSFileManager defaultManager] createFileAtPath:logFilePath contents:nil attributes:nil];
	printf("Create File:%s %s.",[logFilePath UTF8String], success ? "Success" : "Error");
#endif	
	
}
