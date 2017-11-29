//
//  customTableViewCell.swift
//  iNotify
//
//  Created by Meseret  Kebede on 28/11/2017.
//  Copyright © 2017 Team Erica. All rights reserved.
//

import UIKit

class customTableViewCell: UITableViewCell {

    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
