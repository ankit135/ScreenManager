//
//  ScreenVader.swift
//  ScreenManager
//
//  Created by Ankit on 03/03/17.
//  Copyright © 2017 Ankit. All rights reserved.
//

import UIKit

enum ScreenManagerAction : String {
    
    case OpenUserVC = "openUserVC"
    case OpenSecondVC = "user"
 
}

enum StoryBoardIdentifier : String{
    
    case Main = "Main"
    case User = "User"

}

class ScreenVader: NSObject {
    
    static let sharedVader = ScreenVader()  // singleton class object
    
    var screenMangerVC : ScreenManagerViewController?   // this class should have reference of ScreenMangerViewController
    
    func performScreenManagerAction(action: ScreenManagerAction, queryParams: [String:AnyObject]?) {
        
        if let screenManagerVC = screenMangerVC{
            screenManagerVC.performScreenManagerAction(action: action, params: queryParams)
        }
    }
    
    func removeDismissedViewController(dismissVC: UIViewController) {
        if let screenManagerVC = screenMangerVC {
            screenManagerVC.removePresentedViewController(dismissVC: dismissVC)
            
        }
    }
    
    
    //MARK:- Deeplink handling
    
    func processDeepLink(deepLinkString : String){
        if let deepLinkUrl = NSURL(string: deepLinkString) {
            processDeepLinkUrl(deepLinkUrl: deepLinkUrl)
        }
    }
    
    func processDeepLinkUrl(deepLinkUrl: NSURL) {
        
        if let pathString = deepLinkUrl.path, pathString.characters.count > 0 {
            print(pathString)
            var pathComponents = pathString.components(separatedBy: "/")
            
            if pathComponents.count > 1{
                pathComponents.removeFirst()
                if let action = pathComponents.first{
                    if let screenManagerAction = ScreenManagerAction(rawValue: action){
                        
                        let deepLinkQueryParams : [String:AnyObject]? = getQueryParamsForString(queryString: deepLinkUrl.query)
                        
                        performScreenManagerAction(action: screenManagerAction, queryParams: deepLinkQueryParams)
                        
                    }
                }
            }
        }
    }
    
    private func getQueryParamsForString(queryString: String?) -> [String: AnyObject]? {
        
        var queryParams: [String:AnyObject]?
        
        if let queryString = queryString {
            let queryComponenets = queryString.components(separatedBy: "&")
            if queryComponenets.count > 0 {
                queryParams = [:]
                for queryComp in queryComponenets {
                    let queryKVPString = queryComp.components(separatedBy: "=")
                    
                    if queryKVPString.count > 1 {
                        queryParams![queryKVPString[0]] = queryKVPString[1] as AnyObject?
                    }
                }
            }
        }
        
        return queryParams
    }
    
}

