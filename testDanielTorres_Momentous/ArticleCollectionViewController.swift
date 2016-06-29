//
//  ArticleCollectionViewController.swift
//  testDanielTorres_Momentous
//
//  Created by Daniel Torres on 6/27/16.
//  Copyright © 2016 Danieltorres. All rights reserved.
//

import UIKit
import CoreData


class ArticleCollectionViewController: CoreDataCollectionViewController {

    
    var resultSearchController = UISearchController(searchResultsController: nil)
    
    var fontSizeTitle : Float = 0.0
    var fontSizeSubTitle : Float = 0.0
    let SliderValueKeyTitle = "Slider Value Key for Font Title"
    let SliderValueKeySubTitle = "Slider Value Key for Font SubTitle"
    let orderByNameKey = "Order by name"
    var orderByName = false
    
    
    @IBOutlet weak var searchBarView: UISearchBar!
    
    
    override func viewWillAppear(animated: Bool) {
        fontSizeTitle = NSUserDefaults.standardUserDefaults().floatForKey(SliderValueKeyTitle)
        fontSizeSubTitle = NSUserDefaults.standardUserDefaults().floatForKey(SliderValueKeySubTitle)
        orderByName = NSUserDefaults.standardUserDefaults().boolForKey(orderByNameKey)
        createDefaultFetchRequest()
        
        collectionView.reloadData()
    }
    override func viewWillLayoutSubviews() {
        
        self.resultSearchController.searchBar.sizeToFit()
        
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
        // Set the title
        title = "Collection"
        fontSizeTitle = NSUserDefaults.standardUserDefaults().floatForKey(SliderValueKeyTitle)
        fontSizeSubTitle = NSUserDefaults.standardUserDefaults().floatForKey(SliderValueKeySubTitle)
        orderByName = NSUserDefaults.standardUserDefaults().boolForKey(orderByNameKey)
        
        createDefaultFetchRequest()
        
        navigationItem.leftBarButtonItem = editButtonItem()
        // initialize search controller after the core data
        self.resultSearchController.searchResultsUpdater = self
        self.resultSearchController.dimsBackgroundDuringPresentation = false
        self.resultSearchController.searchBar.placeholder = "Search the article title here"
        searchBarView.addSubview(self.resultSearchController.searchBar)
        
        // makes the searchbar stay in the current screen and not spill into the next screen
        definesPresentationContext = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK:- Editing
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        collectionView?.allowsMultipleSelection = editing
        collectionView?.reloadData()
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        // Find the right notebook for this indexpath
        let article = fetchedResultsController!.objectAtIndexPath(indexPath) as! Article
        
        // Create the cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ArticleCell", forIndexPath: indexPath) as! ArticleCollectionCell
        
        cell.deleteIcon.hidden = !editing
//      Sync article -> cell
        cell.titleArticle.font = cell.titleArticle.font.fontWithSize(CGFloat(fontSizeTitle))
        cell.titleArticle.text = article.articleTitle
        cell.titleArticle.userInteractionEnabled = !editing
        
        cell.subtitleArticle.font = cell.subtitleArticle.font.fontWithSize(CGFloat(fontSizeSubTitle))
        cell.subtitleArticle.text = article.articleSubTitle
        cell.subtitleArticle.userInteractionEnabled = !editing
        
        let image = UIImage(data: article.image!.imageData!)
        cell.imageArticle.image = image
        cell.imageArticle.userInteractionEnabled = !editing
        
        return cell// Find the right notebook for this indexpath
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        return !editing
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier! == "detailArticle"{
            
            if let articleDetailVC = segue.destinationViewController as? DetailArticleViewController{
                
                let indexPath = collectionView?.indexPathsForSelectedItems()
                let article = fetchedResultsController?.objectAtIndexPath(indexPath![0]) as? Article
                
                // Inject the article
                articleDetailVC.article = article
            }
        }
    }

    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        UIView.animateWithDuration(0.4){
            self.resultSearchController.searchBar.sizeToFit()
        }
        
    }

}

extension ArticleCollectionViewController: UISearchResultsUpdating {
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
            
            
            fr.sortDescriptors = [NSSortDescriptor(key: "articleTitle", ascending: true),
                                  NSSortDescriptor(key: "creationDate", ascending: false)]
            
        }
        
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fr,
                                                              managedObjectContext:fetchedResultsController!.managedObjectContext,
                                                              sectionNameKeyPath: nil,
                                                              cacheName: nil)
        
        // refresh the table view
        self.collectionView!.reloadData()
    }
}

