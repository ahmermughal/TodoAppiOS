//
//  CategoryViewController.swift
//  TodoApp
//
//  Created by Ahmer Mughal on 22/01/2020.
//  Copyright © 2020 iDevelopStudio. All rights reserved.
//

import UIKit
import RealmSwift
class CategoryViewController: UITableViewController {

    var categoryList: Results<Category>?
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategory()
    }

    //MARK: - Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todo Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // code when user clicks Add Item
            
            let newCategory = Category()
            newCategory.name = textField.text!
            
            self.saveCategory(category: newCategory)
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
   
    
    //MARK: - TableView Datasource Methods

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categoryList?[indexPath.row].name ?? "No Categories Added!"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList?.count ?? 1
    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let selectedindexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryList?[selectedindexPath.row]
        }
        
    }
    
    //MARK: - Data Manipulation Methods
    func saveCategory(category: Category){
           do {
            try realm.write {
                realm.add(category)
            }
           }catch {
               print("Error saving context \(error)")
           }
           tableView.reloadData()
       }
    
    func loadCategory(){
        categoryList = realm.objects(Category.self)
        tableView.reloadData()
    }

}
