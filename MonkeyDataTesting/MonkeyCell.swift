//
//  MonkeyCell.swift
//  MonkeyDataTesting
//
//  Created by Gregory Weiss on 7/24/17.
//  Copyright © 2017 gergusa. All rights reserved.
//

import UIKit

class MonkeyCell: UITableViewCell {
    
    @IBOutlet weak var monkeyImageView: UIImageView!
    
    @IBOutlet weak var monkeyLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
