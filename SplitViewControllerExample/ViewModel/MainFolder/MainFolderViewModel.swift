//
//  MainFolderViewModel.swift
//  SplitViewControllerExample
//
//  Created by iOSDev on 5/20/21.
//

import Foundation

enum SplitViewStyle {
    case double , triple
}

/// Protocol to handle Main Folder section
/// count, row count, header to be presented.
/// It also provides methods to be implemented for
/// selection and fetch data.
/// Initialize with a dataservice and the splitview
/// as triple for iOS 14 onwards to show primary,supplementary
/// and file list and for version prior to iOS 14 we show
/// Primary Folder as section header and rows representing the
/// supplementary rows.
protocol MainFolderViewModel {
    /// Initialize with data service and SplitViewStyle as
    /// double or triple
    init(dataService: DataService, style: SplitViewStyle )
    
    /// Section count for the Table view representation
    var sectionItemCount: Int {get}
    
    
    /// Row Count for the Table view representation
    /// For iOS version prior to 14, it can be used
    /// to show Section(Main Folder) and Row(Supplementary)
    /// folder, where we would need row count.
    /// - Returns: Row count for a section.
    func rowCount(for section:Int) -> Int
    
    
    /// String header representation in Table view.
    /// For iOS vdrsion prior to 14, it can be used
    /// to show header representing the main section.
    /// - Returns: header for a section.
    func header(for section: Int) -> String?
    
    /// Returns the folder Name at the selected indexPath.
    /// Use the folder name to reload the supplementary
    /// - Parameter indexPath: IndexPath of selected folder
    func itemSelected(at indexPath:IndexPath) -> (String?,String?)
    
    /// Fetch data for the main Folder controller.
    func fetchData()
    
    /// Get the folder name in case the style is
    /// triple column, sub folder name in case the style
    /// is double column.
    subscript(indexPath: IndexPath)-> String? { get }
}
