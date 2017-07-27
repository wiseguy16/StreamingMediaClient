//
//  ResultsCell.swift
//  MonkeyDataTesting
//
//  Created by Gregory Weiss on 7/27/17.
//  Copyright © 2017 gergusa. All rights reserved.
//

import UIKit

class ResultsCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var deskriptLabel: UILabel!
    
    @IBOutlet weak var resultImageView: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
