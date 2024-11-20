//
//  ViewController.m
//  imperative app
//
//  Created by Kosy on 20/11/2024.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;

@property (weak, nonatomic) IBOutlet UIButton *startStopBtn;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSDate *startTime;


@property (assign, nonatomic) BOOL isRunning;

@property (strong, nonatomic) NSDictionary<NSString *, NSNumber *> *currentTime;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isRunning = NO;
    NSLog(@"Running");
    self.currentTime = @{@"ms": @0,@"secs": @0,@"mins": @0};
//    self.timeLabel.text = @"00:00:00";
    // Do any additional setup after loading the view.
}

- (IBAction)toggleButtonPressed:(id)sender {
    if (self.isRunning) {
        [self stopStopwatch];
    } else {
        [self startStopwatch];
    }
}

- (IBAction)tiler:(id)sender {
    
}

- (void)startStopwatch {
    self.isRunning = YES;
    [self.startStopBtn setTitle:@"Stop" forState:UIControlStateNormal];
    self.startTime = [NSDate date];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.0001
                                                  target:self
                                                selector:@selector(updateTimeLabel)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void)stopStopwatch {
    self.isRunning = NO;
    [self.startStopBtn setTitle:@"Start" forState:UIControlStateNormal];
    [self.timer invalidate];
    self.timer = nil;
}

- (void)updateTimeLabel {
    NSInteger previousMs = [[self.currentTime valueForKey:@"ms"] integerValue];
    NSInteger previousSecs = [[self.currentTime valueForKey:@"secs"] integerValue];
    NSInteger previousMins = [[self.currentTime valueForKey:@"mins"] integerValue];
    previousMs = previousMs + 1;
    if(previousMs > 999) {
        previousMs = 0;
        previousSecs = previousSecs + 1;
    }
    if(previousSecs > 59) {
        previousSecs = 0;
        previousMins = previousMins + 1;
    }
    
    self.currentTime = @{
        @"ms": [NSNumber  numberWithInt:previousMs],
        @"secs": [NSNumber numberWithInt:previousSecs],
        @"mins": [NSNumber  numberWithInt:previousMins]
    };
    
    NSInteger miliSecondsValue = previousMs / 100;
    
    self.timeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)previousMins, (long)previousSecs, (long)miliSecondsValue];
}
@end
