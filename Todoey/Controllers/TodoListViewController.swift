import UIKit
//import CoreData
import RealmSwift
import ChameleonFramework

class TodoListViewController: SwipeTableViewController {

//    var itemArray = [Item]()
    
    var todoItems : Results<Item>?
    var realm = try! Realm()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    //    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    //using UserDefaults
    //let defaults = UserDefaults.standard
    
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }

//CoreData
  //  let context = (UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
  
  //  let context = AppDelegate().persistentContainer.viewContext
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
      //  dump("this is itemArray \(todoItems)")
        
  //      dump("this is context \(context)")
        
       // print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))

//ex
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
    } //end of viewDidLoad()

    
   //If let "Optional biding"
    //        if let colorHex = selectedCategory?.color {
    //
    //            title = selectedCategory!.name
    //
    //            guard let navBar = navigationController?.navigationBar else {fatalError("navigation controller does not exist") }
    //
    //
    //            if let navBarColour = UIColor(hexString: colorHex) {
    //
    //                navBar.barTintColor = navBarColour
    //
    //                navBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: ContrastColorOf(navBarColour, returnFlat: true)]
    //
    //                searchBar.barTintColor = navBarColour
    //
    //                navBar.tintColor = ContrastColorOf(navBarColour, returnFlat: true)
    //
    //
    //            }
    //
    //
    //        }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        title = selectedCategory?.name

        guard let colorHex = selectedCategory?.color  else {fatalError(" ") }
        
        updateNavBar(withHexCode: colorHex)
 
//before making updateNavBar
//        guard let navBar = navigationController?.navigationBar else {fatalError("navigation controller does not exist") }
        
//        guard let navBarColour = UIColor(hexString: colorHex) else { fatalError("")}
//
//        navBar.barTintColor = navBarColour
//
//        navBar.tintColor = ContrastColorOf(navBarColour, returnFlat: true)
//
//        navBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: ContrastColorOf(navBarColour, returnFlat: true)]
//        //
//
//        searchBar.barTintColor = navBarColour
        
        
        }
    
    override func viewWillDisappear(_ animated: Bool) {

//before making updateNavBar
//        guard let originalColor = UIColor(hexString: "1D9BF6") else { fatalError()}
        
//        navigationController?.navigationBar.barTintColor = originalColor
//
//        navigationController?.navigationBar.tintColor = FlatWhite()
//
//        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: FlatWhite()]
        
        updateNavBar(withHexCode: "1D9BF6")
    }

    
    //MARK: - Nav Bar Setup Methods
    
    func updateNavBar(withHexCode colorHexCode:String) {
        
        guard let navBar = navigationController?.navigationBar else {fatalError("navigation controller does not exist") }
        
        guard let navBarColour = UIColor(hexString: colorHexCode) else { fatalError("")}
        
        navBar.barTintColor = navBarColour
        
        navBar.tintColor = ContrastColorOf(navBarColour, returnFlat: true)
        
        navBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: ContrastColorOf(navBarColour, returnFlat: true)]
        //
        
        searchBar.barTintColor = navBarColour
        
        
    }
    
        
    
    
    
    
    //MARK: TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }

//CoreData
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//          //let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
//
//          let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
//
//          let item = itemArray[indexPath.row]
//
//          cell.textLabel?.text = item.title
//
//       //  print(item.title)
//          //Ternary operator
//          // value = condition ? valueIfTrue : valueIfFalse
//
//         //cell.accessoryType = item.done == true ? .checkmark : .none
//         // same line without "== true"
//
//          cell.accessoryType = item.done ? .checkmark : .none
//
//        //same line to the line above
////            if item.done == true {
////                cell.accessoryType = .checkmark
////            } else {
////                cell.accessoryType = .none
////            }
//
//            dump("cellForRowAt")
//
//          return cell
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        
        
        //before inherite swipe function from superClass
        //let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let item = todoItems?[indexPath.row] {
            
            cell.textLabel?.text = item.title
            
            
            
          //  let cellColor: String? = todoItems?[indexPath.row].color
            
          //  let convertedColor = hexStringToUIColor(hex: cellColor ?? "111111")
            
       //     print("this is convertedColor \(convertedColor)")
            
// preview lines before optional binding
//            cell.backgroundColor = FlatSkyBlue().darken(byPercentage:
//
//                //currently on row #1.
//                //there's a total of 10 items in todoItems
//
//                CGFloat(indexPath.row / todoItems?.count)
//            )

// with optional binding
            
            if let color = UIColor(hexString: selectedCategory!.color)?.darken(byPercentage: CGFloat(indexPath.row) /  CGFloat(todoItems!.count))
//
//            if let color = FlatRed().darken(byPercentage: CGFloat(indexPath.row) /  CGFloat(todoItems!.count))
            
             //    if let color = cellColor.darken(byPercentage: CGFloat(indexPath.row) /  CGFloat(todoItems!.count))
             
                 // if let color = convertedColor
                
                
