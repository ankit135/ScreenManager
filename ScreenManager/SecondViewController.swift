//
//  SecondViewController.swift
//  ScreenManager
//
//  Created by Ankit on 03/03/17.
//  Copyright © 2017 Ankit. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var userId : String?
    
    @IBOutlet weak var userLabel: UILabel!
    
    override func setObjectsWithQueryParameters(queryParams: [String : AnyObject]) {
        if let id = queryParams["user_id"] as? String{
            self.userId = id
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let userId = userId{
            userLabel.text = "User id is \(userId)"
        }
   
        // Do any additional setup after loading the view.
    }


}
