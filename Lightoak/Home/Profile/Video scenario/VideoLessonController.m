//
//  VideoLessonController.m
//  OpenTokBasic
//
//  Created by Администратор on 3/31/13.
//
//

#import "VideoLessonController.h"

#import "UIToolbarVideoView.h"
#import "UIProgressLessonView.h"

@interface VideoLessonController ()
{
    OTSession * _session;
    OTPublisher * _publisher;
    OTSubscriber * _subscriber;
    NSString *kSessionId;
    NSString *kToken;
}
@property (strong, nonatomic) UIToolbarVideoView *toolbar;
@property (strong, nonatomic) UIProgressLessonView *progressLessonView;
@end

@implementation VideoLessonController

static double widgetHeight = 240;
static double widgetWidth = 320;
static NSString* const kApiKey = @"22580892";
static bool subscribeToSelf = NO; // Change to NO if you want to subscribe streams other than your own


@synthesize toolbar, progressLessonView;

- (BOOL) shouldAutorotate
{
    return YES;
}

- (NSUInteger) supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];
    
    CGSize display = self.view.frame.size;
    

    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGFloat screenScale = [[UIScreen mainScreen] scale];
    
    CGSize screenSize = CGSizeMake(screenBounds.size.width * screenScale, screenBounds.size.height* screenScale);
    
    _publisher = [[OTPublisher alloc] initWithDelegate:self];
    [_publisher setName:[[UIDevice currentDevice] name]];
    if(screenSize.height > 1135.)
    {
        //[_publisher.view setFrame:CGRectMake(71.0, 0.0, 426, 320)];
       [_publisher.view setFrame:CGRectMake(0., -63., 568., 426.)];
//        [_subscriber.view setFrame:CGRectMake(0., -63., 568., 426.)];

        toolbar = [[UIToolbarVideoView alloc] initWithFrame:CGRectMake(0.0, 256., 568, 60)];
    }
    else if(screenSize.height < 961.)
    {
        [_publisher.view setFrame:CGRectMake(0., -20., 480, 360)];
//        [_subscriber.view setFrame:CGRectMake(0., -20., 480, 360)];

        toolbar = [[UIToolbarVideoView alloc] initWithFrame:CGRectMake(0.0, 256., 480., 60.)];
    }
    [self.view addSubview:_publisher.view];
    
    
    
    [self.view addSubview:toolbar];
    
    [toolbar.audioPub addTarget:self action:@selector(ajustAudioPublisher) forControlEvents:UIControlEventTouchUpInside];
    [toolbar.toChat addTarget:self action:@selector(toChat) forControlEvents:UIControlEventTouchUpInside];
    [toolbar.videoPub addTarget:self action:@selector(ajustVideoPublisher) forControlEvents:UIControlEventTouchUpInside];
    [toolbar.pauseLesson addTarget:self action:@selector(ajustTimeLessons) forControlEvents:UIControlEventTouchUpInside];
    
    progressLessonView = [[UIProgressLessonView alloc] initWithFrame:CGRectMake(0, toolbar.frame.origin.y + toolbar.frame.size.height-3., display.height, 5.) timeLessson:100];
    [self.view addSubview:progressLessonView];
    

    
    [self createSession];
    [self doConnect];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) ajustTimeLessons
{
    if(toolbar.pauseLesson.exclusiveTouch == NO)
    {
        progressLessonView.pause = YES;
        toolbar.pauseLesson.exclusiveTouch = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ajustTime" object:progressLessonView];
    }
    else
    {
        progressLessonView.pause = NO;
        toolbar.pauseLesson.exclusiveTouch = NO;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ajustTime" object:progressLessonView];
    }
}

- (void) ajustVideoPublisher
{
    if(toolbar.videoPub.exclusiveTouch == NO)
    {
        _publisher.publishVideo = NO;
        toolbar.videoPub.exclusiveTouch = YES;
    }
    else
    {
        _publisher.publishVideo = YES;
        toolbar.videoPub.exclusiveTouch = NO;
    }
}
- (void) toChat
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:NO];

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) ajustAudioPublisher
{
    if(toolbar.audioPub.exclusiveTouch == NO)
    {
        _publisher.publishAudio = NO;
        toolbar.audioPub.exclusiveTouch = YES;
    }
    else
    {
        _publisher.publishAudio = YES;
        toolbar.audioPub.exclusiveTouch = NO;
    }
}

- (void) createSession
{
    NSData *jsonResponse = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://lightoak.herokuapp.com//rooms/room.json?id=1"]];
    if(!jsonResponse)
    {
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:@"Отсутствует подключение к интернету" delegate:self cancelButtonTitle:@"ок" otherButtonTitles: nil];
        [error show];
        return;
    }
    NSArray *response = [NSJSONSerialization JSONObjectWithData:jsonResponse options:0 error: nil];
    
    kSessionId = [[[response valueForKey:@"post"] valueForKey:@"room_id"] objectAtIndex:0];
    kToken = [[response valueForKey:@"token"] objectAtIndex:0];
}

