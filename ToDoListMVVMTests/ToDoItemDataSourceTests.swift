//
//  ToDoItemDataSourceTests.swift
//  ToDoListMVVMTests
//
//  Created by Prem Budhwani on 28/08/20.
//  Copyright © 2020 Winds. All rights reserved.
//

import XCTest
import CoreData
@testable import ToDoListMVVM

class ToDoItemDataSourceTests: XCTestCase {
    var dataSource : ToDoItemDataSource!
    
    override func setUp() {
        super.setUp()
        dataSource = ToDoItemDataSource()
    }
    
    override func tearDown() {
        dataSource = nil
        super.tearDown()
    }
    
    //Unit test case for empty datasource
    func testEmptyValueInDataSource() {
        
        // giving empty data value
        dataSource.data.value = []
        
        let tableView = UITableView()
        tableView.dataSource = dataSource
        
        // expected one section
        XCTAssertEqual(dataSource.numberOfSections(in: tableView), 1, "Expected one section in table view")
        
        // expected zero cells
        XCTAssertEqual(dataSource.tableView(tableView, numberOfRowsInSection: 0), 0, "Expected no cell in table view")
    }
    
    
    //Unit test case for two items in datasource
    func testValueInDataSource() {
        // giving data value
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        if let itemEntity = NSEntityDescription.insertNewObject(forEntityName: "ToDoItem", into: context) as? ToDoItem {
            itemEntity.itemTitle = "One"
            itemEntity.itemDescription = "First Item"
            itemEntity.isChecked = false
            dataSource.data.value.append(itemEntity)
        }
        
        if let itemEntity = NSEntityDescription.insertNewObject(forEntityName: "ToDoItem", into: context) as? ToDoItem {
            itemEntity.itemTitle = "Two"
            itemEntity.itemDescription = "Second Item"
            itemEntity.isChecked = false
            dataSource.data.value.append(itemEntity)
        }
        
        let tableView = UITableView()
        tableView.dataSource = dataSource
        
        // expected one section
        XCTAssertEqual(dataSource.numberOfSections(in: tableView), 1, "Expected one section in table view")
        
        // expected two cells
        XCTAssertEqual(dataSource.tableView(tableView, numberOfRowsInSection: 0), 2, "Expected two cell in table view")
    }
    
    //Unit test case for registered UITableViewCell
    func testValueCell() {
        
        // giving data value
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        if let itemEntity = NSEntityDescription.insertNewObject(forEntityName: "ToDoItem", into: context) as? ToDoItem {
            itemEntity.itemTitle = "One"
            itemEntity.itemDescription = "First Item"
            itemEntity.isChecked = false
            dataSource.data.value.append(itemEntity)
        }
        
        let tableView = UITableView()
        tableView.dataSource = dataSource
        tableView.register(ToDoItemTableViewCell.self, forCellReuseIdentifier: "ToDoItemTableViewCell")
        
        let indexPath = IndexPath(row: 0, section: 0)
        
        // expected ToDoItemTableViewCell class
        guard let _ = dataSource.tableView(tableView, cellForRowAt: indexPath) as? ToDoItemTableViewCell else {
            XCTAssert(false, "Expected ToDoItemTableViewCell class")
            return
        }
    }
}
