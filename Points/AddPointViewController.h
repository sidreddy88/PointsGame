//
//  AddPointViewController.h
//  Points
//
//  Created by Matthew Graham on 2/15/14.
//  Copyright (c) 2014 Matthew Graham. All rights reserved.
//

#import "ViewController.h"
#import "Parse/Parse.h"

@interface AddPointViewController : ViewController <UITextViewDelegate>
@property NSString *friendName;
@property NSString *toUserObjectID;
@property NSString *fromUserObjectID;
@property NSString *groupID;
@property PFObject *group;
@property UIImageView *profileImage;

@end
