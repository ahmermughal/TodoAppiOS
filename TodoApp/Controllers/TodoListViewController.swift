//
//  ViewController.swift
//  TodoApp
//
//  Created by Ahmer Mughal on 18/01/2020.
//  Copyright © 2020 iDevelopStudio. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        let newItem = Item()
        newItem.title = "Apple"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Orange"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Mango"
        itemArray.append(newItem3)
        
        let newItem4 = Item()
        newItem4.title = "Grape"
        itemArray.append(newItem4)
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
                   itemArray = items
               }
    }
    
    //MARK - TableView Data Source Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableReuseID", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        cell.accessoryType =  itemArray[indexPath.row].done == true ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //Mark - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = itemArray[indexPath.row].done == false ? true : false
        
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }else{
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()

    }
    
    //MARK - DIALOG Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todo Item", message: "Testing", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // code when user clicks Add Item
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
                
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}



