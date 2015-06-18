//
//  UIBarButtonItem+CustomButton.h
//
//

#import <UIKit/UIKit.h>

//设置导航条上得按钮的类别

@interface UIBarButtonItem (CustomButton)

+ (UIBarButtonItem *)customBarButtonItemWithTitle:(NSString *)title
                                           target:(id)target
                                           action:(SEL)action;
+ (UIBarButtonItem *)customBarButtonItemWithImageName:(NSString *)imageName
                                               target:(id)target
                                               action:(SEL)action;
//
+ (UIBarButtonItem *)customBarButtonItemWithTitle:(NSString *)title
                              backgroundImageName:(NSString *)backgroundImageName
                                           target:(id)target
                                           action:(SEL)action;
//
+ (UIBarButtonItem *)customBarButtonItemWithImageName:(NSString *)imageName
                                  backgroundImageName:(NSString *)backgroundImageName
                                               target:(id)target
                                               action:(SEL)action;

@end
