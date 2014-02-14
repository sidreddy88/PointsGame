//
//  FriendsViewController.m
//  Points
//
//  Created by Matthew Graham on 2/14/14.
//  Copyright (c) 2014 Matthew Graham. All rights reserved.
//

#import "FriendsViewController.h"

@interface FriendsViewController () <UITableViewDataSource, UITableViewDelegate>
{
    PFObject *group;
    NSMutableArray *friends;
    __weak IBOutlet UITableView *friendsTableView;
    
}

@end

@implementation FriendsViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    friendsTableView = [UITableView new];
    friendsTableView.delegate = self;
    friendsTableView.dataSource = self;

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    PFQuery *query = [PFQuery queryWithClassName:@"Group"];
    group = [PFObject objectWithClassName:@"Group"];
    [query whereKey:@"objectId" equalTo:self.groupID];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
    {
        group = [objects firstObject];
        self.title = [group objectForKey:@"name"];
        PFRelation *relation = [group relationForKey:@"members"];
        [[relation query] findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
        {
            if (!error)
            {
                friends = [NSMutableArray new];
                for (PFObject *object in objects)
                {
                    [friends addObject:[object objectForKey:@"username"]];
                    NSLog(@"Friends are %@", friends);
                    [friendsTableView reloadData];
                }
            }
            else
            {
                NSLog(@"Error: %@", error);
            }
        }];
    }];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendDetailCell"];
    cell.textLabel.text = [friends objectAtIndex:indexPath.row];
    NSLog(@"Cell friends are %@", [friends objectAtIndex:indexPath.row]);
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return friends.count;
}

@end
