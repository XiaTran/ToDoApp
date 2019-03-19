//
//  ViewController.swift
//  ToDoApp
//
//  Created by Xia Tran on 19/03/2019.
//  Copyright © 2019 Xia Tran. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

  let itemArray = ["do this 1", "do this 2", "do this 3"]
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
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

}

