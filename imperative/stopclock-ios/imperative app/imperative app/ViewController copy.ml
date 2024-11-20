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
@property (strong, nonatomic) NSDate *currentTime;
@property (assign, nonatomic) BOOL isRunning;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isRunning = NO;
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

- (void)startStopwatch {
    self.isRunning = YES;
    [self.startStopBtn setTitle:@"Stop" forState:UIControlStateNormal];
    self.startTime = [NSDate date];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
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
    NSTimeInterval elapsedTime = [[NSDate date] timeIntervalSinceDate:self.startTime];
    NSInteger hours = (NSInteger)(elapsedTime / 3600);
    NSInteger minutes = ((NSInteger)(elapsedTime / 60)) % 60;
    NSInteger seconds = (NSInteger)(elapsedTime)  % 60;
    self.timeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)hours, (long)minutes, (long)seconds];
}
@end
