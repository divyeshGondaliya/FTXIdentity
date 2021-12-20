//
//  RetailerTableViewCell.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 17/12/21.
//

import UIKit
import SwiftyJSON
import SkeletonView

class RetailerTableViewCell: UITableViewCell {

    @IBOutlet weak var img_store: UIImageView!
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var lbl_subtitle: UILabel!
    @IBOutlet weak var img_status: UIImageView!
    @IBOutlet weak var lbl_status: UILabel!
    
    @IBOutlet weak var lbl_store_name_sort: UILabel!
    @IBOutlet weak var view_no_img: UIView!
    
    @IBOutlet weak var btn_share_unshare_press: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureForSkeletonView()
    {
        self.img_store.isSkeletonable = true
        self.lbl_title.isSkeletonable = true
        self.lbl_subtitle.isSkeletonable = true
        self.img_status.isSkeletonable = true
        self.lbl_status.isSkeletonable = true
        self.lbl_store_name_sort.isSkeletonable = true
        self.view_no_img.isSkeletonable = true
        self.view_no_img.isHidden = true
        self.img_store.showAnimatedGradientSkeleton()
        self.lbl_title.showAnimatedGradientSkeleton()
        self.lbl_subtitle.showAnimatedGradientSkeleton()
        self.img_status.showAnimatedGradientSkeleton()
        self.lbl_status.showAnimatedGradientSkeleton()
        self.lbl_store_name_sort.showAnimatedGradientSkeleton()
        self.view_no_img.showAnimatedGradientSkeleton()
    }

    func configureCell(dic:[String:JSON])
    {
        let logoUrl = dic["logoUrl"]?.string ?? ""
        if logoUrl.count > 0
        {
            self.view_no_img.isHidden = true
            if let url = URL(string: logoUrl)
            {
                self.img_store.kf.setImage(with: url)
            }
        }else{
            self.view_no_img.isHidden = false
            self.lbl_store_name_sort.text = dic["companyName"]?.string?.getFirstLetterOfTwoString().uppercased()
        }
        self.lbl_title.text = dic["companyName"]?.string
        self.lbl_subtitle.text = dic["applicationName"]?.string
        self.lbl_status.text = dic["identityShared"]?.bool ?? false ? "Unshare":"Share Identity"
        self.lbl_status.textColor = dic["identityShared"]?.bool ?? false ? #colorLiteral(red: 1, green: 0.5176470588, blue: 0.5019607843, alpha: 1):#colorLiteral(red: 0, green: 0.4588235294, blue: 1, alpha: 1)
        self.img_status.image = dic["identityShared"]?.bool ?? false ? UIImage(named: "unshare"):UIImage(named: "shareIdentity")
        self.img_status.tintColor = dic["identityShared"]?.bool ?? false ? #colorLiteral(red: 1, green: 0.5176470588, blue: 0.5019607843, alpha: 1):#colorLiteral(red: 0, green: 0.4588235294, blue: 1, alpha: 1)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
