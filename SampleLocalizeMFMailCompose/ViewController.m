//
//  ViewController.m
//  SampleLocalizeMFMailCompose
//
//  Created by  on 11/12/18.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // ボタン
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(0.0, 0.0, 180.0, 50.0);
    btn.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
    [btn setTitle:@"メール送信" forState:UIControlStateNormal];  // 有効時
    [btn addTarget:self action:@selector(btnAction:)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


/* ============================================================================== */
#pragma mark - Button Action
/* ============================================================================== */
- (void)btnAction:(UIButton*)sender
{
    /* メール送信準備 */
    
    MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
    mailPicker.mailComposeDelegate = self;
    mailPicker.modalPresentationStyle = UIModalPresentationFullScreen;  // 画面を覆う
    
    // メールアカウントが存在する場合
    if ([MFMailComposeViewController canSendMail])
    {        
        // メール送信先を設定
        NSString *emailToStr = @"aaa@aa.aa";
        if ([emailToStr length]){
            NSArray *toRecipients = [NSArray arrayWithObject:emailToStr];       // To
            [mailPicker setToRecipients:toRecipients];
        }
        
        NSString *emailCcStr = @"bbb@bb.bb";
        if ([emailCcStr length]){
            NSArray *ccRecipients = [NSArray arrayWithObjects:emailCcStr, nil]; // Cc
            [mailPicker setCcRecipients:ccRecipients];
        }
        
        NSString *emailBccStr = @"ccc@cc.cc";
        if ([emailBccStr length]){
            NSArray *bccRecipients = [NSArray arrayWithObject:emailBccStr];     // Bcc
            [mailPicker setBccRecipients:bccRecipients];
        }
        
        // 件名を設定
        [mailPicker setSubject:@"title"];
        
        // 本文を設定
        [mailPicker setMessageBody:@"body" isHTML:NO];
        
        // 添付ファイルを設定
        //NSData* fileData = [NSData dataWithContentsOfFile:filePath];
        //[mailPicker addAttachmentData:fileData mimeType:@"text/csv" fileName:fileName];
        
        // ツールバーの色を変更
        [[mailPicker navigationBar] setTintColor:[UIColor blackColor]];     // black
        
        // メール送信用のモーダルビューを表示
        if (mailPicker != nil) {
            [self presentModalViewController:mailPicker animated:TRUE];
        }
    }
}


/* ============================================================================== */
#pragma mark - MessageUI Delegate
/* ============================================================================== */
// メール送信処理完了時のイベント
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result) {
        case MFMailComposeResultCancelled:  // キャンセル
            break;
        case MFMailComposeResultSaved:      // 保存
            break;
        case MFMailComposeResultSent:       // 送信成功
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil 
                                                            message:@"送信に成功しました"
                                                           delegate:nil 
                                                  cancelButtonTitle:nil 
                                                  otherButtonTitles:@"OK", nil];
            [alert show];
            break;
        }
        case MFMailComposeResultFailed:     // 送信に失敗した場合
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil 
                                                            message:@"送信に失敗しました"
                                                           delegate:nil 
                                                  cancelButtonTitle:nil 
                                                  otherButtonTitles:@"OK", nil];
            [alert show];
            break;
        }
        default:
            break;
    }
    
    // メール送信画面を閉じる
    [self dismissModalViewControllerAnimated:YES];
}


@end
