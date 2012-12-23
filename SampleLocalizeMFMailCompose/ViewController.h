//
//  ViewController.h
//  SampleLocalizeMFMailCompose
//
//  Created by  on 11/12/18.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h> 
#import <MessageUI/MFMailComposeViewController.h>

@interface ViewController : UIViewController <MFMailComposeViewControllerDelegate> {
    
}

/* メソッド */

- (void)btnAction:(UIButton*)sender;


@end
