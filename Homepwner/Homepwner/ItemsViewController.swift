//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by bmiit on 20/04/22.
//

import UIKit
class ItemsViewController : UITableViewController
{
    var itemStore: ItemStore!
    
    override func viewDidLoad()
    {
        super.viewDidLoad( )
        // Get the height of the status bar
//        let statusBarHeight = UIApplication.shared.statusBarFrame.height
//        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
//        tableView.contentInset = insets
//        tableView.scrollIndicatorInsets = insets
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 65
    }
    
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
    
//        let lastRow = tableView.numberOfRows(inSection: 0)
//        let indexPath = IndexPath(row: lastRow, section: 0)
//        tableView.insertRows(at: [indexPath], with: .automatic)
        
        let newItem = itemStore.createItem()
        if let index = itemStore.allItems.index(of: newItem) {
             let indexPath = IndexPath(row: index, section: 0)
             tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
//    @IBAction func toggleEditingMode(_ sender: UIButton) {
//        if isEditing {
//            sender.setTitle("Edit", for: .normal)
//            setEditing(false, animated: true)
//        } else {
//            sender.setTitle("Done", for: .normal)
//            setEditing(true, animated: true)
//        }
//    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            let item = itemStore.allItems[indexPath.row]
            let title = "Delete \(item.name)?"
            
            let message = "Are you sure you want to delete this item?"
            let ac = UIAlertController(title: title, message: message,preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style:.cancel,handler: nil)
            ac.addAction( cancelAction)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) -> Void in
                self.itemStore.removeItem(item)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            ac.addAction(deleteAction)
            present(ac, animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //  let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        //let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath) as UITableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell

        let item = itemStore.allItems[indexPath.row]
//        cell.textLabel?.text = item.name
//        cell.detailTextLabel?.text = "$\(item.valueInDollars)"
        
        cell.nameLabel.text = item.name
        cell.serialNumberLabel.text = item.serialNumber
        cell.valueLabel.text = "$\(item.valueInDollars)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showItem"?:
       
        if let row = tableView.indexPathForSelectedRow?.row
        {
            let item = itemStore.allItems[row]
            let detailViewController =
                    segue.destination as! DetailViewController
            detailViewController.item = item
        }
        default:
            preconditionFailure("Unexpected segue identifier")
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        navigationItem.leftBarButtonItem = editButtonItem
    }
}
