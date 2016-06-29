//
//  ArticleTableViewController.swift
//  testDanielTorres_Momentous
//
//  Created by Daniel Torres on 6/26/16.
//  Copyright © 2016 Danieltorres. All rights reserved.
//

import UIKit
import CoreData


class ArticleTableViewController: CoreDataTableViewController {

    @IBOutlet weak var refreshButton: UIBarButtonItem!{
        didSet {
            let icon = UIImage(named: "Refresh")
            let iconSize = CGRect(origin: CGPointZero, size: icon!.size)
            let iconButton = UIButton(frame: iconSize)
            iconButton.setBackgroundImage(icon, forState: .Normal)
            refreshButton.customView = iconButton
            
            iconButton.addTarget(self, action: #selector(ArticleTableViewController.refresh), forControlEvents: .TouchUpInside)
        }
    }
    
    var resultSearchController = UISearchController(searchResultsController: nil)
    var fontSizeTitle : Float = 0.0
    var fontSizeSubTitle : Float = 0.0
    let SliderValueKeyTitle = "Slider Value Key for Font Title"
    let SliderValueKeySubTitle = "Slider Value Key for Font SubTitle"
    let orderByNameKey = "Order by name"
    var orderByName = false
    
    override func viewWillAppear(animated: Bool) {
        fontSizeTitle = NSUserDefaults.standardUserDefaults().floatForKey(SliderValueKeyTitle)
        fontSizeSubTitle = NSUserDefaults.standardUserDefaults().floatForKey(SliderValueKeySubTitle)
        orderByName = NSUserDefaults.standardUserDefaults().boolForKey(orderByNameKey)
        createDefaultFetchRequest()
       
        tableView.reloadData()
    }
    
    func createDefaultFetchRequest(){
        
        //Get the stack
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let stack = delegate.stack
        
        
        // Create a fetchrequest
        let fr = NSFetchRequest(entityName: "Article")
        fr.sortDescriptors = [NSSortDescriptor(key: "articleTitle", ascending: orderByName)]
        
        // Create the FetchedResultsController
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fr,
                                                              managedObjectContext: stack.context, sectionNameKeyPath: nil, cacheName: nil)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Set the title & Size fonts
        title = "Table"
        fontSizeTitle = NSUserDefaults.standardUserDefaults().floatForKey(SliderValueKeyTitle)
        fontSizeSubTitle = NSUserDefaults.standardUserDefaults().floatForKey(SliderValueKeySubTitle)
        orderByName = NSUserDefaults.standardUserDefaults().boolForKey(orderByNameKey)
        
        createDefaultFetchRequest()
        
        // initialize search controller after the core data
        self.resultSearchController.searchResultsUpdater = self
        self.resultSearchController.dimsBackgroundDuringPresentation = false
        self.resultSearchController.searchBar.sizeToFit()
        
        // places the built-in searchbar into the header of the table
        self.resultSearchController.searchBar.placeholder = "Search the article title here"
        self.tableView.tableHeaderView = self.resultSearchController.searchBar
        
        
        // makes the searchbar stay in the current screen and not spill into the next screen
        definesPresentationContext = true
    }
    
    func refresh(){
        
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        delegate.runBackGroundRequestWebService()
        
        
        refreshButton.customView!.transform = CGAffineTransformMakeRotation(CGFloat(M_PI * 6/5))
        UIView.animateWithDuration(1.0) {
            self.refreshButton.customView!.transform = CGAffineTransformIdentity
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:  - TableView Data Source
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        // This method must be implemented by our subclass. There's no way
        // CoreDataTableViewController can know what type of cell we want to
        // use.
        
        // Find the right notebook for this indexpath
        let article = fetchedResultsController!.objectAtIndexPath(indexPath) as! Article
        
        // Create the cell
        let cell = tableView.dequeueReusableCellWithIdentifier("ArticleCell", forIndexPath: indexPath)
        
        // Sync article -> cell
        cell.textLabel?.font = cell.textLabel?.font.fontWithSize(CGFloat(fontSizeTitle))
        cell.textLabel?.text = article.articleTitle
        
        
        cell.detailTextLabel?.font = cell.textLabel?.font.fontWithSize(CGFloat(fontSizeSubTitle))
        cell.detailTextLabel?.text = article.articleSubTitle
        let image = UIImage(data: article.image!.imageData!)
        cell.imageView?.image = image
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        
        if let context = fetchedResultsController?.managedObjectContext,
            article = fetchedResultsController?.objectAtIndexPath(indexPath) as? Article
            where editingStyle == .Delete{
            context.deleteObject(article)
        }
        
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier! == "detailArticle"{
            
            if let articleDetailVC = segue.destinationViewController as? DetailArticleViewController{
                
                let indexPath = tableView.indexPathForSelectedRow!
                let article = fetchedResultsController?.objectAtIndexPath(indexPath) as? Article
                
                // Inject the article
                articleDetailVC.article = article
                
            }
        }
    }
    
    
    
}

extension ArticleTableViewController: UISearchResultsUpdating {
    // updates the table view with the search results as user is typing...
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        // process the search string, remove leading and trailing spaces
        let searchText = searchController.searchBar.text!
        let trimmedSearchString = searchText.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        
        let fr = NSFetchRequest(entityName: "Article")
        
        // if search string is not blank
        if !trimmedSearchString.isEmpty {
            
            // form the search format
            let predicate = NSPredicate(format: "(articleTitle contains [cd] %@)", trimmedSearchString)
            
            // add the search filter
            fr.predicate = predicate
            fr.sortDescriptors = [NSSortDescriptor(key: "articleTitle", ascending: true)]
        }
        else {
            
            
            fr.sortDescriptors = [NSSortDescriptor(key: "articleTitle", ascending: orderByName)]
            
        }
        
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fr,
                                                              managedObjectContext:fetchedResultsController!.managedObjectContext,
                                                              sectionNameKeyPath: nil,
                                                              cacheName: nil)
        
        // refresh the table view
        self.tableView.reloadData()
    }
}
