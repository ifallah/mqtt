/*
 Licensed Materials - Property of IBM
 
 © Copyright IBM Corporation 2014. All Rights Reserved.
 
 This licensed material is sample code intended to aid the licensee in the development of software for the Apple iOS and OS X platforms . This sample code is  provided only for education purposes and any use of this sample code to develop software requires the licensee obtain and comply with the license terms for the appropriate Apple SDK (Developer or Enterprise edition).  Subject to the previous conditions, the licensee may use, copy, and modify the sample code in any form without payment to IBM for the purposes of developing software for the Apple iOS and OS X platforms.
 
 Notwithstanding anything to the contrary, IBM PROVIDES THE SAMPLE SOURCE CODE ON AN "AS IS" BASIS AND IBM DISCLAIMS ALL WARRANTIES, EXPRESS OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, ANY IMPLIED WARRANTIES OR CONDITIONS OF MERCHANTABILITY, SATISFACTORY QUALITY, FITNESS FOR A PARTICULAR PURPOSE, TITLE, AND ANY WARRANTY OR CONDITION OF NON-INFRINGEMENT. IBM SHALL NOT BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY OR ECONOMIC CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR OPERATION OF THE SAMPLE SOURCE CODE. IBM SHALL NOT BE LIABLE FOR LOSS OF, OR DAMAGE TO, DATA, OR FOR LOST PROFITS, BUSINESS REVENUE, GOODWILL, OR ANTICIPATED SAVINGS. IBM HAS NO OBLIGATION TO PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS OR MODIFICATIONS TO THE SAMPLE SOURCE CODE.
 */

#import "start.h"
#import "Messenger.h"
#import "AppDelegate.h"
#include <stdlib.h>

@implementation start

+ (NSString*) uniqueId {
    return [NSString stringWithFormat: @"iphone.%d", arc4random_uniform(10000)];
}

+ (NSArray*) parseCommaList:(NSString*)field {
    return [field componentsSeparatedByString:@","];
}

- (IBAction)connectPressed:(id)sender {
    NSLog(@"%s:%d - %@", __func__, __LINE__, sender);

    if ([[[self connectButton] currentTitle]  isEqual:@"Connect"]) {
        NSString * servmqtt = @"maher.noip.me";
        NSString * portmqtt = @"1883";
        // Connect button text will be "Disconnect" while the client is connected.
        NSArray *servers = [start parseCommaList:servmqtt];
                            //self.serverInput.text];
        NSArray *ports = [start parseCommaList:portmqtt];
                          //self.portInput.text];
    
        // Only generate a new unique clientID if this client doesn't already have one.
        NSString *clientID = [[Messenger sharedMessenger] clientID];
        if (clientID == NULL) {
            clientID = [start uniqueId];
            [[Messenger sharedMessenger] setClientID:clientID];
        }
        [[Messenger sharedMessenger] connectWithHosts:servers ports:ports clientId:clientID cleanSession:self.cleanSession.isOn];
    
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        [appDelegate switchToPublish];
    } else {
        [[Messenger sharedMessenger] disconnectWithTimeout:5];
    }
}

