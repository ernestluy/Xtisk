

#import <UIKit/UIKit.h>
#import "ExtendsView.h"
#import "Person.h"
@interface LoginViewController : UITableViewController<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource,ExtendsViewDelegate>
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
}
//@property (strong,nonatomic)UITableView *lTableView;
-(void)accTapped:(id)sender;
@end
