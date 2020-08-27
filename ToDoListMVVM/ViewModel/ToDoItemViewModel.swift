//
//  ToDoItemViewModel.swift
//  ToDoListMVVM
//
//  Created by Prem Budhwani on 27/08/20.
//  Copyright © 2020 Winds. All rights reserved.
//

import UIKit
import CoreData

//class ToDoItemViewModel: NSObject {
struct ToDoItemViewModel {
    weak var dataSource : GenericDataSource<ToDoItem>?
    
    init(dataSource : GenericDataSource<ToDoItem>?) {
        self.dataSource = dataSource
    }
    
    func fetchToDoItems() {
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: ToDoItem.self))
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "isChecked", ascending: true)]
        do {
            let arrItems  = try context.fetch(fetchRequest) as! [ToDoItem]
            self.dataSource?.data.value = arrItems
        } catch let error {
            print("ERROR FETCHING CATEGORIES : \(error)")
        }
    }
    
    func updateViewModelCheckedStateFor(row:Int , state:Bool)
    {
        self.dataSource?.data.value[row].isChecked = state
        CoreDataStack.sharedInstance.saveContext()
    }
}
