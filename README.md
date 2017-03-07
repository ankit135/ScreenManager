# ScreenManager
This manager helps you with :-
- Handling Deeplinks from notification
- Push or present ViewControllers from anywhere anytime.

The problem being solved here is open any view controller (VC) from anywhere. so for this you have to store references of all the presented VCs, and then; at the time of pushing or presenting any VC from deeplink, first I get the top presented view controller and then push or present required VC on top presented VC.

Step 1 :- Initialise Screen manager in AppDelegate.  

Step 2 :- Write ScreenVader singleton class.

Step 3 :- Write CustomNavigationViewController class and inherit all navigation controller from this class in storyBoard.

Step 4 :- Write ScreenMangerViewController class to push and present VCs.

Step 5 :- Check Utility.swift class.

Step 6 :- Use ScreenVader.sharedVader.processDeepLink(deepLinkString: deepLinkStr) where you want to open VC from deep link (like in AppDelegate where notifications land up).

Step 7 :- Use ScreenVader.sharedVader.performScreenManagerAction(action: .OpenUserVC, queryParams: nil) to open any VC from anywhere.
