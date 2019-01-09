import UIKit
import CoreData

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
//    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    //using UserDefaults
    //let defaults = UserDefaults.standard
    
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
  
  //  let context = AppDelegate().persistentContainer.viewContext
        
    override func viewDidLoad() {
        super.viewDidLoad()
        dump("this is itemArray \(itemArray)")
        dump("this is context \(context)")
        
       // print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
//        let newItem = Item()
//        newItem.title = "Find Mike"
//        itemArray.append(newItem)
//
//        let newItem2 = Item()
//        newItem2.title = "buy eggs"
//        itemArray.append(newItem2)
//
//        let newItem3 = Item()
//        newItem3.title = "get a job"
//        itemArray.append(newItem3)
        
      //  loadItems()
    
      
//        print("item list is \([Item].ti)")
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//           itemArray = items
//        }
    }

    //MARK: TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
          //let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        
          let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
          let item = itemArray[indexPath.row]
    
          cell.textLabel?.text = item.title
        
       //  print(item.title)
          //Ternary operator
          // value = condition ? valueIfTrue : valueIfFalse
        
         //cell.accessoryType = item.done == true ? .checkmark : .none
         // same line without "== true"
        
          cell.accessoryType = item.done ? .checkmark : .none
        
        //same line to the line above
//            if item.done == true {
//                cell.accessoryType = .checkmark
//            } else {
//                cell.accessoryType = .none
//            }
        
            dump("cellForRowAt")
        
          return cell
    }
    
    //MARK: TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
       
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
      //  print(itemArray[indexPath.row].title)
        
//        itemArray[indexPath.row].setValue("Completed", forKey: "title"); ~other funtionality
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        }

        saveItems()
        
      //  self.tableView.reloadData()
        
        dump("didSelectRowAT")
        
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        } else {
//             tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        
       tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: Add New Item
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen once the user presses Add Item button on our UIalert
            
            let newItem = Item(context: self.context)
            dump("this is newItem \(newItem)")
            
            //let newItem = Item() ~ an error occurs 'not to be able to initialized'
           
            // let dfdf = Item
            
            newItem.title = textField.text!
            
            newItem.done = false
            
            newItem.parentCategory = self.selectedCategory
            
            dump("this is parentCategory \(newItem.parentCategory)")
            
            self.itemArray.append(newItem)
            
            self.saveItems()
            
//            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
        //    self.tableView.reloadData()
            
        }
        
    
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Write new things to do"
           
            textField = alertTextField
            
        }
        
        alert.addAction(action)

        present(alert, animated: true, completion: nil)
        
    
    }
    
    
    //MARK: Model Manupulation Methods
    
    //:NSCoder
//    func saveItems() {
//        let encoder = PropertyListEncoder()
//
//        do {
//            let data = try encoder.encode(itemArray)
//            try data.write(to: dataFilePath!)
//            //try data.write(to: self.dataFilePath!)
//        } catch {
//            print("Error encoding item array, \(error)")
//
//        }
//
//        self.tableView.reloadData()
//    }
//
//
//    func loadItems() {
//       if  let data = try? Data(contentsOf: dataFilePath!){
//            let decoder = PropertyListDecoder()
//            do {
//                itemArray = try decoder.decode([Item].self, from: data)
//            }catch {
//                print("Error decoding item array, \(error) ")
//            }
//        }
//    }
    
    func saveItems() {
        do {
            
            try context.save()
            
        } catch {
            print("Error saving context \(error)")
        }
        self.tableView.reloadData()
        
    }
    
    //fetching data
    //1st
    //searchBar does't work with this original code
//    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()) {
//
//        let predicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
//
//        request.predicate = predicate
//
//       // let request : NSFetchRequest<Item> = Item.fetchRequest()
//
//        do {
//            itemArray =  try context.fetch(request)
//
//          //  print("request from loadItem \(request)")
//
//        } catch {
//            print("Error fetching data from context \(error)")
//        }
//
//        tableView.reloadData()
//    }
    
   //2th
//    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
//
//       let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
//
//          request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,predicate!])
//
//
//        print("this is request \(request.predicate)")
////       let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,predicate!])
////
////        request.predicate = compoundPredicate
//
//         //let request : NSFetchRequest<Item> = Item.fetchRequest()
//
//
//        do {
//            itemArray =  try context.fetch(request)
//
//            //  print("request from loadItem \(request)")
//
//        } catch {
//            print("Error fetching data from context \(error)")
//        }
//
//        tableView.reloadData()
//    }
    
    //3rd
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {

        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)

        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
        } else {
            request.predicate = categoryPredicate
        }

        dump("this is request  \(request.predicate)")
        
//        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,predicate])
//
//        request.predicate = compoundPredicate

        // let request : NSFetchRequest<Item> = Item.fetchRequest()

        do {
            itemArray =  try context.fetch(request)

            //  print("request from loadItem \(request)")

        } catch {
            print("Error fetching data from context \(error)")
        }

        tableView.reloadData()
    }

    
    
} //class end here

//MARK: Search bar methods

extension TodoListViewController: UISearchBarDelegate {
    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//
//        //fetching data
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//
//        request.predicate  = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//
//        // print("predicate \(predicates)") ~"let predicate" used to be here
//        //print("request.predicate is \(request.predicate)")
//
//        //arraging in acsending order
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//
//        //print("request.sortDescriptor is \(request.sortDescriptors)")
//
//
//        //putting into new search result
//        loadItems(with: request)
//    }
    
    

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        //fetching data
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        // print("predicate \(predicates)") ~"let predicate" used to be here
        //print("request.predicate is \(request.predicate)")
        
//arraging in acsending order
         request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        
//print("request.sortDescriptor is \(request.sortDescriptors)")

    
        //putting into new search result
            loadItems(with: request, predicate: predicate)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       if searchBar.text?.count == 0 {
            loadItems()
        
        DispatchQueue.main.async {
              searchBar.resignFirstResponder()
        }
        
        
        }
    }
    
}


