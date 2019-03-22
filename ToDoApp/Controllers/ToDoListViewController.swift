//
//  ViewController.swift
//  ToDoApp
//
//  Created by Xia Tran on 19/03/2019.
//  Copyright © 2019 Xia Tran. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
  
  //itemArray is an array of Item objects
  var itemArray = [Item]()
  
 // let defaults = UserDefaults.standard
  //userDomainMask is the users directory. it's an array so get first position
  let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
  
  //print(dataFilePath)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //newItem will be a new object from the class Item
//    let newItem = Item()
//    newItem.title = "find mike"
//    itemArray.append(newItem)
//
//    let newItem2 = Item()
//    newItem2.title = "find pop"
//    itemArray.append(newItem2)
//
//    let newItem3 = Item()
//    newItem3.title = "find hih"
//    itemArray.append(newItem3)
//
    //the userDefaults array with the plist containing persisting data updated from the new itemArray objects to be set to the now old itemArray
//        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
//          itemArray = items
//        }
    loadItems()
  }
  
  //MARK: - table view methods
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return itemArray.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
    
    let currentItem = itemArray[indexPath.row]
    
    cell.textLabel?.text = currentItem.title
    
    //using ternaty operators:
    //value = condition ? valueIfTrue : ValueIfFalse
    cell.accessoryType = currentItem.done ? .checkmark : .none
    //if the itemArray.done is true, it will make a checkmark, if not, no checkmark
//    if currentItem.done == true {
//      cell.accessoryType = .checkmark
//    } else {
//      cell.accessoryType = .none
//    }
    
    return cell
  }

  //MARK: - tableView Delegate Methods
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        //print(itemArray[indexPath.row])
    
    //code is the same as the if else statement, below - using bool, reversing the .done property
    itemArray[indexPath.row].done = !itemArray[indexPath.row].done
    //when clicking the row, if item.done is false, the .done will now be true and a .checkmark will appear.
//    if itemArray[indexPath.row].done == false {
//      itemArray[indexPath.row].done = true
//    } else {
//      itemArray[indexPath.row].done = false
//    }
    saveItems()
    
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
      
      let newItemToBeAdded = Item()
      newItemToBeAdded.title = textField.text!
      
      //add new text to array and reload list to update
      self.itemArray.append(newItemToBeAdded)
      
      self.saveItems()
    }
    
    //give the alert box an option to choose
    alert.addAction(action)
    //present the alert
    present(alert, animated: true, completion: nil)
  }
  
  //MARK: - Model Manipulation Methods
  
  func saveItems() {
    
    let encoder = PropertyListEncoder()
    //encode the itemArray into the propertyListEncoder() to make the plist
    do {
      let data = try encoder.encode(itemArray)
      try data.write(to: dataFilePath!)
    } catch {
      print("Error encoding item Array - \(error.localizedDescription)")
    }
    
    //saving the updated itemArray using UserDefaults with the key 'ToDoListArray' in the plist
    //self.defaults.setValue(self.itemArray, forKey: "ToDoListArray")
    self.tableView.reloadData()
  }
  
  func loadItems() {
    //using decodable to call the data from the plist and upload
      if let data = try? Data(contentsOf: dataFilePath!) {
      let decoder = PropertyListDecoder()
        do {
          itemArray = try decoder.decode([Item].self, from: data)
        } catch {
          print("Error decoding item: \(error.localizedDescription)")
        }
      }
  }
  
  
  
}

