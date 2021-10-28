//
//  MainFolderViewModelHandler.swift
//  SplitViewControllerExample
//
//  Created by iOSDev on 5/17/21.
//

import UIKit

/// Class implementing MainFolderViewModel protocol
/// which can be used by Main View controller to show
/// Folder name for iOS 14 or later. For iOS versions
/// prior to it, the controller shows section header
/// which represents main folder while rows show the
/// supplementary folders or sub folders.
class MainFolderViewModelHandler {
    
    private let dataService: DataService
    private let splitViewStyle: SplitViewStyle

    required init(dataService: DataService, style: SplitViewStyle ) {
        self.dataService = dataService
        self.splitViewStyle = style
    }
}

extension MainFolderViewModelHandler: MainFolderViewModel {

    var sectionItemCount: Int {
        let count:Int
        switch self.splitViewStyle {
        case .triple:
            count = (self.dataService.folderList?.count ?? 0) > 0 ? 1 : 0
        default:
            count = self.dataService.folderList?.count ?? 0
        }
        return count
    }
    
    func rowCount(for section:Int) -> Int{
        let count:Int
        switch self.splitViewStyle {
        case .triple:
            count = self.dataService.folderList?.count ?? 0
        default:
            if section.isInRangeOf(maxValue: sectionItemCount) {
                count = self.dataService.folderList?[section].subFolder.count ?? 0
            } else {
                count = 0
            }
        }
        return count
    }
    
    func header(for section: Int) -> String? {
        let text:String?
        switch self.splitViewStyle {
        case .triple:
            text = nil
        default:
            text = self.dataService.folderList?[section].folderName
        }
        return text
    }
    
    subscript(indexPath: IndexPath)-> String? {
        let text:String?
        switch self.splitViewStyle {
        case .triple:
            if let mainFolderListCount = self.dataService.folderList?.count ,
               mainFolderListCount > 0,
               indexPath.row.isInRangeOf(maxValue: mainFolderListCount)  {
                text = self.dataService.folderList?[indexPath.row].folderName
            } else {
                text = nil
            }
            
        default:
            text = self.dataService.folderList?[indexPath.section].subFolder[indexPath.row].folderName
        }
        return text
    }
    
    
    private func getMainFolder(for indexPath: IndexPath)-> String? {
        guard indexPath.section.isInRangeOf(maxValue: sectionItemCount) else { return nil}
        
        let text:String?
        switch self.splitViewStyle {
        case .triple:
               if let mainFolderListCount = self.dataService.folderList?.count ,
               mainFolderListCount > 0,
               indexPath.row.isInRangeOf(maxValue: mainFolderListCount)  {
                text = self.dataService.folderList?[indexPath.row].folderName
               } else {
                    text = nil
               }
        default:
            text = self.dataService.folderList?[indexPath.section].folderName
            
        }
        return text
        
    }
    
    private func getSubFolder(for indexPath: IndexPath) -> String? {
        guard indexPath.row.isInRangeOf(maxValue: self.rowCount(for: indexPath.section)) else {
            return nil
        }
        return self.dataService.folderList?[indexPath.section].subFolder[indexPath.row].folderName
    }
    
    func itemSelected(at indexPath:IndexPath) -> (String?,String?) {
        
        let mainFolder = getMainFolder(for: indexPath)
        
        switch self.splitViewStyle {
        case .triple:
            return (mainFolder, nil)
        default:
            let subFolder = getSubFolder(for: indexPath)
            return (mainFolder, subFolder)
        }
    }
    
    func fetchData(){
        self.dataService.fetchData()
    }
}

// MARK: - Add new method for range check to Int.
extension Int {
    
    /// Check if the integer within the bounds
    /// or range of the maximum value provided.
    func isInRangeOf(maxValue: Int) -> Bool {
        return (0..<maxValue) ~= self
    }
    
}
