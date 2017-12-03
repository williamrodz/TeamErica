//
//  analyticsTableViewCell.swift
//  iNotify
//
//  Created by Meseret  Kebede on 03/12/2017.
//  Copyright © 2017 Team Erica. All rights reserved.
//

import UIKit

class analyticsTableViewCell: UITableViewCell {

    @IBOutlet weak var analyticsDataCell: UIView!
    @IBOutlet weak var analyticsLabel: UILabel!
    @IBOutlet weak var analyticsButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
