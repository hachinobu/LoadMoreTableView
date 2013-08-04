//
//  ListViewController.m
//  LoadMoreTableViewTest
//
//  Created by hachinobu on 2013/08/02.
//  Copyright (c) 2013年 hachinobu. All rights reserved.
//

#import "ListViewController.h"

#define ONCE_READ_COUNT 20

@interface ListViewController ()

@property (strong, nonatomic) NSArray *contents;
@property (readwrite) NSInteger page;
@property (strong, nonatomic) UIActivityIndicatorView *indicator;

@end

@implementation ListViewController

int total = 0;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.title = @"平家物語";
    self.contents = [self createContents];
    total = [_contents count];
    _page = 1;
    
    //インディケーター
    _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.indicator setColor:[UIColor darkGrayColor]];
    [self.indicator setHidesWhenStopped:YES];
    [self.indicator stopAnimating];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 表示コンテンツ生成
- (NSArray *)createContents
{
    
    NSMutableArray *data = [NSMutableArray array];
    for (int i = 0; i < 20; i++) {
        [data addObject:@"祗園精舎の鐘の声、"];
        [data addObject:@"諸行無常の響きあり。"];
        [data addObject:@"娑羅双樹の花の色、"];
        [data addObject:@"盛者必衰の理をあらは（わ）す。"];
        [data addObject:@"おごれる人も久しからず、"];
        [data addObject:@"唯春の夜の夢のごとし。"];
        [data addObject:@"たけき者も遂にはほろびぬ、"];
        [data addObject:@"偏に風の前の塵に同じ。"];
    }
    
    return [data copy];
    
}

#pragma mark - 表示セルの一番下まできたら次のONCE_READ_COUNT件数取得
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if(self.tableView.contentOffset.y >= (self.tableView.contentSize.height - self.tableView.bounds.size.height))
	{
        
		if([_indicator isAnimating]) {
			return;
		}
		
		
        if (total > (_page*ONCE_READ_COUNT)) {
            [self startIndicator];
            [self performSelector:@selector(reloadMoreData) withObject:nil afterDelay:0.1f];
        }
		
    }
}


- (void)reloadMoreData
{
    _page++;
    [self.tableView reloadData];
    [self endIndicator];
}

- (void)startIndicator
{
    [_indicator startAnimating];
	CGRect footerFrame = self.tableView.tableFooterView.frame;
	footerFrame.size.height += 10.0f;
	
    [_indicator setFrame:footerFrame];
    [self.tableView setTableFooterView:_indicator];
}


- (void)endIndicator
{
    [_indicator stopAnimating];
    [_indicator removeFromSuperview];
    [self.tableView setTableFooterView:nil];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _page*ONCE_READ_COUNT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    [[cell textLabel] setText:[_contents objectAtIndex:indexPath.row]];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    [[self tableView] deselectRowAtIndexPath:indexPath animated:YES];
}

@end
