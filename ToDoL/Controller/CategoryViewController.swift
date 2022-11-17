//
//  CategoryViewContollerTableViewController.swift
//  ToDoL
//
//  Created by IVZ on 10.11.2022.
//

import UIKit
import RealmSwift


class CategoryViewController: SwipeTableViewController {
    var categories: Results<Category>?
    let realm = try! Realm()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
        
        tableView.rowHeight = 60
        
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        var textField = UITextField()
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            // what will happen once the user clicks the add
            
            let newItem = Category()
            newItem.name = textField.text!
            self.save(category: newItem)
        }
        
        alert.addTextField { alertTextFIeld in
            alertTextFIeld.placeholder = "create new Item"
            textField = alertTextFIeld
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    //MARK: - TableView Data Source Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories"
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories? [indexPath.row]
        }
    }
    
    //MARK: - Data Manipulation Methods
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("error saving context\(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategories() {
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    //Delete Section
    override func updateModel(at indexPath: IndexPath) {
        if  let selectedCell = self.categories?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(selectedCell)
                }
            } catch {
                print("error saving context\(error)")
            }
        }
    }
}


