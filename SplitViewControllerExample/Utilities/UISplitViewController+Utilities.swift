//
//  UISplitViewController+Utilities.swift
//  SplitViewControllerExample
//
//  Created by iOSDev on 5/19/21.
//

import UIKit

extension UISplitViewController {

    
    /// Get the a specific controller type in the
    /// SplitViewController hirerachy.
    /// - Returns: Controller of generic type being requested.
    func getControllerOfType<T>() -> T? {
        let folderLists = self.viewControllers.compactMap { (controller) -> T? in
            if let navController = controller as? UINavigationController,
               let folderList = navController.viewControllers.first as? T{
                return folderList
            }
            return nil
        }
        return folderLists.first
    }
}
