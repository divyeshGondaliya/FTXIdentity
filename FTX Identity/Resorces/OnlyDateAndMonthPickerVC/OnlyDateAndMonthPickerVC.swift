//
//  OnlyDateAndMonthPickerVC.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 21/12/21.
//

import UIKit

protocol OnlyDateAndMonthPickerDelegate:class {
    func dateSelected(stringValueOfTextField:String)
}

class OnlyDateAndMonthPickerVC: UIViewController {
    
    @IBOutlet weak var MonthPicker: UIPickerView!
    @IBOutlet weak var datePicker: UIPickerView!
    
    var monthArr = [String]()
    var dateArr = [String]()
    
    weak var delegate: OnlyDateAndMonthPickerDelegate?
    var selected_Day_month = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for item in 1...12
        {
            monthArr.append(item<10 ? "0\(item)":"\(item)")
        }
        for item in 1...31
        {
            dateArr.append(item<10 ? "0\(item)":"\(item)")
        }
        self.MonthPicker.reloadAllComponents()
        self.datePicker.reloadAllComponents()
        if self.selected_Day_month.count > 0
        {
            let arr = self.selected_Day_month.components(separatedBy: "/")
            let month = Int(arr[0]) ?? 0 != 0 ? (Int(arr[0]) ?? 0)-1:0
            let day = Int(arr[1]) ?? 0 != 0 ? (Int(arr[1]) ?? 0)-1:0
            self.MonthPicker.selectRow(month, inComponent: 0, animated: true)
            self.datePicker.selectRow(day, inComponent: 0, animated: true)
        }
    }
    
    @IBAction func btn_select_press(_ sender: Any) {
        self.dismiss(animated: true) {
            self.delegate?.dateSelected(stringValueOfTextField: "\(self.monthArr[self.MonthPicker.selectedRow(inComponent: 0) == -1 ? 0:self.MonthPicker.selectedRow(inComponent: 0)])/\(self.dateArr[self.datePicker.selectedRow(inComponent: 0) == -1 ? 0:self.datePicker.selectedRow(inComponent: 0)])")
        }
    }
    
    @IBAction func btn_cancel_press(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension OnlyDateAndMonthPickerVC:UIPickerViewDataSource,UIPickerViewDelegate
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == MonthPicker
        {
            return monthArr.count
        }
        return dateArr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        if pickerView == MonthPicker{
            pickerLabel.text = monthArr[row]
        }else{
            pickerLabel.text = dateArr[row]
        }
        pickerLabel.textColor = .black
        pickerLabel.font = UIFont(name: "SourceSansPro-Regular", size: 24)!
        pickerLabel.textAlignment = .center
        return pickerLabel
    }
}
