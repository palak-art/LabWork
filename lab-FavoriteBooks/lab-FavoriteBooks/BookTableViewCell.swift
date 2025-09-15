//
//  BookTableViewCell.swift
//  lab-FavoriteBooks
//
//  Created by Himanshi Godara on 26/08/25.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var lengthLabel: UILabel!
    
    @IBOutlet weak var genreLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func update(with book: Book) {
          titleLabel.text = book.title
          genreLabel.text = "Author: \(book.author)"
          genreLabel.text = "Genre: \(book.genre)"
          lengthLabel.text = "Length: \(book.length)"
      }

}
