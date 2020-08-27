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
    
    //Method to fetch all the ToDoItems from CoreData
    func fetchToDoItems() {
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: ToDoItem.self))
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "isChecked", ascending: true)]
        do {
            let arrItems  = try context.fetch(fetchRequest) as! [ToDoItem]
            self.dataSource?.data.value = arrItems
        } catch let error {
            print("ERROR FETCHING ToDoItems : \(error)")
        }
    }
    
    //Method to update the checkbox state (i.e. isChecked) of a ToDoItem of the given row
    func updateViewModelCheckedStateFor(row:Int , state:Bool)
    {
        self.dataSource?.data.value[row].isChecked = state
        CoreDataStack.sharedInstance.saveContext()
    }
    
    //Method to get the filtered list of ToDoItems based on given filter title
    func fetchFilteredToDoItems(filterString : String) {
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: ToDoItem.self))
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "isChecked", ascending: true)]
        fetchRequest.predicate = NSPredicate(format: "itemTitle contains[c] %@", filterString)
        do {
            let arrItems  = try context.fetch(fetchRequest) as! [ToDoItem]
            self.dataSource?.data.value = arrItems
        } catch let error {
            print("ERROR FETCHING Filtered ToDoItems : \(error)")
        }
    }
}
