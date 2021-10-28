//
//  UIViewController+RefreshControllerUtilities.swift
//  SplitViewControllerExample
//
//  Created by iOSDev on 6/10/21.
//

import UIKit


extension UIViewController {
    func getFolderListUpdatable() -> FolderListUpdatable? {
        guard let splitController = UIApplication.shared.windows.first?.rootViewController as? UISplitViewController else {
            return nil
        }
        
        return splitController.getControllerOfType()
    }
    
    func getFolderFilesUpdatable() -> FolderFilesUpdatable? {
        guard let splitController = UIApplication.shared.windows.first?.rootViewController as? UISplitViewController else {
            return nil
        }
        return splitController.getControllerOfType()
    }
}
