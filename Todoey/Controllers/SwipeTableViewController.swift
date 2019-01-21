//
//  SwipeTableViewController.swift
//  Todoey
//
//  Created by MyMac on 2019-01-16.
//  Copyright © 2019 Apex. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
          tableView.rowHeight = 80.0
        
        tableView.separatorStyle = .none
       
    }
    
    //Mark: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
        
        cell.delegate = self
        
        return cell
    }
    
    //MARK: - Swipe Cell Delegate Methods
    
        func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
            guard orientation == .right else { return nil }
            
            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
                // handle action by updating model with deletion
                
                print("Item deleted")
                
                
//these lines went to <func updateModel>'s subclass
//                if let item = self.categoryArray?[indexPath.row] {
//                    do {
//                        try self.realm.write {
//                            //delete
//                            self.realm.delete(item)
//                            // update
//                            //item.done = !item.done
//                        }
//                    } catch {
//                        print("Error saving sone status, \(error)")
//                    }
//                }
                self.updateModel(at: indexPath)
                
                //  self.tableView.reloadData()
                
            }
            
            // customize the action appearance
            deleteAction.image = UIImage(named: "delete-icon")
            
            return [deleteAction]
        }
        
        //    func collectionView(_ collectionView: UICollectionView, editActionsOptionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        //        var options = SwipeOptions()
        //        options.expansionStyle = .destructive
        //    //    options.transitionStyle = .border
        //        return options
        //    }
        //
    
        func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
            var options = SwipeTableOptions()
            options.expansionStyle = .destructive
            return options
        }
    
    
    func updateModel(at indexPath:IndexPath) {
        //Update data model
    }
    

    
}
