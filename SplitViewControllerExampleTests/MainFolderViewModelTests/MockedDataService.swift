//
//  MockedDataService.swift
//  SplitViewControllerExampleTests
//
//  Created by iOSDev on 7/14/21.
//

import Foundation

/// Mock Data service to be used while testing.
/// It uses different file name for testing purpose.
class MockedDataService: DataService {
    var folderList: [Folder]?

    let dataFileName: String //= "MainFolderVM_fileData"
    
    init(fileName: String = "MainFolderVM_fileData") {
        self.dataFileName = fileName
    }
    
    func fetchData() {
        let bundlePath = Bundle(for: MockedDataService.self)
        print("Bundle Path \(Bundle(for: MockedDataService.self))")
     
        guard let filePath = bundlePath.path(forResource: dataFileName, ofType: "json") else {
            return
        }
        let url = URL(fileURLWithPath: filePath)
        
        guard let data = try? Data(contentsOf: url) else {
            return
        }
        folderList = try? JSONDecoder().decode([Folder].self, from: data)
    }
}
