//
//  ViewController.swift
//  ScreenManager
//
//  Created by Ankit on 03/03/17.
//  Copyright © 2017 Ankit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func buttonTapped(_ sender: Any) {
        
        ScreenVader.sharedVader.performScreenManagerAction(action: .OpenUserVC, queryParams: nil)
        
    }


}