- (void)updateSubscriber
{
    for (NSString* streamId in _session.streams) {
        OTStream* stream = [_session.streams valueForKey:streamId];
        if (stream.connection.connectionId != _session.connection.connectionId) {
            _subscriber = [[OTSubscriber alloc] initWithStream:stream delegate:self];
            break;
        }
    }
}
/*- (BOOL) shouldAutorotate
{
    //Если прямо
    if([[UIDevice currentDevice] orientation] == 1)
    {
        //self.interfaceOrientation

    }
    //Если повернут влево
    else if([[UIDevice currentDevice] orientation] == 3)
    {
        [UIView animateWithDuration:0.4 animations:^{
            self.view.transform = CGAffineTransformMakeRotation(M_PI/2);
        }];
    }
    return YES;
}*/


#pragma mark - OpenTok methods

- (void)doConnect
{
    //////////////Временно
    kSessionId = @"2_MX4yMjU4MDg5Mn4xMjcuMC4wLjF-VHVlIEFwciAwOSAwMjoxOTo0MiBQRFQgMjAxM34wLjIzOTU2MDEzfg";
    
    _session = [[OTSession alloc] initWithSessionId:kSessionId
                                           delegate:self];
    
    kToken = @"T1==cGFydG5lcl9pZD0yMjU4MDg5MiZzZGtfdmVyc2lvbj10YnJ1YnktdGJyYi12MC45MS4yMDExLTAyLTE3JnNpZz0wNjUyOTQyOGI5YjRkYTUwYjlhYzYxNzk0OTY1ODYyMTg1YWI2MjcyOnJvbGU9cHVibGlzaGVyJnNlc3Npb25faWQ9Ml9NWDR5TWpVNE1EZzVNbjR4TWpjdU1DNHdMakYtVkhWbElFRndjaUF3T1NBd01qb3hPVG8wTWlCUVJGUWdNakF4TTM0d0xqSXpPVFUyTURFemZnJmNyZWF0ZV90aW1lPTEzNjU0OTkxOTkmbm9uY2U9MC41ODAwMDI5NTQ3MzgwNDQ4JmV4cGlyZV90aW1lPTEzNjYxMDQwMjgmY29ubmVjdGlvbl9kYXRhPQ==";
     
    [_session connectWithApiKey:kApiKey token:kToken];
}

- (void)doPublish
{
    [_session publish:_publisher];
}

- (void)sessionDidConnect:(OTSession*)session
{
    NSLog(@"sessionDidConnect (%@)", session.sessionId);
    [self doPublish];
}

- (void)sessionDidDisconnect:(OTSession*)session
{
    NSString* alertMessage = [NSString stringWithFormat:@"Session disconnected: (%@)", session.sessionId];
    NSLog(@"sessionDidDisconnect (%@)", alertMessage);
    //[self showAlert:alertMessage];
}


- (void)session:(OTSession*)mySession didReceiveStream:(OTStream*)stream
{
    NSLog(@"session didReceiveStream (%@)", stream.streamId);
    
    // See the declaration of subscribeToSelf above.
    if ( (subscribeToSelf && [stream.connection.connectionId isEqualToString: _session.connection.connectionId])
        ||
        (!subscribeToSelf && ![stream.connection.connectionId isEqualToString: _session.connection.connectionId])
        ) {
        if (!_subscriber) {
            _subscriber = [[OTSubscriber alloc] initWithStream:stream delegate:self];
        }
    }
}

- (void)session:(OTSession*)session didDropStream:(OTStream*)stream{
    NSLog(@"session didDropStream (%@)", stream.streamId);
    NSLog(@"_subscriber.stream.streamId (%@)", _subscriber.stream.streamId);
    if (!subscribeToSelf
        && _subscriber
        && [_subscriber.stream.streamId isEqualToString: stream.streamId])
    {
        _subscriber = nil;
        [self updateSubscriber];
    }
}

- (void)subscriberDidConnectToStream:(OTSubscriber*)subscriber
{
    NSLog(@"subscriberDidConnectToStream (%@)", subscriber.stream.connection.connectionId);
    [subscriber.view setFrame:CGRectMake(0, self.progressLessonView.frame.size.height, self.view.frame.size.width, widgetHeight)];
    [self.view addSubview:subscriber.view];
}

- (void)publisher:(OTPublisher*)publisher didFailWithError:(OTError*) error
{
    NSLog(@"publisher didFailWithError %@", error);
    //[self showAlert:[NSString stringWithFormat:@"There was an error publishing."]];
}

- (void)subscriber:(OTSubscriber*)subscriber didFailWithError:(OTError*)error
{
    NSLog(@"subscriber %@ didFailWithError %@", subscriber.stream.streamId, error);
    //[self showAlert:[NSString stringWithFormat:@"There was an error subscribing to stream %@", subscriber.stream.streamId]];
}

- (void)session:(OTSession*)session didFailWithError:(OTError*)error
{
    NSLog(@"sessionDidFail");
    //[self showAlert:[NSString stringWithFormat:@"There was an error connecting to session %@", session.sessionId]];
}


- (void)showAlert:(NSString*)string {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message from video session"
                                                    message:string
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}
@end
