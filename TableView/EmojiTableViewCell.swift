//
//  EmojiTableViewCell.swift
//  TableView
//
//  Created by Himanshi Godara on 25/08/25.
//

import UIKit

class EmojiTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameSymbol: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(with emoji: Emoji){
        symbolLabel.text = emoji.symbol
        nameSymbol.text = emoji.name
        descriptionLabel.text = emoji.description
    }

}
