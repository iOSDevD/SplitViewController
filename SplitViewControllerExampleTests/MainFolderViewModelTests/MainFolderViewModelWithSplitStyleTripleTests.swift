//
//  MainFolderViewModelTests.swift
//  SplitViewControllerExampleTests
//
//  Created by iOSDev on 5/21/21.
//

import XCTest
@testable import SplitViewControllerExample

class MainFolderViewModelWithSplitStyleTripleTests: XCTestCase {
    
    var mockedDataService: MockedDataService!
    var sut: MainFolderViewModelHandler!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.s
        
        mockedDataService = MockedDataService()
        sut = MainFolderViewModelHandler(dataService: mockedDataService, style: .triple)
        sut.fetchData()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mockedDataService = nil
        sut = nil
    }

    func testSectionCountIsOne() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertTrue(sut.sectionItemCount == 1, "Section Count for SplitViewStyle.triple should be 1")
    }
    
    func testRowCountIsValid() {
        XCTAssertTrue(sut.rowCount(for: 0) == 2, "Row Count for SplitViewStyle.triple is equal to number of folders in the list")
    }
    
    func testRowCountIsIndependentOfSectionIndex() {
        let expectedRowCount = 2
        
        let sectionIndexToTest = [0,20]
        sectionIndexToTest.forEach { index in
            XCTAssertTrue(sut.rowCount(for: index) == expectedRowCount, "Row Count for SplitViewStyle.triple is independent of section count as there is only one section")
        }
        
    }
    
    func testSectionHeaderIsEmpty() {
        XCTAssertNil(sut.header(for:0), "Section Title is empty for SplitViewStyle.triple")
    }
    
    func testFolderNameForIndexPath() {
        let imageFolderPath = IndexPath(row: 0, section: 0)
        let textFolderPath = IndexPath(row: 1, section: 0)
        let inputPathAndExpectedResult = [(imageFolderPath,"test-Images"),(textFolderPath,"test-Text")]
        inputPathAndExpectedResult.forEach { (inputPath, folderName) in
            XCTAssertTrue(sut[inputPath] == folderName,"Expected main Folder Name is `\(folderName)`")
        }
    }
    
    func testFolderNameForInvalidIndexPath() {
        let invalidFolderPath = IndexPath(row: 20, section: 0)
        XCTAssertNil(sut[invalidFolderPath],"Folder Name for Invalid indexpath should be nil")
    }
    
    func testMainFolderSelected_With_ValidIndexPath() {
        let selectedIndexPath = IndexPath(row: 0, section: 0)
        let (folderName,subFolderName) = sut.itemSelected(at: selectedIndexPath)
        XCTAssertTrue(folderName=="test-Images","Folder Name for item selected at indexPath 0,0 should be `test-Images`")
        XCTAssertNil(subFolderName,"Sub-Folder Name for item selected at indexPath 0,0 should be nil")
    }
    
    func testMainFolderSelected_With_InValidRow() {
        let selectedIndexPath = IndexPath(row: 20, section: 0)
        let (folderName,subFolderName) = sut.itemSelected(at: selectedIndexPath)
        XCTAssertNil(folderName,"Folder Name for item selected at invalid IndexPath should be nil")
        XCTAssertNil(subFolderName,"Sub-Folder Name for item selected at invalid IndexPath should be nil")
    }
    
    func testMainFolderSelected_With_InValidSection() {
        let selectedIndexPath = IndexPath(row: 0, section: 20)
        let (folderName,subFolderName) = sut.itemSelected(at: selectedIndexPath)
        XCTAssertNil(folderName,"Folder Name for item selected at invalid IndexPath should be nil")
        XCTAssertNil(subFolderName,"Sub-Folder Name for item selected at invalid IndexPath should be nil")
    }

}
