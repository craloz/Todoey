//
//  ViewController.swift
//  Todoey
//
//  Created by Carlos Lozano on 1/13/19.
//  Copyright © 2019 Carlos Lozano. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
  
  let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
  
  var itemArray = [Item]()

  override func viewDidLoad() {
    super.viewDidLoad()
    loadItems()
//    if let items = defaults.array(forKey: "ToDoListArray") as? [Item]{
//      itemArray = items
//    }
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
    
    self.saveItems()
    
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
      
      self.saveItems()
      
    }
    
    alert.addTextField { (alertTextField) in
      alertTextField.placeholder = "Create new Item"
      textField = alertTextField
    }
    
    alert.addAction(action)
    
    present(alert, animated: true, completion: nil)
    
  }
  
  func saveItems(){
    
    let encoder = PropertyListEncoder()
    
    
    do{
      let data = try encoder.encode(itemArray)
      try data.write(to: dataFilePath!)
    }catch{
      print("Error encoding item array, \(error)")
    }
    
    self.tableView.reloadData()
    
  }
  
  func loadItems(){
    if let data = try? Data(contentsOf: dataFilePath!){
      let decoder = PropertyListDecoder()
      do{
        itemArray = try decoder.decode([Item].self, from: data)
      }catch{
        print("Error decoding item array, \(error)")
      }
    }
  }
  
}

