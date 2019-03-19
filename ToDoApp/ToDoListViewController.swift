//
//  ViewController.swift
//  ToDoApp
//
//  Created by Xia Tran on 19/03/2019.
//  Copyright © 2019 Xia Tran. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
  
  var itemArray = ["do this 1", "do this 2", "do this 3"]
  
  let defaults = UserDefaults.standard
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    if let items = defaults.array(forKey: "ToDoListArray") as? [String] {
      itemArray = items
    }
  }
  
  //MARK: - table view methods
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return itemArray.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
    
    cell.textLabel?.text = itemArray[indexPath.row]
    
    return cell
  }

  //MARK: - tableView Delegate Methods
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    //print(itemArray[indexPath.row])
    if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
      tableView.cellForRow(at: indexPath)?.accessoryType = .none
    } else {
      //gives a checkmark using the accessoryType
      tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    //highlights and then deselects the selected row
    tableView.deselectRow(at: indexPath, animated: true)
    
  }

  //MARK: - Add New Items To List
  
  @IBAction func addButton(_ sender: UIBarButtonItem) {
    
    var textField = UITextField()
    
    let alert = UIAlertController(title: "Add a new ToDo Item to your list", message: "", preferredStyle: .alert)
    
    //in the alert box, a text field is there. has a placeholder. prints the text.
    alert.addTextField { (alertTextField) in
      alertTextField.placeholder = "Create new item"
      textField = alertTextField
    }
    
    //the option given - add item, if selected, will print success
    let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
      print(textField.text!)
      print("success")
      
      //add new text to array and reload list to update
      self.itemArray.append(textField.text!)
      
      self.defaults.setValue(self.itemArray, forKey: "ToDoListArray")
      
      self.tableView.reloadData()
    }
    


    
    //give the alert box an option to choose
    alert.addAction(action)
    
    //present the alert
    present(alert, animated: true, completion: nil)
  }
  
}

