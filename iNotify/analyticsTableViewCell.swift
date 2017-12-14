//
//  analyticsTableViewCell.swift
//  iNotify
//
//  Created by Meseret  Kebede on 03/12/2017.
//  Copyright © 2017 Team Erica. All rights reserved.
//
//  This is a UITableViewCell Object. Allows us to reuse this framework of a cell throughout our Analytics Table Views whien creating the cells programatically. 
//

import UIKit

class analyticsTableViewCell: UITableViewCell {

    @IBOutlet weak var analyticsDataCell: UIView!
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
