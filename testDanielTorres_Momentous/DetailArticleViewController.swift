//
//  DetailArticleViewController.swift
//  testDanielTorres_Momentous
//
//  Created by Daniel Torres on 6/26/16.
//  Copyright © 2016 Danieltorres. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

class DetailArticleViewController: UIViewController {

    // MARK: - Properties
    var article : Article?
    
    //These strings could be placed in a localizable strings file. They're not because it's just a simple app.
    let alertTitle  = "Alert"
    let messageAlert  = "Are you sure you want to delete this item?"
    let okButton = "Yes"
    let noButton = "No"
    
    @IBOutlet weak var articleTitleUI: UILabel!
    @IBOutlet weak var articleAboutUI: UILabel!
    @IBOutlet weak var buttonImage: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    

    
    // MARK: - Default Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addGesturesToLabel()
        
        self.title = title
        
        if let article = self.article{
            articleTitleUI.text = article.articleTitle! + " - " + article.articleSubTitle!
            articleAboutUI.text = article.articleAbout
            let image = UIImage(data: article.image!.imageData!)
            buttonImage.imageView!.contentMode = .ScaleAspectFit
            buttonImage.setImage(image, forState: .Normal)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Button Methods
    @IBAction func deleteButton(sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: alertTitle, message: messageAlert, preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: okButton, style: .Destructive) {
            UIAlertAction in
            self.deleteArticle()
            self.navigationController?.popViewControllerAnimated(true)
        }
        alertController.addAction(okAction)
        alertController.addAction(UIAlertAction(title: noButton, style: .Default, handler: nil))
        presentViewController(alertController, animated: true, completion: nil)
    }
    

    @IBAction func hideButton(sender: UIButton) {
        
        UIView.animateWithDuration(0.4){
            self.buttonImage.hidden = true
        }
        
    }
    
    
    // MARK: - Methods
    func deleteArticle(){
        //Get the stack
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let stack = delegate.stack
        stack.context.deleteObject(article!)
        stack.save()
    }
    
    func  addGesturesToLabel(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(DetailArticleViewController.showImage(_:)))
        articleTitleUI.userInteractionEnabled = true
        articleAboutUI.userInteractionEnabled = true
        articleTitleUI.addGestureRecognizer(tapGesture)
        articleAboutUI.addGestureRecognizer(tapGesture)
    }
    
    func showImage(sender:UITapGestureRecognizer){
        if self.buttonImage.hidden {
            UIView.animateWithDuration(0.4){
                self.buttonImage.hidden = false
            }
        }
    }
    
    
    
    

}
