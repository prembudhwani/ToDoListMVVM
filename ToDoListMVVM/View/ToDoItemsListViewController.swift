//
//  ToDoItemsListViewController.swift
//  ToDoListMVVM
//
//  Created by Prem Budhwani on 27/08/20.
//  Copyright © 2020 Winds. All rights reserved.
//

import UIKit

class ToDoItemsListViewController: UIViewController , ToDoItemDataSourceUpdateDelegate , AddNewToDoItemViewControllerDelegate{

    @IBOutlet weak var tableView: UITableView!
    
    var dataSource = ToDoItemDataSource()
    
    lazy var viewModel : ToDoItemViewModel = {
        dataSource.dataSourceUpdateDelegate = self
        let viewModel = ToDoItemViewModel(dataSource: dataSource)
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "To Do List"
        
        self.tableView.dataSource = self.dataSource
        self.dataSource.data.addAndNotify(observer: self) { [weak self] _ in
            self?.tableView.reloadData()
        }
        
        self.viewModel.fetchToDoItems()
        
//        DispatchQueue.main.asyncAfter(deadline: .now()+20) {
//            let objTemp = self.dataSource.data.value[0]
//            objTemp.itemTitle = "HHHH"
//            self.dataSource.data.value[0] = objTemp
//        }
    }

    @IBAction func addButtonTapped(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "AddNewToDoItemVC") as! AddNewToDoItemViewController
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
 
    //MARK: ToDoItemDataSourceUpdateDelegate
    func dataSourceItemCheckBoxUpdated(state: Bool, indexPath: IndexPath) {
        self.viewModel.updateViewModelCheckedStateFor(row: indexPath.row, state: state)
        self.RefreshItemsList()
    }
    
    //MARK: AddNewToDoItemViewControllerDelegate
    func newItemAddedSuccesfully() {
        self.RefreshItemsList()
    }
    
    //Method to refresh the listing
    func RefreshItemsList()
    {
        self.viewModel.fetchToDoItems()
        self.tableView.reloadData()
    }
}

