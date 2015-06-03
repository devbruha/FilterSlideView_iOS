//
//  ViewController.swift
//  DragSlideView
//
//  Created by Training on 07/01/15.
//  Copyright (c) 2015 Training. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var settings:SettingsView!
    var filters:FilterView!

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        settings = NSBundle.mainBundle().loadNibNamed("Settings", owner: self, options: nil).last as! SettingsView
        settings.frame = CGRectMake(0, self.view.frame.size.height - 30, self.view.frame.size.width, 20)
        
        self.view.addSubview(settings)
        
        settings.setup()
        
        
      
        
//        filters = NSBundle.mainBundle().loadNibNamed("FilterView", owner: self, options: nil).last as! FilterView!

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

