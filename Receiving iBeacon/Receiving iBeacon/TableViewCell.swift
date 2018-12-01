//
//  TableViewCell.swift
//  Receiving iBeacon
//
//  Created by Ben Woo on 1/12/18.
//  Copyright © 2018 Ben Woo. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var major: UILabel!
    @IBOutlet weak var minor: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var background: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
