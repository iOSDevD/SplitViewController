//
//  SupplementaryFolderViewModelHandler.swift
//  SplitViewControllerExample
//
//  Created by iOSDev on 5/18/21.
//

import UIKit

/// Class implementing SupplementaryFolderViewModel
/// which can be used to handle supplementary folder
/// controller. This is useful for devices which have
/// iOS 14 or later.
class SupplementaryFolderViewModelHandler {
    let dataService: DataService
    
    required init(dataService: DataService) {
        self.dataService = dataService
    }
    
    private(set) var mainFolderName: String?
}

extension SupplementaryFolderViewModelHandler: SupplementaryFolderViewModel {
  
    
    func getSupplementaryFolderList(for folderName:String) -> [SubFolder]? {
        self.mainFolderName = folderName
        return self.dataService.folderList?.filter{  $0.folderName == folderName }.first?.subFolder
    }
    
    func supplementaryFolderSelected(with folderName:String, subFolderName: String){
        if let splitViewController = UIApplication.shared.windows.first?.rootViewController as? UISplitViewController {
            
            if let folderFilesUpdatable:FolderFilesUpdatable = splitViewController.getControllerOfType() {
                folderFilesUpdatable.reloadFileList(for: folderName, subFolder: subFolderName)
            }
        }
    }
    
    func supplementaryFolderSelected(at indexPath: IndexPath) -> (String?,String?) {
        guard let mainFolderName = mainFolderName else { return (nil,nil)}
        guard let subFolder = getSupplementaryFolderList(for: mainFolderName), 0..<subFolder.count ~= indexPath.row else { return (nil,nil)}
        
        return (self.mainFolderName,subFolder[indexPath.row].folderName)
    }
}
