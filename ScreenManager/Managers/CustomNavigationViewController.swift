//
//  CustomNavigationViewController.swift
//  ScreenManager
//
//  Created by Ankit on 03/03/17.
//  Copyright © 2017 Ankit. All rights reserved.
//

import UIKit

class CustomNavigationViewController: UINavigationController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setAppearnce()
        

        // Do any additional setup after loading the view.
    }
    
    
    func setAppearnce(){
        
        self.navigationBar.barTintColor = UIColor.black
        self.navigationBar.tintColor = UIColor.white

    }
    
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)?) {
        super.dismiss(animated: flag, completion: completion)
        if isBeingDismissed {
            ScreenVader.sharedVader.removeDismissedViewController(dismissVC: self)
            
        }
    }


}
