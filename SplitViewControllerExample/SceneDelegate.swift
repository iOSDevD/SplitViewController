//
//  SceneDelegate.swift
//  SplitViewControllerExample
//
//  Created by iOSDev on 5/16/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    var splitController:UISplitViewController?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        if let windowScene = (scene as? UIWindowScene) {
            self.window = UIWindow(windowScene: windowScene)
            createController()
            self.window?.rootViewController = splitController
            self.window?.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    /// Create SplitViewController with style dependent on iOS.
    /// For iOS 14 or later, it configures style triple column while
    /// for iOS 14 or ealier, it configures style double column.
    func createController(){
        let controllers = { (style: UISplitViewController.Style) -> [UIViewController] in
            var controllers:[UIViewController] = []
            let viewModelFactory = ViewModelFactory.shared
            let fileService = FileDataService()
            let viewModelStyle:SplitViewStyle = (style == .tripleColumn) ? .triple : .double
            let viewModel = viewModelFactory.getMainFolderViewModel(dataService: fileService, style: viewModelStyle)
            
            let folderListViewModel = viewModelFactory.getFolderFileListViewModel(dataService: fileService)
            
            
            let primaryController = PrimaryFolderViewController(viewModel: viewModel)  // Controller which helps to show main Folder structure
            
            controllers.append(primaryController)
            
            
            if style == .tripleColumn {
                let supplementaryViewModel = viewModelFactory.getSupplementaryFolderViewModel(dataService: fileService)
                // Controller which helps to show the Supplementary view (ex: Subfolder)
                let supplementaryController = SupplementaryFolderViewController(viewModel: supplementaryViewModel)
                controllers.append(supplementaryController)
            }
            
            // Controller which helps to show the file list view for a specific folder and sub folder.
            let secondaryController = SecondaryFilesViewController(viewModel: folderListViewModel)
            controllers.append(secondaryController)
            
            return controllers
        }
        
        if #available(iOS 14,*) {
            self.splitController = UISplitViewController(style: .tripleColumn)
            self.splitController?.viewControllers = controllers(.tripleColumn)
            self.splitController?.preferredDisplayMode = .twoBesideSecondary
        } else {
            self.splitController = UISplitViewController(style: .doubleColumn)
            self.splitController?.viewControllers = controllers(.doubleColumn)
        }
        
        
    }
}

