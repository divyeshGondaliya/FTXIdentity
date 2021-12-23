//
//  BiometricInfoTableViewCell.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 23/12/21.
//

import UIKit

class BiometricInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var img_view: UIImageView!
    @IBOutlet weak var img_verified: UIImageView!
    @IBOutlet weak var lbl_verified: UILabel!
    @IBOutlet weak var lbl_for_what: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
