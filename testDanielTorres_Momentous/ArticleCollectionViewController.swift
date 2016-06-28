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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the title
        title = "Collection"
        
        // Get the stack
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let stack = delegate.stack
        
        // Create a fetchrequest
        let fr = NSFetchRequest(entityName: "Article")
        fr.sortDescriptors = [NSSortDescriptor(key: "articleTitle", ascending: true),
                              NSSortDescriptor(key: "creationDate", ascending: false)]
        
        // Create the FetchedResultsController
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fr,
                                                              managedObjectContext: stack.context, sectionNameKeyPath: nil, cacheName: nil)
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
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        // Find the right notebook for this indexpath
        let article = fetchedResultsController!.objectAtIndexPath(indexPath) as! Article
        
        // Create the cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ArticleCell", forIndexPath: indexPath) as! ArticleCollectionCell
        
//      Sync article -> cell
        
        cell.titleArticle.text = article.articleTitle
        cell.subtitleArticle.text = article.articleSubTitle
        let image = UIImage(data: article.image!.imageData!)
        cell.imageArticle.image = image
        
        return cell// Find the right notebook for this indexpath
        
    
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

    

}
