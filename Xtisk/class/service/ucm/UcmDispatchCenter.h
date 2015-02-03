

#import <Foundation/Foundation.h>
#import "PublicDefine.h"
//#import "ProtocalBufferAddressBook.pb.h"

@interface UcmDispatchCenter : NSObject
{
    NSString           *m_timeStamp;
    BOOL               m_isFirstDownLoad;//第一次同步
    
    NSMutableDictionary *m_serialNoDic;
    
    NSMutableArray     *m_cacheArray;
}

@property (nonatomic,retain) NSString           *m_timeStamp;
-(NSString *)getErrorString:(int)error;
-(void)dispatchHandle:(int *)header body:(char *)body;

@end
