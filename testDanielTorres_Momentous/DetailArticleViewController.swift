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

    @IBOutlet weak var articleTitleUI: UILabel!
    @IBOutlet weak var articleAboutUI: UILabel!
    @IBOutlet weak var buttonImage: UIButton!
    
    @IBOutlet weak var stackView: UIStackView!
    
    
    
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addGesturesToLabel()
        
        
        if let title = article?.articleTitle{
            self.title = title
        }
        else {
            self.title = "details"
        }
    
        articleTitleUI.text = (article?.articleTitle)! + " - " + (article?.articleSubTitle)!
        articleAboutUI.text = article?.articleAbout
        print (article?.articleAbout)
        print (article?.articleAbout)
        let image = UIImage(data: (article?.image!.imageData)!)
        buttonImage.imageView!.contentMode = .ScaleAspectFit
        buttonImage.setImage(image, forState: .Normal)
        
        print(article)
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    

}
