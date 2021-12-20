//
//  ListOfShareOptionCell.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 20/12/21.
//

import UIKit

class ListOfShareOptionCell: UITableViewCell {

    @IBOutlet weak var lbl_rules: UILabel!
    @IBOutlet weak var btn_switch: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
