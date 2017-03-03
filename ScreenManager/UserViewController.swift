//
//  UserViewController.swift
//  ScreenManager
//
//  Created by Ankit on 03/03/17.
//  Copyright © 2017 Ankit. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func deeplinkButtonTapped(_ sender: Any) {
        
        let deepLinkStr = "screenmanager://screenmanager/user?user_id=123"
        
        ScreenVader.sharedVader.processDeepLink(deepLinkString: deepLinkStr)
        
    }
    @IBAction func cancelTapped(_ sender: Any) {
        
        self.navigationController?.dismiss(animated: true, completion: nil)
    }


}
