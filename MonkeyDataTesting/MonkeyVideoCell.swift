//
//  MonkeyVideoCell.swift
//  MonkeyDataTesting
//
//  Created by Gregory Weiss on 7/24/17.
//  Copyright © 2017 gergusa. All rights reserved.
//

import UIKit

class MonkeyVideoCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var monkeyImageView: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
