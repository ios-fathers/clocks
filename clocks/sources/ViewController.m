//
//  ViewController.m
//  clocks
//
//  Created by iOS Fathers on 10.12.2021.
//

#import "ViewController.h"
#import "ClockView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet ClockView *clockView;
@property (weak, nonatomic) IBOutlet UILabel *clockLabel;
@property (strong, nonatomic) NSTimer *timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureAppearence];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self update:NO];
    [self startTimer];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self stopTimer];
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [self configureAppearence];
}

- (void)configureAppearence {
    if (@available(iOS 12, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
            self.clockView.fillColor = [UIColor whiteColor];
            self.clockView.strokeColor = [UIColor darkGrayColor];
        } else {
            self.clockView.fillColor = [UIColor darkGrayColor];
            self.clockView.strokeColor = [UIColor lightGrayColor];
        }
    }
}

- (void)timerHandler:(NSTimer *)timer {
    [self update:YES];
}

- (void)update:(BOOL)animated {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* dateComponents = [calendar components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:[NSDate date]];
    [self.clockView setHour:dateComponents.hour minute:dateComponents.minute seconds:dateComponents.second animated:animated];
    self.clockLabel.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld", dateComponents.hour, dateComponents.minute, dateComponents.second];
}

- (void)startTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerHandler:) userInfo:NULL repeats:YES];
}

- (void)stopTimer {
    [self.timer invalidate];
    self.timer = NULL;
}

- (IBAction)modeButtonPressed:(id)sender {
    if (@available(iOS 13, *)) {
        self.overrideUserInterfaceStyle = self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight ? UIUserInterfaceStyleDark : UIUserInterfaceStyleLight;
    }
}

@end
