

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



- (IBAction)cleanSessionChanged:(id)sender {
  
    NSLog(@"cleanSession changed to: %d", self.cleanSession.isOn);
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.AClb.text= @"Witing ... ";
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(NotiCome) name:@"NotiCome" object:nil];
    
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
    
   
   
    [NSTimer scheduledTimerWithTimeInterval:1.00 target:self selector:@selector(sendetomqtt) userInfo:nil repeats:NO];
   
}


-(void)sendetomqtt{
    
    [self smqtt:@"aim iphone"];
    
    
}

-(void)smqtt:(NSString*)Msg{
    
    NSString* topic = @"AC";
    
    [[Messenger sharedMessenger] publish:topic payload:Msg qos:0 retained:0];
    
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
- (IBAction)ACOnOff:(id)sender {
    /*
    if (self.ACswitch.isOn) {
        [self smqtt:@"mkACOn"];
        [self.ACswitch setOn:NO animated:YES];
    }else {
         [self.ACswitch setOn:YES animated:YES];
        [self smqtt:@"mkACOff"];
        
    }
    */
    
}

























@end
