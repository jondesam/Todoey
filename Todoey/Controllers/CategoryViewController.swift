//
//  CategoryViewController.swift
//  Todoey
//
//  Created by MyMac on 2018-12-31.
//  Copyright © 2018 Apex. All rights reserved.
//

import UIKit
//import CoreData
import RealmSwift
//import SwipeCellKit
import  ChameleonFramework

class CategoryViewController: SwipeTableViewController  {
    
    let realm = try! Realm()

//CoreData
//    var categoryArray = [Category]()
    var categoryArray: Results<Category>?
    
//CoreData
//  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
        
      
    }
    

    //MARK: - TeableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //if categoryArray is nill, return 1 -- Nil Coalescing Operator
        return categoryArray?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
// when SwipeCell functions were in extention
//        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! SwipeTableViewCell
//
// cell.delegate = self
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        var newColorString = ""

        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No Categories added yet"

        newColorString = categoryArray?[indexPath.row].color ?? "1D9BF6"

        cell.backgroundColor = UIColor(hexString: newColorString)
        
         print("newColorString is \(newColorString) ")
      
        //shortend version
        
//        if let category = categoryArray?[indexPath.row] {
//            cell.textLabel?.text = category.name
//
//             cell.backgroundColor = UIColor(hexString: category.color ?? "1D9BF6")
//
//        }
        
   
        

        
        return cell
    }
    
    //MARK: - Data Manipulation Methods
//CoreData
//    func saveCategory() {
//        do {
//        try context.save()
//        } catch {
//            print("Error saving context \(error)")
//        }
//        self.tableView.reloadData()
//    }
    
    func save(category: Category ) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving category \(error)")
            }
        
        tableView.reloadData()
    }
    
//CoreData
//    func loadCategory(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
//
//        do {
//           categoryArray = try  context.fetch(request)
//        } catch {
//            print("Error fetching data from context \(error)")
//        }
//
//        tableView.reloadData()
//    }
     
    func loadCategories() {
        
        categoryArray = realm.objects(Category.self)
      //   newColor = newColorOfCategory.color
        
        tableView.reloadData()
        
    }
    
    //MARK: - Delete Data From Swipe
    override func updateModel(at indexPath: IndexPath) {
        if let item = self.categoryArray?[indexPath.row] {
            do {
                try self.realm.write {
                    //delete
                    self.realm.delete(item)
            }
            } catch {
                print("Error saving sone status, \(error)")
            }
        }
    }
    
    //MARK: - Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
       
        var textField = UITextField()
        
//      newColor = newColorOfCategory.color
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Cotegory", style: .default) { (action) in
         
        //CoreData
        //let newCategory = Category(context: self.context)
        //
        let newCategory = Category()
        newCategory.name = textField.text!
            
        newCategory.color = UIColor.randomFlat.hexValue()
            

//CoreData
//    self.categoryArray.append(newCategory)
            
//        self.saveCategory()
            
        self.save(category: newCategory)
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Write new category"
        
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: - TAbleView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         let destinationVC = segue.destination as! TodoListViewController
        
         if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray?[indexPath.row]
            print("this is destinationVC \(destinationVC)")
         }
        }
}

    

