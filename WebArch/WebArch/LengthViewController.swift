//
//  LengthViewController.swift
//  WebArch
//
//  Created by Ketul Patani on 22/12/14.
//  Copyright (c) 2014 Ketul Patani. All rights reserved.
//

import UIKit

class LengthViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet var inputField: UITextField!
    @IBOutlet var scroller: UIPickerView!
    @IBOutlet var output: UILabel!
    var unit = ["meter","mile","yard","foot"]
    var input : String!
    var toUnit : String!
    var fromUnit : String!
    @IBOutlet weak var firstBackground: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        toUnit = "yard"
        fromUnit = "yard"
        
        scroller.selectRow(2, inComponent: 1, animated: true)
        scroller.selectRow(2, inComponent: 0, animated: true)
        var tap :UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(tap)
        self.view.backgroundColor = UIColor(red: 0x67/255, green: 0x5A/255, blue: 0x57/255, alpha: 1.0)

        self.firstBackground.backgroundColor = UIColor(red: 0x4F/255, green: 0x9A/255, blue: 0xEA/255, alpha: 1.0)
        
        
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
        //var labelData = unit[row]
//        label.text = labelData
//        label.font = UIFont(name: "System", size: 80.0)
        
        let myTitle = NSAttributedString(string: unit[row], attributes: [NSFontAttributeName:UIFont(name: "Arial", size: 26.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
        
        //label.textColor = UIColor.blackColor()
        if component == 0
        {
            label.textAlignment = NSTextAlignment.Left
        }
        else
        {
            label.textAlignment = NSTextAlignment.Right
        }
        
        label.attributedText = myTitle
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
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30.0
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
        else
        {
            var alert = UIAlertView()
            alert.title = "Input Invalid"
            alert.message = "Field is Empty"
            alert.addButtonWithTitle("Okay")
            alert.show()
        }
        
        
    }
    

}
