//
//  ViewController.swift
//  TASK IT
//
//  Created by bmiit on 24/03/22.
//

import UIKit

class ToDoController: UITableViewController {

    
    var itemArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItem",for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
        var updatedtextfield = UITextField()
        let itemselected = itemArray[indexPath.row]
        let updatealert = UIAlertController(title: "Edit item", message: "Edit the selected item", preferredStyle: .alert)
        let cancelAlert = UIAlertAction(title: "Cancel", style: .cancel)
        let updateaction = UIAlertAction(title: "Update", style: .default){ (updateaction)  in
            let updateditem = updatedtextfield.text!
            self.itemArray[indexPath.row] = updateditem
            self.tableView.reloadData()
        }
        updatealert.addTextField{ (alertTextField) in
            alertTextField.placeholder = "create new task"
            updatedtextfield = alertTextField
            print(updatedtextfield.text)
            
        }
        
        updatealert.addAction(updateaction)
        updatealert.addAction(cancelAlert)
        present(updatealert, animated: true, completion: nil)
        
   
    }
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Task", message: "Enter new task detail", preferredStyle: .alert)
        let cancelAlert = UIAlertAction(title: "Cancel", style: .cancel)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action)  in
            print(textField.text)
            self.itemArray.append(textField.text!)
            self.tableView.reloadData()
        }
        
        alert.addTextField{ (alertTextField) in
            alertTextField.placeholder = "create new task"
            textField = alertTextField
            print(alertTextField.text)
            print("now")
        }
        
        alert.addAction(action)
        alert.addAction(cancelAlert)
        present(alert, animated: true, completion: nil)
    }
    
    
}
extension ToDoController    {
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete)
        {
            self.itemArray.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
    }
}
