//
//  ToDoItemTableViewCell.swift
//  ToDoListMVVM
//
//  Created by Prem Budhwani on 27/08/20.
//  Copyright © 2020 Winds. All rights reserved.
//

import UIKit

protocol ToDoItemTableViewCellDelegate {
    func itemCheckBoxTapped(state:Bool , indexPath:IndexPath)
}

class ToDoItemTableViewCell: UITableViewCell {

    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var checkBoxButton: UIButton!
    
    var delegate : ToDoItemTableViewCellDelegate?
    var indexPath : IndexPath?
    
    var toDoItem : ToDoItem? {
        didSet {
            
            guard let toDoItem = toDoItem else {
                return
            }
            
            titleLabel?.text = toDoItem.itemTitle
            descriptionLabel?.text = toDoItem.itemDescription
            checkBoxButton.isSelected = toDoItem.isChecked
            
            //Gray out the cell if checkbox is selected
            outerView.backgroundColor = (checkBoxButton.isSelected ? UIColor.gray : UIColor.clear)
            
//            //Once an item is checked, don't allow it to be unchecked.
            checkBoxButton.isUserInteractionEnabled = !checkBoxButton.isSelected
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func checkBoxButtonTapped(_ sender: Any) {
        self.checkBoxButton.isSelected = !self.checkBoxButton.isSelected
        
        if (self.delegate != nil && self.indexPath != nil)
        {
            self.delegate?.itemCheckBoxTapped(state: self.checkBoxButton.isSelected, indexPath: self.indexPath!)
        }
    }
}
