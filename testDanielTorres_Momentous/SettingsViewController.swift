//
//  SettingsViewController.swift
//  testDanielTorres_Momentous
//
//  Created by Daniel Torres on 6/28/16.
//  Copyright © 2016 Danieltorres. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    // MARK: - Properties
    let SliderValueKeyTitle = "Slider Value Key for Font Title"
    let SliderValueKeySubTitle = "Slider Value Key for Font SubTitle"
    let orderByNameKey = "Order by name"
    
    @IBOutlet weak var switchButton: UISwitch!
    @IBOutlet weak var sliderTitle: UISlider!
    @IBOutlet weak var sliderSubTitle: UISlider!
    @IBOutlet weak var exampleTitle: UILabel!
    @IBOutlet weak var exampleSubTitle: UILabel!
    
    
    // MARK: - default UIViewController Methods
    override func viewWillAppear(animated: Bool) {
        exampleTitle.font = exampleTitle.font.fontWithSize(CGFloat(sliderTitle.value))
        exampleSubTitle.font = exampleSubTitle.font.fontWithSize(CGFloat(sliderSubTitle.value))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        sliderTitle.value = NSUserDefaults.standardUserDefaults().floatForKey(SliderValueKeyTitle)
        sliderSubTitle.value = NSUserDefaults.standardUserDefaults().floatForKey(SliderValueKeySubTitle)
        switchButton.on = NSUserDefaults.standardUserDefaults().boolForKey(orderByNameKey)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Slider and Switch methods
    
    @IBAction func didChangeSliderTitle(sender: UISlider) {
        NSUserDefaults.standardUserDefaults().setFloat(sliderTitle.value, forKey: SliderValueKeyTitle)
        exampleTitle.font = exampleTitle.font.fontWithSize(CGFloat(sliderTitle.value))
    }

    @IBAction func didChangeSliderSubTitle(sender: UISlider) {
        NSUserDefaults.standardUserDefaults().setFloat(sliderSubTitle.value, forKey: SliderValueKeySubTitle)
        exampleSubTitle.font = exampleSubTitle.font.fontWithSize(CGFloat(sliderSubTitle.value))
    }
    
    @IBAction func switchOnOff(sender: UISwitch) {
        
        
        NSUserDefaults.standardUserDefaults().setBool(switchButton.on, forKey: orderByNameKey)
    }

}