// integer / integer = sometimes below 1 always 0
               
            {
            
                cell.backgroundColor = color
                cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
              
                
//figure out type casting error from integer ro float
                print("this is indexpath.row  \(indexPath.row)")
                print("this is todoItem!.count  \(todoItems!.count)")
                print("this is indexpath.row/todoItem!.count \(indexPath.row / todoItems!.count)")
                print("this is Float / float \(CGFloat(indexPath.row) /  CGFloat(todoItems!.count))")
                print("this is color in totoIteam \(color)")
            
           
            }
            

            
            //  print(item.title)
            //Ternary operator
            // value = condition ? valueIfTrue : valueIfFalse
            
            //cell.accessoryType = item.done == true ? .checkmark : .none
            // same line without "== true"
            
            cell.accessoryType = item.done ? .checkmark : .none
            
        } else {
            cell.textLabel?.text = "No Item Added"
        }
        
        
        
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
       
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write {
                    //delete
                   // realm.delete(item)
                    // update
                    item.done = !item.done
                }
            } catch {
                print("Error saving sone status, \(error)")
            }
            
        }
       
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
      //  print(itemArray[indexPath.row].title)
        
//        itemArray[indexPath.row].setValue("Completed", forKey: "title"); ~other funtionality
    //  todoItems[indexPath.row].done = !todoItems[indexPath.row].done
        
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        }

   //     saveItems()
        
        self.tableView.reloadData()
        
        dump("didSelectRowAT")
        
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        } else {
//             tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        
       tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Delete Data From Swipe
    override func updateModel(at indexPath: IndexPath) {
        if let item = self.todoItems?[indexPath.row] {
            do {
                try self.realm.write {
                    //delete
                    self.realm.delete(item)
                    // update
                    //item.done = !item.done
                }
            } catch {
                print("Error saving sone status, \(error)")
            }
        }
    }
    
    
    //MARK: Add New Item
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen once the user presses Add Item button on our UIalert
            
//CoreData
//            let newItem = Item(context: self.context)
//
//           // dump("this is newItem \(newItem)")
//
//            //let newItem = Item() ~ an error occurs 'not to be able to initialized'
//
//            // let dfdf = Item
//
//            newItem.title = textField.text!
//
//            newItem.done = false
//
//            newItem.parentCategory = self.selectedCategory
//
//           // dump("this is parentCategory \(newItem.parentCategory)")
//
//            self.itemArray.append(newItem)
       
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = Item()
                        
                         //newItem.timeIn = NSDate(timeIntervalSinceNow: formatter)
                        
                       // newItem.timeIn = formatter.dateFormat as! NSDate
//                        newItem.timeIn = NSDate(timeIntervalSince1970: TimeInterval(myTimeInterval as! NSDate))
                        
                        newItem.title = textField.text!
                        newItem.timeIn = Date()
                        
                        currentCategory.items.append(newItem)
                       // self.realm.add(newItem)
                    }
                }
                catch {
                    print("Error saving new items, \(error)")
                }
            }
            
//why does it not work?
//            do {
//                try self.realm.write {
//                    self.realm.add(item)
//                }
//            } catch {
//                print("Error saving item \(error)")
//            }
//
            
    
          // self.saveItems()
            
//            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
            
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
    
//    func saveItems() {
//        do {
//
//            try context.save()
//
//        } catch {
//            print("Error saving context \(error)")
//        }
//        self.tableView.reloadData()
//
//    }
    
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
    //coreDate
//    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
//
//        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
//
//        if let additionalPredicate = predicate {
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
//        } else {
//            request.predicate = categoryPredicate
//        }
//
//       // dump("this is request  \(request.predicate)")
//
////        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,predicate])
////
////        request.predicate = compoundPredicate
//
//        // let request : NSFetchRequest<Item> = Item.fetchRequest()
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

    
    func loadItems() {
        
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
//        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
//
//        if let additionalPredicate = predicate {
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
//        } else {
//            request.predicate = categoryPredicate
//        }
//
//        // dump("this is request  \(request.predicate)")
//
//        //        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,predicate])
//        //
//        //        request.predicate = compoundPredicate
//
//        // let request : NSFetchRequest<Item> = Item.fetchRequest()
//
//        do {
//            itemArray =  try context.fetch(request)
//
//            //  print("request from loadItem \(request)")
//
//        } catch {
//            print("Error fetching data from context \(error)")
//        }
        
        tableView.reloadData()
    }
    
 
    
    

    
    
    
    
} //class end here

//MARK: Search bar methods

//CoreData
extension TodoListViewController: UISearchBarDelegate {
//
//   func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//
////        //fetching data
////CoreData
//
//    //        let request : NSFetchRequest<Item> = Item.fetchRequest()
//    //
//    //        request.predicate  = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//    //
//    //        // print("predicate \(predicates)") ~"let predicate" used to be here
//    //        //print("request.predicate is \(request.predicate)")
//    //
//    //        //arraging in acsending order
//    //        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//    //
//    //        //print("request.sortDescriptor is \(request.sortDescriptors)")
//    //
//    //        //putting into new search result
//    //        loadItems(with: request)
//    //          loadItem(with: request, predicate: predicate)
//
//
//
//
//    }
//
//
//
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

//        //fetching data
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//
//        // print("predicate \(predicates)") ~"let predicate" used to be here
//        //print("request.predicate is \(request.predicate)")
//
////arraging in acsending order
//         request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//
////print("request.sortDescriptor is \(request.sortDescriptors)")
//
//
//        //putting into new search result
//            loadItems(with: request, predicate: predicate)
        
        
        
        //Realm
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "timeIn", ascending: true)
        
        tableView.reloadData()
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

