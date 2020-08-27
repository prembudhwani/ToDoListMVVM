//
//  ToDoItemDataSource.swift
//  ToDoListMVVM
//
//  Created by Prem Budhwani on 27/08/20.
//  Copyright © 2020 Winds. All rights reserved.
//

import Foundation
import UIKit

class GenericDataSource<T> : NSObject {
    var data: DynamicValue<[T]> = DynamicValue([])
}

protocol ToDoItemDataSourceUpdateDelegate {
    func dataSourceItemCheckBoxUpdated(state: Bool, indexPath: IndexPath)
}

class ToDoItemDataSource : GenericDataSource<ToDoItem>, UITableViewDataSource , ToDoItemTableViewCellDelegate{
    
    var dataSourceUpdateDelegate : ToDoItemDataSourceUpdateDelegate?
    
    //MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemTableViewCell", for: indexPath) as! ToDoItemTableViewCell
        
        let toDoItem = self.data.value[indexPath.row]
        cell.toDoItem = toDoItem
        cell.indexPath = indexPath
        cell.delegate = self
        return cell
    }
    
    //MARK: ToDoItemTableViewCellDelegate
    func itemCheckBoxTapped(state: Bool, indexPath: IndexPath) {
        if (self.dataSourceUpdateDelegate != nil)
        {
            self.dataSourceUpdateDelegate?.dataSourceItemCheckBoxUpdated(state: state, indexPath: indexPath)
        }
    }
}
