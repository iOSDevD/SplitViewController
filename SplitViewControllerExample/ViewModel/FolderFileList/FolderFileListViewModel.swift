//
//  FolderFileListViewModel.swift
//  SplitViewControllerExample
//
//  Created by iOSDev on 5/20/21.
//

import Foundation

/// FileList Protocol to handle file List controller.
protocol FolderFileListViewModel {
    /// Initializer for Data Service
    init(dataService: DataService)
    
    /// Returns the list of files for a specific folder name and sub folder
    /// name.
    /// - Returns: List of file names for a folder and sub folder.
    func getFileList(for folderName:String, subFolderName:String) -> [String]?
    
    
    /// Fetch the data for controller
    func fetchData()
}
