//
//  DataService.swift
//  SplitViewControllerExample
//
//  Created by iOSDev on 5/20/21.
//

import Foundation

/// Protocol to be implemented by a service
/// to get data.
protocol DataService {
    /// Fetch Data to be shown by the view Models
    func fetchData()
    
    /// Folder List Array object to be used by
    /// the views
    var  folderList:[Folder]? { get }
}
