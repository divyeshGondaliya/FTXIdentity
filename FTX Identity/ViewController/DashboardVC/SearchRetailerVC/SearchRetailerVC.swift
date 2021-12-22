//
//  SearchRetailerVC.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 17/12/21.
//

import UIKit
import SwiftyJSON

class SearchRetailerVC: MainStuffViewController {

    @IBOutlet weak var img_no_data: UIImageView!
    @IBOutlet weak var tbl_view: UITableView!
    @IBOutlet weak var txt_search_retailer: UITextField!
    @IBOutlet weak var leading_search: NSLayoutConstraint!
    @IBOutlet weak var dummy_tbl_view: UITableView!
    @IBOutlet weak var lbl_search_retailer: UILabel!
    
    var totalPages = 0
    var pageIndex = 1
    var pagesize = 10
    var hasNextPage = false
    var itemToDisplay = [[String:JSON]]()
    var vcForMemberShip = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.img_no_data.isHidden = true
        if vcForMemberShip
        {
            self.lbl_search_retailer.text = "Membership"
            self.txt_search_retailer.placeholder = "Search Membership"
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tbl_view.register(UINib(nibName: "RetailerTableViewCell", bundle: nil), forCellReuseIdentifier: "RetailerTableViewCell")
        self.dummy_tbl_view.register(UINib(nibName: "RetailerTableViewCell", bundle: nil), forCellReuseIdentifier: "RetailerTableViewCell")
        
        self.setupApiParamToinitVal()
        self.getRetailer(search: "")
        self.setupUiStuff()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.view.endEditing(true)
    }

    @IBAction func btn_search_cancel_press(_ sender: Any) {
        self.hideSearch()
        self.setupApiParamToinitVal()
        self.getRetailer(search: "")
    }
    @IBAction func btn_search_press(_ sender: Any) {
        self.showSearch()
    }
    @IBAction func btn_back_press(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SearchRetailerVC
{
    func setupApiParamToinitVal()
    {
        self.totalPages = 0
        self.pageIndex = 1
        self.pagesize = 10
        self.hasNextPage = false
        self.itemToDisplay = [[String:JSON]]()
        self.tbl_view.reloadData()
    }
    
    func setupUiStuff()
    {
        self.txt_search_retailer.delegate = self
        self.txt_search_retailer.setLeftPaddingPoints(8)
        self.txt_search_retailer.setRightPaddingPoints(8)
        self.leading_search.constant = self.view.frame.width - 80
        self.view.layoutIfNeeded()
    }
    
    func showSearch()
    {
        self.leading_search.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
            self.txt_search_retailer.becomeFirstResponder()
        }
    }
    
    func hideSearch()
    {
        self.view.endEditing(true)
        self.leading_search.constant = self.view.frame.width - 80
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}

extension SearchRetailerVC:UITextFieldDelegate
{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
           let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            self.setupApiParamToinitVal()
            self.tbl_view.reloadData()
            self.getRetailer(search: updatedText)
        }
        return true
    }
}
