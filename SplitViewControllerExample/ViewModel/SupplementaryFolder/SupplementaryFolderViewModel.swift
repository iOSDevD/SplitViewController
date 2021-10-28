//
//  SupplementaryFolderViewModel.swift
//  SplitViewControllerExample
//
//  Created by iOSDev on 5/20/21.
//

import Foundation


/// Supplementary Protocol to handle the supplementary
/// Folder list view
protocol SupplementaryFolderViewModel {
    /// Initializer for Data Service
    init(dataService: DataService)
    
    /// Returns the supplementary folder list for the main folder.
    /// - Returns: Supplementary folder to be used in iOS 14 onwards.
    func getSupplementaryFolderList(for folderName:String) -> [SubFolder]?
    
    
    /// Handle events of supplementary folder selection.
    /// - Returns: Main Folder and Sub Folder inorder to fetch file list specific
    /// to the selection.
    func supplementaryFolderSelected(at indexPath: IndexPath) -> (String?,String?)
    
    
    /// Main Fodler being selected.
    var mainFolderName: String? {get}
}
