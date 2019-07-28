//
//  Calculator.swift
//  first
//
//  Created by Марк Шавловский on 04/07/2019.
//  Copyright © 2019 BunBeauty. All rights reserved.
//

import UIKit

class Calculator: UIViewController{
    
    @IBOutlet weak var nameOfElementText: UILabel!
    @IBOutlet weak var periodOfDecayText: UILabel!
    @IBOutlet weak var startActivityInput: UITextField!
    @IBOutlet weak var endActivityText: UILabel!
    @IBOutlet weak var endDateInput: UITextField!
    @IBOutlet weak var startDateInput: UITextField!
    
    private var myDatePicker:UIDatePicker?

    var nameOfElement:String!
    var periodOfDecay:String!
    var startDate:String!
    var endDate:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myDatePicker = UIDatePicker()
        myDatePicker?.datePickerMode = .date
        //create DP
        createDPForStartTime()
        createDPForEndTime()
        
        startDateInput.inputView = myDatePicker
        endDateInput.inputView = myDatePicker
        //set name and period
        nameOfElementText.text = nameOfElementText.text! + " " + nameOfElement!
        periodOfDecayText.text = periodOfDecayText.text! + " " + periodOfDecay!
        // Do any additional setup after loading the view.
    }
    
    @objc func doneActionForStart(datePicker:UIDatePicker) {
        let formatter = setDateFormat()
        startDateInput.text = formatter.string(from: myDatePicker!.date)
        view.endEditing(true)
    }
    
    @objc func doneActionForEnd(datePicker:UIDatePicker) {
        let formatter = setDateFormat()
        endDateInput.text = formatter.string(from: myDatePicker!.date)
        view.endEditing(true)
    }
    func setDateFormat() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM.dd.yyyy"
        return formatter
    }
    @IBAction func calculateBtn(_ sender: Any) {
        startDate = startDateInput.text
        endDate = endDateInput.text
        let deltaT = Double(secFromDate(date: endDate) - secFromDate(date: startDate))
        let startActyivity = Double(startActivityInput.text!)
        
        calculate(_deltaT:deltaT, _startActivity:startActyivity!)
    }

    func calculate(_deltaT:Double, _startActivity:Double) {
        var period = Double(periodOfDecay)
        period = period!*365
        print(_deltaT)
        print(period)
        print(_startActivity)
        let deltaT = _deltaT/3600/24
        print(deltaT)
        let powForExp = -0.693*deltaT/period!
        print(powForExp)
        let result = _startActivity*pow(exp(1), powForExp) // probkem in pow
        endActivityText.text = endActivityText.text! + String(result)
    }
    func secFromDate(date : String) -> TimeInterval {
        let strTime = date
        let formatter = DateFormatter()
        formatter.dateFormat = "MM.dd.yyyy"
        let ObjDate = formatter.date(from: strTime)
        return (ObjDate?.timeIntervalSinceNow)!
    }
    
    func createDPForStartTime() {
        //create dp for startTime
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneActionForStart(datePicker:)))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action:nil)
        toolbar.setItems([flexSpace,doneButton], animated: true)
        startDateInput.inputAccessoryView = toolbar
    }
    func createDPForEndTime() {
        //create dp for endTime
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneActionForEnd(datePicker:)))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action:nil)
        toolbar.setItems([flexSpace,doneButton], animated: true)
        endDateInput.inputAccessoryView = toolbar
    }
}
