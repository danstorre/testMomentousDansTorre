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

    
    // MARK: - Properties
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
    
    
    // MARK: - Default Methods
    override func viewWillAppear(animated: Bool) {
        fontSizeTitle = NSUserDefaults.standardUserDefaults().floatForKey(SliderValueKeyTitle)
        fontSizeSubTitle = NSUserDefaults.standardUserDefaults().floatForKey(SliderValueKeySubTitle)
        orderByName = NSUserDefaults.standardUserDefaults().boolForKey(orderByNameKey)
        createDefaultFetchRequest()
       
        tableView.reloadData()
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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:  - TableView Data Source
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let article = fetchedResultsController!.objectAtIndexPath(indexPath) as! Article
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ArticleCell", forIndexPath: indexPath)
        
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

        if segue.identifier! == "detailArticle"{
            
            if let articleDetailVC = segue.destinationViewController as? DetailArticleViewController{
                
                let indexPath = tableView.indexPathForSelectedRow!
                let article = fetchedResultsController?.objectAtIndexPath(indexPath) as? Article
                
                articleDetailVC.article = article
                
            }
        }
    }
    
    // MARK: - Util Methods
    func createDefaultFetchRequest(){
        
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let stack = delegate.stack
        
        let fr = NSFetchRequest(entityName: "Article")
        fr.sortDescriptors = [NSSortDescriptor(key: "articleTitle", ascending: orderByName)]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fr,
                                                              managedObjectContext: stack.context, sectionNameKeyPath: nil, cacheName: nil)
        
    }
    
    func refresh(){
        
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        delegate.runBackGroundRequestWebService()
        
        
        refreshButton.customView!.transform = CGAffineTransformMakeRotation(CGFloat(M_PI * 6/5))
        UIView.animateWithDuration(1.0) {
            self.refreshButton.customView!.transform = CGAffineTransformIdentity
        }
        
    }
    
   
    
}


// MARK: - UISearchResultsUpdating Methods

extension ArticleTableViewController: UISearchResultsUpdating {
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        let searchText = searchController.searchBar.text!
        let trimmedSearchString = searchText.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        let fr = NSFetchRequest(entityName: "Article")
        
        if !trimmedSearchString.isEmpty {
            
            let predicate = NSPredicate(format: "(articleTitle contains [cd] %@)", trimmedSearchString)
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
        self.tableView.reloadData()
    }
}
