//
//  ToDoItemViewModelTests.swift
//  ToDoListMVVMTests
//
//  Created by Prem Budhwani on 28/08/20.
//  Copyright © 2020 Winds. All rights reserved.
//

import XCTest
import CoreData
@testable import ToDoListMVVM

class ToDoItemViewModelTests: XCTestCase {
    var viewModel : ToDoItemViewModel!
    var dataSource : GenericDataSource<ToDoItem>!
    
    override func setUp() {
        super.setUp()
        self.dataSource = GenericDataSource<ToDoItem>()
        self.viewModel = ToDoItemViewModel(dataSource: dataSource)
    }
    
    override func tearDown() {
        self.viewModel = nil
        self.dataSource = nil
        super.tearDown()
    }
    
    
    //Unit test case for fetching ToDoIems list
    func testFetchToDoItems() {
        XCTAssertNotNil(viewModel.fetchToDoItems(), "Expected non-nil value returned from Core Data")
    }
}
