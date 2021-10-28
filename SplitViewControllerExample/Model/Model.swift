//
//  Model.swift
//  SplitViewControllerExample
//
//  Created by iOSDev on 5/19/21.
//

import Foundation

/// Folder object which represents
/// fodlername and sub Folder object array.
/// The structure is Decodable hence can be used
/// with JSON deserilization directly.
struct Folder:Decodable {
    var folderName:String
    var subFolder:[SubFolder]
}

/// Sub Folder with a name and list of
/// available files.
/// The structure is Decodable hence can be used
/// with JSON deserilization directly.
struct SubFolder: Decodable {
    var folderName:String
    var fileNames:[String]
}
