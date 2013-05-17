//
//  VideoLessonController.h
//  OpenTokBasic
//
//  Created by Администратор on 3/31/13.
//
//

#import <UIKit/UIKit.h>
#import <OpenTok/Opentok.h>

@interface VideoLessonController : UIViewController <OTSessionDelegate, OTSubscriberDelegate, OTPublisherDelegate>

- (void)doConnect;
- (void)doDisconnect;
- (void)doPublish;
- (void)doUnpublish;
- (void)createSession;

@end
