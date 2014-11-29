//
//  ViewController.swift
//  Web Services Example
//
//  Created by David Currie on 11/29/14.
//  Copyright (c) 2014 Urban Airship. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.myNameLabel.alpha = 0.0
        
        let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        activityIndicatorView.center = self.view.center
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        
        let manager = AFHTTPRequestOperationManager()
        
        manager.GET("http://graph.facebook.com/bobdylan",
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                println("JSON: " + responseObject.description)
                
                activityIndicatorView.stopAnimating()
                
                if let myName = responseObject.valueForKey("name") as? String {
                    self.myNameLabel.text = myName;
                
                UIView.animateWithDuration(1.0, animations: {
                    self.myNameLabel.alpha = 1.0
                    }, completion: {
                        (value: Bool) in
                        println("Animation complete")
                    })
                }
            },
            failure: {(operation: AFHTTPRequestOperation!, error: NSError!) in
                println("Error: " + error.localizedDescription)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

