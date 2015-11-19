//
//  SentMemesTableViewCell.swift
//  MemeMe
//
//  Created by Curtis Ford on 10/19/15.
//  Copyright © 2015 Sona Software LLC. All rights reserved.
//

import UIKit

class SentMemesTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    
    override func awakeFromNib() {

        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
