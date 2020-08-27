//
//  ToDoItemsListViewController.swift
//  ToDoListMVVM
//
//  Created by Prem Budhwani on 27/08/20.
//  Copyright © 2020 Winds. All rights reserved.
//

import UIKit

class ToDoItemsListViewController: UIViewController , ToDoItemDataSourceUpdateDelegate , AddNewToDoItemViewControllerDelegate , UISearchBarDelegate{

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource = ToDoItemDataSource()
    
    var filterText = ""             //Variable to hold the Filter text. By default keep it blank
    
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
        self.searchBar.delegate = self
    }

    @IBAction func addButtonTapped(_ sender: Any) {
        //Remove any filter applied
        self.cancelSearchOperation()
        
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
    
    //MARK: UISearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filterText = searchText
        self.RefreshItemsList()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.cancelSearchOperation()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //Just dismiss the keyboard
        self.view.endEditing(true)
    }
    
    //Method to cancel the search operation
    func cancelSearchOperation()
    {
        //Dismiss the keyboard and remove any filter and refresh list
        self.view.endEditing(true)
        self.searchBar.text = ""
        self.filterText = ""
        self.RefreshItemsList()
    }
    
    //Method to refresh the listing
    func RefreshItemsList()
    {
        if (self.filterText.isEmpty)
        {
            self.viewModel.fetchToDoItems()
        }
        else
        {
            self.viewModel.fetchFilteredToDoItems(filterString: self.filterText)
        }
        
        self.tableView.reloadData()
    }
}

