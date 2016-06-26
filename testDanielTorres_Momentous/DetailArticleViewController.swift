//
//  DetailArticleViewController.swift
//  testDanielTorres_Momentous
//
//  Created by Daniel Torres on 6/26/16.
//  Copyright © 2016 Danieltorres. All rights reserved.
//

import UIKit

class DetailArticleViewController: UIViewController {

    var article : Article?
    @IBOutlet weak var articleImage: UIButton!
    @IBOutlet weak var articleTitleUI: UILabel!
    @IBOutlet weak var articleAboutUI: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let title = article?.articleTitle{
            self.title = title
        }
        else {
            self.title = "details"
        }
        articleImage.titleLabel?.text = article?.articleImage
        articleTitleUI.text = (article?.articleTitle)! + " - " + (article?.articleSubTitle)!
        articleAboutUI.text = article?.articleAbout
        
        print(article)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
