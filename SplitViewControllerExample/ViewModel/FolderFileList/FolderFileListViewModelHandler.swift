//
//  FolderFileListViewModelHandler.swift
//  SplitViewControllerExample
//
//  Created by iOSDev on 5/18/21.
//

import Foundation

/// Implements the FolderFileListViewModel to be used
/// by file list controller.
class FolderFileListViewModelHandler {
    private let dataService: DataService
    
    required init(dataService: DataService) {
        self.dataService = dataService
    }
}

extension FolderFileListViewModelHandler: FolderFileListViewModel {
    func getFileList(for folderName:String, subFolderName:String) -> [String]? {
        let folder = self.dataService.folderList?.filter{ $0.folderName == folderName
        }.first?.subFolder.filter{ $0.folderName == subFolderName } // Get the file list for folder and sub folder
        if let files = folder?.first?.fileNames {
            return files
        }
        return nil
    }
    
    func fetchData() {
        self.dataService.fetchData() // Fetch data from service
    }
}
