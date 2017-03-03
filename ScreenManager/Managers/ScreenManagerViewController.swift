//
//  ScreenManagerViewController.swift
//  ScreenManager
//
//  Created by Ankit on 03/03/17.
//  Copyright © 2017 Ankit. All rights reserved.
//

import UIKit

class ScreenManagerViewController: UIViewController {
    
    var currentPresentedViewController : UIViewController!
    var presentedViewControllers : [UIViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        currentPresentedViewController = self
        ScreenVader.sharedVader.screenMangerVC = self
        
        presentedViewControllers.append(self)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        initialViewBootUp()
    }
    
    func initialViewBootUp() { // check here for logged in user or not
//        if loggedIn {
//            
//            presentRootViewControllerOf(.MainTab, queryParams: nil)
//        } else {
//            presentRootViewControllerOf(.Onboarding, queryParams: nil)
//        }
        
        presentRootViewControllerOf(storyBoardIdentifier: .Main, queryParams: nil)
    }
    
    func presentRootViewControllerOf(storyBoardIdentifier : StoryBoardIdentifier, queryParams : [String:AnyObject]?){
        
        currentPresentedViewController = initialViewControllerFor(storyboardId: storyBoardIdentifier)
        
        if let currentPresentedViewController = currentPresentedViewController{
            
            if let queryParams = queryParams{
                
                currentPresentedViewController.setObjectsWithQueryParameters(queryParams: queryParams)
                
            }
            
            present(currentPresentedViewController, animated: false, completion: nil)
            
            presentedViewControllers.append(currentPresentedViewController)
        }
        
    }
    func pushInitialViewControllerOf(storyBoardIdentifier : StoryBoardIdentifier , queryParams : [String:AnyObject]?){
        
        if currentPresentedViewController != nil{
            
             if let currentNavVc = currentPresentedViewController as? CustomNavigationViewController{
                
                if let vc = initialViewControllerFor(storyboardId: storyBoardIdentifier){
                    if let params = queryParams{
                        vc.setObjectsWithQueryParameters(queryParams: params)
                    }
                    currentNavVc.pushViewController(vc, animated : true)
                }
            }
        }
        
    }
    
    
    func pushViewControllerOf(storyBoardIdentifier : StoryBoardIdentifier,viewControllerIdentifier : String , queryParams : [String:AnyObject]?){
        
        if currentPresentedViewController != nil{
             if let currentNavVc = currentPresentedViewController as? CustomNavigationViewController{
                
                currentNavVc.pushViewController(getViewControllerToOpen(storyboard: storyBoardIdentifier, forIdentifier: viewControllerIdentifier, queryParam: queryParams), animated: true)
                
            }
        }
        
    }
    
    func presentViewControllerOf(storyBoardIdentifier : StoryBoardIdentifier,viewControllerIdentifier : String , queryParams : [String:AnyObject]?){
        
        
        if let presentingVC = instantiateViewControllerWith(storyboard: storyBoardIdentifier, forIdentifier: viewControllerIdentifier){
            
            if let queryParams = queryParams{
                if let vc = presentingVC as? CustomNavigationViewController{
                    vc.viewControllers[0].setObjectsWithQueryParameters(queryParams: queryParams)
                }
                
            }
            currentPresentedViewController.present(presentingVC, animated: true, completion: nil)
            currentPresentedViewController = presentingVC
            presentedViewControllers.append(presentingVC)
            
        }
    }
    
    func presentPopUpViewWithNib( viewController : UIViewController){
        
        currentPresentedViewController.present(viewController, animated: true, completion: nil)
        currentPresentedViewController = viewController
        presentedViewControllers.append(viewController)
        
        
    }
    
    func initialViewControllerFor(storyboardId: StoryBoardIdentifier) -> UIViewController? {
        return UIStoryboard(name: storyboardId.rawValue, bundle: nil).instantiateInitialViewController()
    }
    
    func instantiateViewControllerWith(storyboard: StoryBoardIdentifier, forIdentifier: String) -> UIViewController? {
        return UIStoryboard(name: storyboard.rawValue, bundle: nil).instantiateViewController(withIdentifier: forIdentifier)
    }
    
    func getViewControllerToOpen(storyboard: StoryBoardIdentifier, forIdentifier: String?, queryParam: [String:AnyObject]?) -> UIViewController {
        
        var viewControllerToOpen: UIViewController!
        if let forIdentifier = forIdentifier {
            viewControllerToOpen = instantiateViewControllerWith(storyboard: storyboard, forIdentifier: forIdentifier)
        } else {
            viewControllerToOpen = initialViewControllerFor(storyboardId: storyboard)
        }
        
        if let queryParam = queryParam {
            viewControllerToOpen.setObjectsWithQueryParameters(queryParams: queryParam)
        }
        return viewControllerToOpen
    }
    
    func getTopViewController() -> UIViewController {
        if currentPresentedViewController != nil {
            
            if let selectedNav = currentPresentedViewController as? CustomNavigationViewController {
                return selectedNav.topViewController!
            }
        }
        
        return self
    }
    
    
    func removePresentedViewController(dismissVC : UIViewController){
        
        if currentPresentedViewController == dismissVC {
            if presentedViewControllers.count > 0 {
                
                presentedViewControllers.remove(at: presentedViewControllers.count-1)
                
                if presentedViewControllers.count > 0 {
                    
                    currentPresentedViewController = presentedViewControllers[presentedViewControllers.count-1]
                }
                
            }
        }
    }
}

extension ScreenManagerViewController{
    
    
    func performScreenManagerAction(action : ScreenManagerAction , params : [String:AnyObject]?){
        
        if currentPresentedViewController == nil{
            // do pending action here
            return
        }
        switch action{
            
        case .OpenUserVC:
            openUserVC(params: params)
            break
            
        case .OpenSecondVC:
            openUserSecondView(params: params)
            break
            
        default:
            break
        }
    }
    
    func performLogout(){
        currentPresentedViewController?.dismiss(animated: true, completion: nil)
        
        
    }
   
    func openUserVC(params : [String:AnyObject]?){
        presentViewControllerOf(storyBoardIdentifier: .User, viewControllerIdentifier: "userVC", queryParams: params)
    }
    
    
    func openUserSecondView(params : [String:AnyObject]?){
        
        pushViewControllerOf(storyBoardIdentifier: .User, viewControllerIdentifier: "secondVC", queryParams: params)
        
    }
    
}
