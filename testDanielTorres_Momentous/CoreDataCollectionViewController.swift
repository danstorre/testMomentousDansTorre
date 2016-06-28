//
//  CoreDataCollectionViewController.swift
//  testDanielTorres_Momentous
//
//  Created by Daniel Torres on 6/27/16.
//  Copyright © 2016 Danieltorres. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "ArticleCell"

class CoreDataCollectionViewController: UICollectionViewController {

    
    // MARK:  - Properties
    var fetchedResultsController : NSFetchedResultsController? {
        didSet{
            // Whenever the frc changes, we execute the search and
            // reload the table
            fetchedResultsController?.delegate = self
            executeSearch()
            collectionView!.reloadData()
        }
    }
    
    init(fetchedResultsController fc : NSFetchedResultsController,
                                  collectionViewLayout : UICollectionViewLayout){
        fetchedResultsController = fc
         super.init(collectionViewLayout: collectionViewLayout)
    }
    
    // Do not worry about this initializer. I has to be implemented
    // because of the way Swift interfaces with an Objective C
    // protocol called NSArchiving. It's not relevant.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if let fc = fetchedResultsController{
            return (fc.sections?.count)!;
        }else{
            return 0
        }
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if let fc = fetchedResultsController{
            return fc.sections![section].numberOfObjects;
        }else{
            return 0
        }
    }


    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}

extension CoreDataCollectionViewController{
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        fatalError("This method MUST be implemented by a subclass of CoreDataTableViewController")
        
    }
}

extension CoreDataCollectionViewController{
    
    func executeSearch(){
        if let fc = fetchedResultsController{
            do{
                try fc.performFetch()
            }catch let e as NSError{
                print("Error while trying to perform a search: \n\(e)\n\(fetchedResultsController)")
            }
        }
    }
}

// MARK:  - Delegate
extension CoreDataCollectionViewController: NSFetchedResultsControllerDelegate{
    
    
    
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        
    }
    
    func controller(controller: NSFetchedResultsController,
                    didChangeSection sectionInfo: NSFetchedResultsSectionInfo,
                                     atIndex sectionIndex: Int,
                                             forChangeType type: NSFetchedResultsChangeType) {
        
        let set = NSIndexSet(index: sectionIndex)
        
        switch (type){
            
        case .Insert:
            collectionView!.insertSections(set)
            
        case .Delete:
            collectionView!.deleteSections(set)
            
        default:
            // irrelevant in our case
            break
            
        }
    }
    
    
    func controller(controller: NSFetchedResultsController,
                    didChangeObject anObject: AnyObject,
                                    atIndexPath indexPath: NSIndexPath?,
                                                forChangeType type: NSFetchedResultsChangeType,
                                                              newIndexPath: NSIndexPath?) {
        
        
        
        switch(type){
            
        case .Insert:
            collectionView?.insertItemsAtIndexPaths([newIndexPath!])
            
        case .Delete:
            collectionView?.deleteItemsAtIndexPaths([indexPath!])
            
        case .Update:
            collectionView?.reloadItemsAtIndexPaths([indexPath!])
            
        case .Move:
            collectionView?.deleteItemsAtIndexPaths([indexPath!])
            collectionView?.insertItemsAtIndexPaths([newIndexPath!])
            
        }
        
    }
//    
//    func controllerDidChangeContent(controller: NSFetchedResultsController) {
//        collectionView.endUpdates()
//    }
}





