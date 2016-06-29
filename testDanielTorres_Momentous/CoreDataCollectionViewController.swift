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

    //tricky var for making NSFetchedResultsControllerDelegate work smoth with collectionView
    var blockOperations: [NSBlockOperation] = []
    
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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    

}

// MARK: - executeSearch CoreDataCollectionViewController
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
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        if editing {
            if let context = fetchedResultsController?.managedObjectContext,
            article = fetchedResultsController?.objectAtIndexPath(indexPath) as? Article
            {
                context.deleteObject(article)
            }
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

// MARK:  - NSFetchedResultsControllerDelegate
extension CoreDataCollectionViewController: NSFetchedResultsControllerDelegate{

    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        
        switch(type){
            
        case .Insert:
            blockOperations.append(
                NSBlockOperation(block: { [weak self] in
                    if let this = self {
                        this.collectionView!.insertItemsAtIndexPaths([newIndexPath!])
                    }
                    })
            )
            
        case .Delete:
            blockOperations.append(
                NSBlockOperation(block: { [weak self] in
                    if let this = self {
                        this.collectionView!.deleteItemsAtIndexPaths([indexPath!])
                    }
                    })
            )
            
        case .Update:
            blockOperations.append(
                NSBlockOperation(block: { [weak self] in
                    if let this = self {
                        this.collectionView!.reloadItemsAtIndexPaths([indexPath!])
                    }
                    })
            )
        case .Move:
            blockOperations.append(
                NSBlockOperation(block: { [weak self] in
                    if let this = self {
                        this.collectionView!.moveItemAtIndexPath(indexPath!, toIndexPath: newIndexPath!)
                    }
                    })
            )
        }
    }
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        
        
        switch(type){
            
        case .Insert:
            blockOperations.append(
                NSBlockOperation(block: { [weak self] in
                    if let this = self {
                        this.collectionView!.insertSections(NSIndexSet(index: sectionIndex))
                    }
                    })
            )
        
        case .Update:
            blockOperations.append(
                NSBlockOperation(block: { [weak self] in
                    if let this = self {
                        this.collectionView!.reloadSections(NSIndexSet(index: sectionIndex))
                    }
                    })
            )
        case .Delete:
            blockOperations.append(
                NSBlockOperation(block: { [weak self] in
                    if let this = self {
                        this.collectionView!.deleteSections(NSIndexSet(index: sectionIndex))
                    }
                    })
            )
        default: break
        }
    }
    
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        collectionView!.performBatchUpdates({ () -> Void in
            for operation: NSBlockOperation in self.blockOperations {
                operation.start()
            }
            }, completion: { (finished) -> Void in
                self.blockOperations.removeAll(keepCapacity: false)
        })
    }
    
    
    
}





