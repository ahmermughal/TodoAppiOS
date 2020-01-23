//
//  CategoryViewController.swift
//  TodoApp
//
//  Created by Ahmer Mughal on 22/01/2020.
//  Copyright © 2020 iDevelopStudio. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categoryList = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate)
       .persistentContainer.viewContext

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
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            self.categoryList.append(newCategory)
            
            self.saveCategory()
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
        cell.textLabel?.text = categoryList[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let selectedindexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryList[selectedindexPath.row]
        }
        
    }
    
    //MARK: - Data Manipulation Methods
    func saveCategory(){
           do {
               try context.save()
           }catch {
               print("Error saving context \(error)")
           }
           tableView.reloadData()
       }
    
    func loadCategory(with request : NSFetchRequest<Category> = Category.fetchRequest()){
           do{
                categoryList = try context.fetch(request)
           }catch{
               print("Error fetching data from context \(error)")
           }
           tableView.reloadData()
       }

}
