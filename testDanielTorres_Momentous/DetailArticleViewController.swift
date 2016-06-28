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

    var article : Article?
    
    //This strings could be placed in a localizable strings file. They're not because it's just a simple app.
    let alertTitle  = "Alert"
    let messageAlert  = "Are you sure you want to delete this item?"
    let okButton = "Yes"
    let noButton = "No"
    

    @IBOutlet weak var articleTitleUI: UILabel!
    @IBOutlet weak var articleAboutUI: UILabel!
    @IBOutlet weak var buttonImage: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    
    
    @IBAction func deleteButton(sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: alertTitle, message: messageAlert, preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: okButton, style: .Destructive) {
            UIAlertAction in
            self.deleteArticle()
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        alertController.addAction(okAction)
        alertController.addAction(UIAlertAction(title: noButton, style: .Default, handler: nil))
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addGesturesToLabel()
        
        self.title = title
        articleTitleUI.text = (article?.articleTitle)! + " - " + (article?.articleSubTitle)!
        articleAboutUI.text = article?.articleAbout
        let image = UIImage(data: (article?.image!.imageData)!)
        buttonImage.imageView!.contentMode = .ScaleAspectFit
        buttonImage.setImage(image, forState: .Normal)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func hideButton(sender: UIButton) {
        
        UIView.animateWithDuration(0.4){
            self.buttonImage.hidden = true
        }
        
    }
    
    
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    

}
