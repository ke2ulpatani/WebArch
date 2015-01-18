//
//  SecondViewController.swift
//  WebArch
//
//  Created by Ketul Patani on 22/12/14.
//  Copyright (c) 2014 Ketul Patani. All rights reserved.
//

import UIKit
extension String {
    var floatValue: Float {
        return (self as NSString).floatValue
    }
}

class SpeedViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource,UIPickerViewDelegate{

    @IBOutlet weak var firstBackground: UIView!
    @IBOutlet weak var secondBackground: UIView!
    
    @IBOutlet weak var unitLabelOne: UITextField!
    @IBOutlet weak var unitLabelTwo: UITextField!
   
    @IBOutlet weak var scrollerOne: UIPickerView!
    @IBOutlet weak var scrollerTwo: UIPickerView!
    
    var speedUnitOne = "km/h"
    var speedUnitTwo = "km/h"
    
    var speedUnitList = ["m/s","km/h","mph","ft/s"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(tap)
        scrollerOne.selectRow(1, inComponent: 0, animated: true)
        scrollerTwo.selectRow(1, inComponent: 0, animated: true)
        self.view.backgroundColor = UIColor(red: 0x67/255, green: 0x5A/255, blue: 0x57/255, alpha: 1.0)
        
        self.firstBackground.backgroundColor = UIColor(red: 0x4F/255, green: 0x9A/255, blue: 0xEA/255, alpha: 1.0)
        self.secondBackground.backgroundColor = UIColor(red: 0x4F/255, green: 0x9A/255, blue: 0xEA/255, alpha: 1.0)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   //MARK:- TextField Delegate Functions
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if textField.restorationIdentifier == "labelOne"
        {
            switch string {
            case "0","1","2","3","4","5","6","7","8","9":
                if textField.text.utf16Count == 19
                {
                    return false
                }
                unitLabelTwo.text = convertUnit(textField.text + string, fromUnit: speedUnitOne, toUnit: speedUnitTwo)
                return true
            case ".":
                if textField.text.utf16Count == 19
                {
                    return false
                }
                let array = Array(textField.text)
                var decimalCount = 0
                for character in array {
                if character == "." {
                decimalCount++
                }
                }
                
                if decimalCount == 1 {
                return false
                } else {
                return true
                }
            default:
                if textField.text.utf16Count >= 2
                { var tempstr = textField.text.substringToIndex(textField.text.endIndex.predecessor())
                    if tempstr.substringFromIndex(tempstr.endIndex.predecessor()) != "."
                    {
                        unitLabelTwo.text = convertUnit(tempstr, fromUnit: speedUnitOne, toUnit: speedUnitTwo)
                    }
                    return true
                }
                else
                {
                    unitLabelTwo.text = ""
                    return true
                }
            }
        }
        
        if textField.restorationIdentifier == "labelTwo"
        {
            switch string {
            case "0","1","2","3","4","5","6","7","8","9":
                if textField.text.utf16Count == 19
                {
                    return false
                }
                unitLabelOne.text = convertUnit(textField.text + string, fromUnit: speedUnitTwo, toUnit: speedUnitOne)
                return true
            case ".":
                if textField.text.utf16Count == 19
                {
                    return false
                }
                let array = Array(textField.text)
                var decimalCount = 0
                for character in array {
                    if character == "." {
                        decimalCount++
                    }
                }
                
                if decimalCount == 1 {
                    return false
                } else {
                    return true
                }
            default:
                
                
                if textField.text.utf16Count >= 2
                { var tempstr = textField.text.substringToIndex(textField.text.endIndex.predecessor())
                    if tempstr.substringFromIndex(tempstr.endIndex.predecessor()) != "."
                    {
                        unitLabelOne.text = convertUnit(tempstr, fromUnit: speedUnitTwo, toUnit: speedUnitOne)
                    }
                    return true
                }
                else
                {
                    unitLabelOne.text = ""
                    return true
                }
            }
         }
        
        return false
        
     }
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        unitLabelTwo.text = ""
        unitLabelOne.text = ""
        return true
    }

    
    //MARK:- PickerView Functions
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return speedUnitList.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return speedUnitList[row]
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.restorationIdentifier == "scrollerOne"
        {
            speedUnitOne = speedUnitList[row]
            if unitLabelTwo.text != ""
            {
                unitLabelOne.text = convertUnit(unitLabelTwo.text, fromUnit: speedUnitTwo, toUnit: speedUnitOne)
            }
        }
        if pickerView.restorationIdentifier == "scrollerTwo"
        {
            speedUnitTwo = speedUnitList[row]
            
            if unitLabelOne.text != ""
            {
                unitLabelTwo.text = convertUnit(unitLabelOne.text, fromUnit: speedUnitOne, toUnit: speedUnitTwo)
            }
        }
      
     }
    
    //MARK:- Conversion Function
    
    func convertUnit(str : String,fromUnit : String,toUnit : String) -> String
    {
        var output : String
        var num : Float
        switch fromUnit
        {
            case "km/h":
                if toUnit == "km/h"
                {
                    return str
                    
                }
                if toUnit == "m/s"
                {
                    num = str.floatValue
                    num = num * 0.277
                    output = "\(num)"
                    return output
                    
                }
                if toUnit == "mph"
                {
                    num = str.floatValue
                    num = num * 0.621
                    output = "\(num)"
                    return output
                }
                if toUnit == "ft/s"
                {
                    num = str.floatValue
                    num = num * 0.911
                    output = "\(num)"
                    return output
                }
            case "m/s":
                if toUnit == "km/h"
                {
                    num = str.floatValue
                    num = num * 3.600
                    output = "\(num)"
                    return output
                    
                }
                if toUnit == "m/s"
                {
                    
                    return str
                    
                }
                if toUnit == "mph"
                {
                    num = str.floatValue
                    num = num * 2.236
                    output = "\(num)"
                    return output
                }
                if toUnit == "ft/s"
                {
                    num = str.floatValue
                    num = num * 3.280
                    output = "\(num)"
                    return output
                }
            case "mph":
                if toUnit == "km/h"
                {
                    num = str.floatValue
                    num = num * 1.609
                    output = "\(num)"
                    return output
                    
                }
                if toUnit == "m/s"
                {
                    num = str.floatValue
                    num = num * 0.447
                    output = "\(num)"
                    return output
                }
                if toUnit == "mph"
                {
                    return str
                }
                if toUnit == "ft/s"
                {
                    num = str.floatValue
                    num = num * 1.466
                    output = "\(num)"
                    return output
                }
            
            case "ft/s":
                if toUnit == "km/h"
                {
                    num = str.floatValue
                    num = num * 1.097
                    output = "\(num)"
                    return output
                    
                }
                if toUnit == "m/s"
                {
                    num = str.floatValue
                    num = num * 0.304
                    output = "\(num)"
                    return output
                }
                if toUnit == "mph"
                {
                    num = str.floatValue
                    num = num * 0.681
                    output = "\(num)"
                    return output
                }
                if toUnit == "ft/s"
                {
                    return str
                }
            default:
            println("Error")
        
        }
        
        return "Bakwaas"
    }
    
    //MARK:- Dismiss KeyBoard
    
    func dismissKeyboard()
    {
        unitLabelOne.resignFirstResponder()
        unitLabelTwo.resignFirstResponder()
    }
    


}

