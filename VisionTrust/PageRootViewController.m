//
//  PageRootViewController.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/29/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "PageRootViewController.h"
#import "Child.h"

@interface PageRootViewController ()
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *viewControllers;
@property NSUInteger currentController;
@end

@implementation PageRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSUInteger numberPages = [self.childList count];
    
    // view controllers are created lazily
    // in the meantime, load the array with placeholders which will be replaced on demand
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0; i < numberPages; i++)
    {
		[controllers addObject:[NSNull null]];
    }
    self.viewControllers = controllers;
    
    // a page is the width of the scroll view
    self.scrollView.contentSize =
    CGSizeMake(CGRectGetWidth(self.scrollView.frame) * numberPages, self.scrollView.frame.size.height - 50);
    
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.scrollsToTop = NO;
    self.scrollView.delegate = self;
    
    // pages are created on demand
    // load the visible page
    // load the page on either side to avoid flashes when the user starts scrolling
    
    for (int i = 0; i < self.selectedChildIndex + 1; i++) {
        [self loadScrollViewFromIndex:i];
    }
}

- (void)loadScrollViewFromIndex:(NSUInteger)index
{
    if (index >= [self.childList count])
        return;
    
    // replace the placeholder if necessary
    PersonalViewController *controller = [self.viewControllers objectAtIndex:index];
    if ((NSNull *)controller == [NSNull null])
    {
        controller = [[PersonalViewController alloc] initWithChild:[self.childList objectAtIndex:index]];
        [self.viewControllers replaceObjectAtIndex:index withObject:controller];
    }
    
    // add the controller's view to the scroll view
    if (controller.view.superview == nil)
    {
        CGRect frame = self.scrollView.frame;
        frame.origin.x = CGRectGetWidth(frame) * index;
        frame.origin.y = 0;
        controller.view.frame = frame;
        
        [self addChildViewController:controller];
        [self.scrollView addSubview:controller.view];
        [controller didMoveToParentViewController:self];
        [self.scrollView scrollRectToVisible:frame animated:YES];
    }
}

// at the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = CGRectGetWidth(self.scrollView.frame);
    NSUInteger index = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.currentController = index;
    
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewFromIndex:index - 1];
    [self loadScrollViewFromIndex:index];
    [self loadScrollViewFromIndex:index + 1];
    
    // a possible optimization would be to unload the views+controllers which are no longer visible
}

@end
