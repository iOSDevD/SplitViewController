//
//  MainFolderViewModelWithSplitStyleDoubleTests.swift
//  SplitViewControllerExampleTests
//
//  Created by iOSDev on 7/14/21.
//

import XCTest

class MainFolderViewModelWithSplitStyleDoubleTests: XCTestCase {

    var mockedDataService: MockedDataService!
    var sut: MainFolderViewModelHandler!
    

    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockedDataService = MockedDataService()
        sut = MainFolderViewModelHandler(dataService: mockedDataService, style: .double)
        sut.fetchData()
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mockedDataService = nil
        sut = nil
    }

    func testSectionCountEqualsToMainFolderCount() {
        
        let expectedFolderSectionCount = 2
        XCTAssertTrue(sut.sectionItemCount == expectedFolderSectionCount, "Section Count for SplitViewStyle.double should be equal to number of main folders")
    }
    
    func testRowCountForEachSection() {
        
        let expectedFoldersInFirstSectionCount = 3
        let expectedFoldersInSecondSectionCount = 4
        
        XCTAssertTrue(sut.rowCount(for: 0) == expectedFoldersInFirstSectionCount, "Expected Row Count for first section is \(expectedFoldersInFirstSectionCount)")
        
        XCTAssertTrue(sut.rowCount(for: 1) == expectedFoldersInSecondSectionCount, "Expected Row Count for second section is \(expectedFoldersInSecondSectionCount)")
        
    }
    
    func testHeaderForEachSection() {
        let expectedHeaderForFirstSection = "test-Images"
        let expectedHeaderForSecondSection = "test-Text"
        
        XCTAssertTrue(sut.header(for: 0) == expectedHeaderForFirstSection, "Expected Header for first section \(expectedHeaderForFirstSection)")
        
        XCTAssertTrue(sut.header(for: 1) == expectedHeaderForSecondSection, "Expected Header for first section \(expectedHeaderForFirstSection)")
        
    }

    func testSubFolderNameForValidIndexPath() {
        let invalidFolderPath = IndexPath(row: 0, section: 0)
        let result = sut[invalidFolderPath]
        XCTAssertTrue(result == "2010" ,"Expected Sub Folder Name for Valid index Path, but found \(result)")
    }
    
    func testSubFolderSelection_With_ValidIndexPaths(){
        let paths = [IndexPath(row: 0, section: 0):("test-Images","2010"),
                     IndexPath(row: 1, section: 0):("test-Images","2009"),
                     IndexPath(row: 2, section: 0):("test-Images","2008")]
        
        for path in paths {
            let result = sut.itemSelected(at: path.key)
            XCTAssertTrue(result == path.value)
        }
    }
    
    func testSubFolderSelection_With_InvalidSection(){
        let path = IndexPath(row: 0, section: 9)
        let result = sut.itemSelected(at: path)
        XCTAssertTrue(result == (nil,nil),"Expected mainFolder and subfolder as nil, found \(result)")
    }
    
    func testSubFolderSelection_With_InvalidRow(){
        let path = IndexPath(row: 10, section: 0)
        let result = sut.itemSelected(at: path)
        XCTAssertTrue(result == ("test-Images",nil),"Expected mainFolder as non-nil while subfolder should be nil \(result)")
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
