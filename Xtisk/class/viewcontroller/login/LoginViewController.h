

#import <UIKit/UIKit.h>
#import "ExtendsView.h"
#import "Person.h"
#import "PublicDefine.h"
typedef enum  {
    INTO_TAB_OTHER = 0,
    INTO_TAB_MSG = 0
} IntoLoginType;
@class LoginViewController;
@protocol LoginViewControllerDelegate <NSObject>
- (void)loginSucBack:(LoginViewController *)loginVc;
@end

@interface LoginViewController : UIViewController<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource,ExtendsViewDelegate,AsyncHttpRequestDelegate>
{
//    UITableView *lTableView;
    UITextField *tf_name;
    UITextField *tf_password;
    UIButton    *btLogin;
    UIButton    *btReset;
    UIButton    *btRmb;
    UIButton    *btExtend;
    int         rows;
    BOOL        isExtends;
    Person      *person;
    
    UITableView *tTableView;
}
@property (nonatomic)IntoLoginType tType;
@property(nonatomic,weak)id<LoginViewControllerDelegate> delegate;
-(id)initWithType:(IntoLoginType)type;
-(void)accTapped:(id)sender;
@end
