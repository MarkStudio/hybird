//
//  MainViewController.m
//  hybird
//
//  Created by Zhang Hang on 4/18/13.
//  Copyright (c) 2013 Zhang Hang. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.theButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
    self.theButton.frame = CGRectMake(20, 10, 100, 80);
    
    [self.theButton addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self.theButton setTitle:@" 金黄" forState:UIControlStateNormal];
    
 
    
    self.contentwebView =[[UIWebView alloc] initWithFrame:CGRectMake(0, 0,
                                                                     self.view.frame.size.width,self.view.frame.size.height)];
    
//    NSString* targetUrl = @"http://192.168.1.101/~ZH";
    
    [self.contentwebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]
                                                                          pathForResource:@"index" ofType:@"html"]isDirectory:NO]]];
    
//    [self.contentwebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:targetUrl]]];
    
    self.contentwebView.delegate = self;
    
    [self.view addSubview:self.contentwebView];
    
    [self.view addSubview:self.theButton];
}

- (void)runwithJavascript:(NSString*) jsCode
{
    [self.contentwebView stringByEvaluatingJavaScriptFromString:jsCode];
}

- (void)buttonPressed
{
    [self updateIndicator:@"yellow"];
}


-(void)updateIndicator:(NSString*) cssColor
{
    [self runwithJavascript:[NSString stringWithFormat:@"updateIndicatorStatue('%@')",cssColor]];
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString* url = [[request URL] absoluteString];
    NSLog(@"%@",url);
    
    //在 js 端 RaiseNativeEvent 中定义的特殊前缀，用识别来发来的消息
    if([url hasPrefix:@"nativeevent"]){
        if([url rangeOfString:@"invalid"].location != NSNotFound){
            [self updateIndicator:@"red"];
        }else{
            [self updateIndicator:@"green"];
        }
    }
    
    
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
