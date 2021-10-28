//
//  ViewModelFactory.swift
//  SplitViewControllerExample
//
//  Created by iOSDev on 6/9/21.
//

import Foundation


/// ViewModelFactory which returns view model handler
/// to handle main folder, supplementary and final file list
/// interface.
class ViewModelFactory {
    /// Static instance of ViewModelFactory.
    static let shared = ViewModelFactory()
    
    private init() {}
    
    /// Instance of MainFolderViewModel, with provided
    /// dat service and split style. SplitViewStyle can be double for pre
    /// iOS 14 split view controller.
    /// - Parameters:
    ///   - dataService: DataService object to the view model.
    ///   - style: UI split style.
    /// - Returns: MainFolderViewModel object.
    func getMainFolderViewModel(dataService: DataService, style: SplitViewStyle ) -> MainFolderViewModel {
        return MainFolderViewModelHandler(dataService: dataService, style: style)
    }
    
    /// Creates a new instance of SupplementaryFolderViewModel, with
    /// the provided data service.
    /// - Parameter dataService: DataService object to the view model.
    /// - Returns: SupplementaryFolderViewModel object.
    func getSupplementaryFolderViewModel(dataService: DataService) -> SupplementaryFolderViewModel{
        return SupplementaryFolderViewModelHandler(dataService: dataService)
    }
    
    /// Creates a new instance of FolderFileListViewModel, with the
    /// provided data service.
    /// - Parameter dataService: DataService object to the view model.
    /// - Returns: FolderFileListViewModel object.
    func getFolderFileListViewModel(dataService: DataService) -> FolderFileListViewModel{
        return FolderFileListViewModelHandler(dataService: dataService)
    }
}
