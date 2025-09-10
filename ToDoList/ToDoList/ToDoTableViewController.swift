//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by Himanshi Godara on 07/09/25.
//

import UIKit

class ToDoTableViewController: UITableViewController, ToDoCellDelegate {
    func checkmarkTapped(sender: ToDoCellTableViewCell) {
        if let indexPath = tableView.indexPath (for: sender) {

        var toDo = toDos[indexPath.row]

        toDo.isComplete.toggle()

        toDos[indexPath.row] = toDo

            tableView.reloadRows(at: [indexPath], with: .automatic)
            ToDo.saveToDos(toDos)

        }
    }
    

    
    var toDos = [ToDo]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let savedTodos = ToDo.loadToDos(){
            toDos = savedTodos
        }else{
            toDos = ToDo.loadSampleToDos()
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return toDos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCellIdentifier", for: indexPath) as! ToDoCellTableViewCell
        cell.delegate = self
        
        
        let toDo = toDos[indexPath.row]
//        var content = cell.defaultContentConfiguration();
//        content.text = toDo.title
//        cell.contentConfiguration = content
        
        cell.titleLabel?.text=toDo.title
        
        cell.isCompleteButton.isSelected=toDo.isComplete
        // Configure the cell...

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            toDos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            ToDo.saveToDos(toDos)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    
    
    @IBSegueAction func editToDo(_ coder: NSCoder, sender: Any?) -> ToDoDetailTableViewController? {
        let detailController = ToDoDetailTableViewController(coder: coder)
         guard let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) else { return detailController }
        
        tableView.deselectRow(at: indexPath, animated: true)
        detailController?.toDo = toDos[indexPath.row]
        return detailController
       
    }
    
    @IBAction func unwindToToDoList(segue: UIStoryboardSegue){
        guard segue.identifier == "saveUnwind" else { return }
        let sourceViewController = segue.source as!
        ToDoDetailTableViewController
        
        
        
        if let toDo = sourceViewController.toDo {
            if let indexOfExistingToDo = toDos.firstIndex(of: toDo){
                toDos[indexOfExistingToDo] = toDo
                tableView.reloadRows(at: [IndexPath(row:indexOfExistingToDo, section: 0)], with: .automatic)
            } else {
                let newIndexPath = IndexPath(row: toDos.count, section: 0)
                toDos.append (toDo)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
        ToDo.saveToDos(toDos)
    }

    
    
 
    
   
//    @IBSegueAction func editToDo(_ coder: NSCoder, sender: Any?) -> ToDoDetailTableViewController? {
//        let detailController = ToDoDetailTableViewController(coder: coder)
//         guard let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) else { return detailController }
//        
//        tableView.deselectRow(at: indexPath, animated: true)
//        detailController?.toDo = toDos[indexPath.row]
//        return detailController
//    }
    
        
        
        
        
//        
//    @IBSegueAction func editToDo(_ coder: NSCoder, sender: Any?) -> ToDoDetailTableViewController? {
//              let detailController = ToDoDetailTableViewController(coder: coder)
//                 guard let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) else { return detailController }
//        
//                tableView.deselectRow(at: indexPath, animated: true)
//                detailController?.toDo = toDos[indexPath.row]
//                return detailController
//    }
        
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
