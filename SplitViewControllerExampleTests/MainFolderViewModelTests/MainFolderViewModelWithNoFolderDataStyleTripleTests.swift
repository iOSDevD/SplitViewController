//
//  MainFolderViewModelWithNoFolderData.swift
//  SplitViewControllerExampleTests
//
//  Created by iOSDev on 7/18/21.
//

import XCTest
@testable import SplitViewControllerExample

class MainFolderViewModelWithNoFolderData: XCTestCase {

    var mockedDataService: MockedDataService!
    var sut: MainFolderViewModelHandler!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockedDataService = MockedDataService(fileName: "NoFolderDataRandomeFileName")
        sut = MainFolderViewModelHandler(dataService: mockedDataService, style: .triple)
        sut.fetchData()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mockedDataService = nil
        sut = nil
    }

    func testSectionCountZero() {
        XCTAssertTrue(sut.sectionItemCount == 0, "Section Count Should be zero if there is no folder data")
    }
    
    func testRowCountZero() {
        XCTAssertTrue(sut.rowCount(for: 0) == 0, "Row Count Should be zero if there is no folder data")
    }


}
