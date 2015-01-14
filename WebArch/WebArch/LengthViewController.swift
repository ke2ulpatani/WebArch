//
//  LengthViewController.swift
//  WebArch
//
//  Created by Ketul Patani on 22/12/14.
//  Copyright (c) 2014 Ketul Patani. All rights reserved.
//

import UIKit

class LengthViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet var inputField: UITextField!
    @IBOutlet var scroller: UIPickerView!
    @IBOutlet var output: UILabel!
    var unit = ["meter","mile","yard","foot"]
    var input : String!
    var toUnit : String!
    var fromUnit : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        toUnit = "yard"
        fromUnit = "yard"
        scroller.selectRow(2, inComponent: 1, animated: true)
        scroller.selectRow(2, inComponent: 0, animated: true)
        var tap :UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK:- Dismiss Keyboard
    
    func dismissKeyboard()
    {
        inputField.resignFirstResponder()
    }
    
    //MARK:- PicketView Functions
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return unit.count
    }
    
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
        
        var label = UILabel()
        var labelData = unit[row]
        label.text = labelData
        if component == 0
        {
            label.textAlignment = NSTextAlignment.Left
        }
        else
        {
            label.textAlignment = NSTextAlignment.Right
        }
        return label
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0
        {
            toUnit = unit[row]
        }
        else
        {
            fromUnit = unit[row]
        }
    }
    
    
    
    
    //MARK:- Conversion Function

    func convertUnit(input : String,toUnit: String, fromUnit: String) -> String
    {
        var output : String
        var num : Float
        switch fromUnit
        {
            case "meter":
                if toUnit == "meter"
                {
                    return input
                }
                if toUnit == "mile"
                {
                    num = input.floatValue
                    num = num * 0.000621371
                    output = "\(num)"
                    return output
                }
                if toUnit == "yard"
                {
                    num = input.floatValue
                    num = num * 1.09361
                    output = "\(num)"
                    return output
                }
                if toUnit == "foot"
                {
                    num = input.floatValue
                    num = num * 3.28084
                    output = "\(num)"
                    return output
                }
            case "mile":
                if toUnit == "meter"
                {
                    num = input.floatValue
                    num = num * 1609.34
                    output = "\(num)"
                    return output
                }
                if toUnit == "mile"
                {
                    return input
                }
                if toUnit == "yard"
                {
                    num = input.floatValue
                    num = num * 1760
                    output = "\(num)"
                    return output
                }
                if toUnit == "foot"
                {
                    num = input.floatValue
                    num = num * 5280
                    output = "\(num)"
                    return output
                }
            case "yard":
                if toUnit == "meter"
                {
                    num = input.floatValue
                    num = num * 0.9144
                    output = "\(num)"
                    return output
                }
                if toUnit == "mile"
                {
                    num = input.floatValue
                    num = num * 0.000568182
                    output = "\(num)"
                    return output
                }
                if toUnit == "yard"
                {
                    return input
                }
                if toUnit == "foot"
                {
                    num = input.floatValue
                    num = num * 3
                    output = "\(num)"
                    return output
                }
            case "foot":
                if toUnit == "meter"
                {
                    num = input.floatValue
                    num = num * 0.3048
                    output = "\(num)"
                    return output
                }
                if toUnit == "mile"
                {
                    num = input.floatValue
                    num = num * 0.000189394
                    output = "\(num)"
                    return output
                }
                if toUnit == "yard"
                {
                    num = input.floatValue
                    num = num * 0.333333
                    output = "\(num)"
                    return output
                }
                if toUnit == "foot"
                {
                    return input
                }
            
            default:
                NSLog("User Ne bahar dabba diya hai !!")
            
        }
        
        return "Bakwaas"

    }
    
    
    @IBAction func convert(sender: AnyObject) {
        
        input = inputField.text
        
        if input.isEmpty == false
        {
            if input.substringFromIndex(input.endIndex.predecessor()) != "."
            {
                dismissKeyboard()
                var alert : UIAlertView = UIAlertView()
                alert.title = "Result"
                var outputstr = convertUnit(input, toUnit: toUnit, fromUnit: fromUnit)
                alert.message = "Output:\t\(outputstr)"
                alert.addButtonWithTitle("Okay")
                alert.show()
            }
            else
            {
                dismissKeyboard()
                var alert : UIAlertView = UIAlertView()
                alert.title = "Invalid"
                var outputstr = convertUnit(input, toUnit: toUnit, fromUnit: fromUnit)
                alert.message = "Invalid Input"
                alert.addButtonWithTitle("Okay")
                alert.show()
            }
            
            
            
            
        }
        
        
    }
    

}
