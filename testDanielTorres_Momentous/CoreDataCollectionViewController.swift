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

class CoreDataCollectionViewController: UIViewController {

    
    @IBOutlet weak var collectionView: UICollectionView!
    
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
    
    init?(fetchedResultsController fc : NSFetchedResultsController, coder aDecoder: NSCoder){
        fetchedResultsController = fc
        super.init(coder: aDecoder)
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

extension CoreDataCollectionViewController: UICollectionViewDelegate {
    
    // MARK: UICollectionViewDataSource
    
     func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if let fc = fetchedResultsController{
            return (fc.sections?.count)!;
        }else{
            return 0
        }
    }
    
    
     func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if let fc = fetchedResultsController{
            return fc.sections![section].numberOfObjects;
        }else{
            return 0
        }
    }
    
     func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        fatalError("This method MUST be implemented by a subclass of CoreDataTableViewController")
        
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





