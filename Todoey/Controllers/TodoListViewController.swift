//
//  ViewController.swift
//  Todoey
//
//  Created by Carlos Lozano on 1/13/19.
//  Copyright © 2019 Carlos Lozano. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
  
  
  
  var itemArray = [Item]()
  
  let defaults = UserDefaults.standard

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let newItem = Item()
    newItem.title = "Find Mike"
    itemArray.append(newItem)
    
    let newItem2 = Item()
    newItem2.title = "Buy Eggos"
    itemArray.append(newItem2)
    
    let newItem3 = Item()
    newItem3.title = "Destroy Demogorgon"
    itemArray.append(newItem3)

    if let items = defaults.array(forKey: "ToDoListArray") as? [Item]{
      itemArray = items
    }
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return itemArray.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
    
    let item = itemArray[indexPath.row]
    
    cell.textLabel?.text = item.title
    
    cell.accessoryType = item.done ?  .checkmark : .none
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //print(itemArray[indexPath.row])
    itemArray[indexPath.row].done = !itemArray[indexPath.row].done
    
    tableView.reloadData()
    tableView.deselectRow(at: indexPath, animated: true)
  }

  //MARK - ADD NEW ITEMS
  
  @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    
    var textField = UITextField()
    
    let alert = UIAlertController(title: "Add new Todoey Item", message: "", preferredStyle: .alert)
    
    let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
      //what will happen once the user clicks the Add Item button on our UIAlert
      let newItem = Item()
      newItem.title = textField.text!
      self.itemArray.append(newItem)
      
      self.defaults.setValue(self.itemArray, forKey: "ToDoListArray")
      self.tableView.reloadData()
    }
    
    alert.addTextField { (alertTextField) in
      alertTextField.placeholder = "Create new Item"
      textField = alertTextField
    }
    
    alert.addAction(action)
    
    present(alert, animated: true, completion: nil)
    
  }
  
}

