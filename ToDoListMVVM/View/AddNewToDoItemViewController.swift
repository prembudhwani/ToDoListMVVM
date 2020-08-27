//
//  AddNewToDoItemViewController.swift
//  ToDoListMVVM
//
//  Created by Prem Budhwani on 27/08/20.
//  Copyright © 2020 Winds. All rights reserved.
//

import UIKit
import CoreData

protocol AddNewToDoItemViewControllerDelegate {
    func newItemAddedSuccesfully()
}

class AddNewToDoItemViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var delegate : AddNewToDoItemViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Add New Item"
        self.descriptionTextView.layer.borderColor = UIColor.gray.cgColor
        self.descriptionTextView.layer.borderWidth = 1.0
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func saveButtonTapped(_ sender: Any) {
        self.view.endEditing(true)
        if (self.titleTextField.text!.isEmpty || self.descriptionTextView.text.isEmpty)
        {
            let controller = UIAlertController(title: "Empty Fields", message: "Please enter values for the given fields.", preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(controller, animated: true, completion: nil)
            return
        }
        
        self.saveToDoItem()
    }
    
    //Method to save the entered values to Core Data
    func saveToDoItem()
    {
        guard createToDoItemEntityFrom() != nil else {
            let controller = UIAlertController(title: "Item not created", message: "Can not create to do item.", preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(controller, animated: true, completion: nil)
            return
        }
        CoreDataStack.sharedInstance.saveContext()
        
        if (self.delegate != nil)
        {
            self.delegate?.newItemAddedSuccesfully()
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    //Method to create a ToDoIem entity in Core Data
    private func createToDoItemEntityFrom() -> NSManagedObject? {
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        if let itemEntity = NSEntityDescription.insertNewObject(forEntityName: "ToDoItem", into: context) as? ToDoItem {
            itemEntity.itemTitle = self.titleTextField.text
            itemEntity.itemDescription = self.descriptionTextView.text
            itemEntity.isChecked = false            //By default keep it false
            return itemEntity
        }
        return nil
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
}
