

#import <UIKit/UIKit.h>

@interface CustomMenuTutorialController : UIViewController<UIScrollViewDelegate>
{
    UIScrollView *tutorialView;
    UIPageControl *pageControl;
    
    int  iTutorialNum;
}
-(void)setItutorialNum:(int)num;
-(void)initLayout;
@end
