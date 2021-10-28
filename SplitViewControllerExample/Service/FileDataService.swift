//
//  FileDataService.swift
//  SplitViewControllerExample
//
//  Created by iOSDev on 5/20/21.
//

import Foundation

/// File Service to read data from the
/// json File, in this case it will read the
/// data from fileData.json and deserialize
/// into decodable Folder object.
class FileDataService: DataService {
    
    /// File name which has the required data
    let dataFileName = "fileData"
    
    private(set) var folderList: [Folder]? // Folder list object is read only
    
    
    func fetchData() { // Fetch data from the json file.
        
        guard let filePath = Bundle.main.path(forResource: dataFileName, ofType: "json") else {
            return
        }
        let url = URL(fileURLWithPath: filePath)
        
        guard let data = try? Data(contentsOf: url) else {
            return
        }
        folderList = try? JSONDecoder().decode([Folder].self, from: data)
    }
}