- (IBAction)cleanSessionChanged:(id)sender {
    NSLog(@"%s:%d - %@", __func__, __LINE__, sender);
    NSLog(@"cleanSession changed to: %d", self.cleanSession.isOn);
}

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
    self.AClb.text= @"Witing ... ";
    
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.connectView = self;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(NotiCome) name:@"NotiCome" object:nil];
    
    
   // [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(offe) name:@"offe" object:nil];
    
    
   // NSLog(@"%s:%d", __func__, __LINE__);
    
    NSString * servmqtt = @"maher.noip.me";
    NSString * portmqtt = @"1883";
    // Connect button text will be "Disconnect" while the client is connected.
    NSArray *servers = [start parseCommaList:servmqtt];
    //self.serverInput.text];
    NSArray *ports = [start parseCommaList:portmqtt];
    //self.portInput.text];
    
    // Only generate a new unique clientID if this client doesn't already have one.
    NSString *clientID = [[Messenger sharedMessenger] clientID];
    if (clientID == NULL) {
        clientID = [start uniqueId];
        [[Messenger sharedMessenger] setClientID:clientID];
    }
    [[Messenger sharedMessenger] connectWithHosts:servers ports:ports clientId:clientID cleanSession:self.cleanSession.isOn];
    
    //AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
  //  [appDelegate switchToPublish];

    //[self sendetomqtt];
    [NSTimer scheduledTimerWithTimeInterval:1.00 target:self selector:@selector(sendetomqtt) userInfo:nil repeats:NO];
       //[NSTimer scheduledTimerWithTimeInterval:7.00 target:self selector:@selector(offe) userInfo:nil repeats:NO];
}

-(void)offe{
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        // code here
//    
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Title" message:@"Alert Message" preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *defautAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
//            //enter code here
//        }];
//        [alert addAction:defautAction];
//        //Present action where needed
//        [self presentViewController:alert animated:YES completion:nil];
//    });
//    NSLog(@"ofee recived !!");
//    
//    
    
    

    
    
    

    
}
-(void)sendetomqtt{
    
    [self smqtt:@"aim iphone"];
    
    
}

-(void)smqtt:(NSString*)Msg{
    
    NSString* topic = @"AC";
   
    // self.AClb.text= @"send it ";
    //initWithBytes:msg.payload length:msg.payloadLength encoding:NSUTF8StringEncoding];
    
    [[Messenger sharedMessenger] publish:topic payload:Msg qos:0 retained:0];
    
    // NSString *topic = self.topicInput.text;
    
    [[Messenger sharedMessenger] subscribe:topic qos:0];

}



-(void)NotiCome{
    
  
    
        
    NSLog(@" Mqtt MSG=-%@-=",Resev);
    

    
    if ([Resev isEqualToString:@"offAC"]) {
        
        [self camesonext];
        
        
        
    }else {
        
        
        NSLog(@"-cant work with this command-");
    }
    
}
-(void)camesonext{

dispatch_async(dispatch_get_main_queue(), ^{
    self.AClb.text= @"AC its online  ";
    [self.ACswitch setOn:YES animated:YES];
    
 
});
    
    
    
}


- (IBAction)newaction:(id)sender {
    
    [self smqtt:@"AreYouOnLineAC"];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//    NSLog(@"textFieldShouldBeginEditing");
//    textField.backgroundColor = [UIColor colorWithRed:220.0f/255.0f green:220.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
//    return YES;
//}
//- (void)textFieldDidBeginEditing:(UITextField *)textField{
//    NSLog(@"textFieldDidBeginEditing");
//}
//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
//    NSLog(@"textFieldShouldEndEditing");
//    textField.backgroundColor = [UIColor whiteColor];
//    return YES;
//}
//- (void)textFieldDidEndEditing:(UITextField *)textField{
//    NSLog(@"textFieldDidEndEditing");
//}
//- (BOOL)textFieldShouldClear:(UITextField *)textField{
//    NSLog(@"textFieldShouldClear:");
//    return YES;
//}
//- (BOOL)textFieldShouldReturn:(UITextField *)textField{
//    NSLog(@"textFieldShouldReturn:");
//    if (textField.tag == 1) {
//        UITextField *passwordTextField = (UITextField *)[self.view viewWithTag:2];
//        [passwordTextField becomeFirstResponder];
//    }
//    else {
//        [textField resignFirstResponder];
//    }
//    return YES;
//}




















































































- (IBAction)ACOnOff:(id)sender {
    if (_ACswitch.on) {
        [self smqtt:@"mkACOn"];
    }else {
        
        [self smqtt:@"mkACOff"];
        
    }
    
    
}

























@end
