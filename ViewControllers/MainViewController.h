//
//  MainViewController.h
//  hybird
//
//  Created by Zhang Hang on 4/18/13.
//  Copyright (c) 2013 Zhang Hang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<UIWebViewDelegate>

@property (nonatomic,strong) UIButton* theButton;

@property (nonatomic,strong) UIWebView* contentwebView;

@end
