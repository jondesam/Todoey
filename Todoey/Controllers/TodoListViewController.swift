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
        newItem2.title = "buy eggs"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "get a job"
        itemArray.append(newItem3)
        
      
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
           itemArray = items
        }
    }

    //: TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
          //let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        
          let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
          let item = itemArray[indexPath.row]
    
          cell.textLabel?.text = item.title
        
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
        
            print("cellForRowAt")
        
          return cell
    }
    
    //: TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
      //  print(itemArray[indexPath.row].title)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        }

        self.tableView.reloadData()
        
        print("didSelectRowAT")
        
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        } else {
//             tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //: Add New Item
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen once the user presses Add Item button on our UIalert
            
            let newItem = Item()
            
                newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
          //  self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Write new things to do"
           
            textField = alertTextField
            
        }
        
        alert.addAction(action)

        present(alert, animated: true, completion: nil)
    }
}

