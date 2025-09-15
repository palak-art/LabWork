//
//  BookTableViewController.swift
//  lab-FavoriteBooks
//
//  Created by Himanshi Godara on 26/08/25.
//

import UIKit

class BookTableViewController: UITableViewController {

    var books: [Book] = []

        override func viewDidLoad() {
            super.viewDidLoad()
            title = "Favorite Books"
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                                target: self,
                                                                action: #selector(addBook))
        }

        @objc func addBook() {
            performSegue(withIdentifier: "AddBookSegue", sender: self)
        }

        // MARK: - Table view data source
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return books.count
        }

        override func tableView(_ tableView: UITableView,
                                cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell",
                                                     for: indexPath) as! BookTableViewCell
            let book = books[indexPath.row]
            cell.update(with: book)
            return cell
        }

        // Swipe to delete
        override func tableView(_ tableView: UITableView,
                                commit editingStyle: UITableViewCell.EditingStyle,
                                forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                books.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }

        // Unwind segue
        @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
            if let sourceVC = segue.source as? BookFormTableViewController,
               let book = sourceVC.createdBook {
                books.append(book)
                tableView.reloadData()
            }
        }
}
