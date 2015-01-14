//
//  MassViewController.swift
//  WebArch
//
//  Created by Ketul Patani on 22/12/14.
//  Copyright (c) 2014 Ketul Patani. All rights reserved.
//

import UIKit

class MassViewController: UIViewController, UITextFieldDelegate{

    
    @IBOutlet var unitChoiceOne: UISegmentedControl!
    @IBOutlet var unitChoiceTwo: UISegmentedControl!
    
    @IBOutlet var textFieldOne: UITextField!
    @IBOutlet var textFieldTwo: UITextField!
    
    var unitOne : String!
    var unitTwo : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        var tap :UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(tap)
        unitOne = "kg"
        unitTwo = "kg"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func unitChoiceMade(controller :UISegmentedControl)
    {
        if controller.restorationIdentifier == "unitChoiceOne"
        {
            if textFieldTwo.text != ""
            {
                switch controller.selectedSegmentIndex
                {
                case 0:
                    unitOne = "kg"
                    textFieldOne.text = convertUnit(textFieldTwo.text, fromUnit: unitTwo, toUnit: unitOne)
                case 1:
                    unitOne = "o"
                    textFieldOne.text = convertUnit(textFieldTwo.text, fromUnit: unitTwo, toUnit: unitOne)
                case 2:
                    unitOne = "ton"
                    textFieldOne.text = convertUnit(textFieldTwo.text, fromUnit: unitTwo, toUnit: unitOne)
                    
                    
                default:
                    NSLog("User Ne bahar Dabba Diya hai !!")
                }
            }
            
            
        }
        
        if controller.restorationIdentifier == "unitChoiceTwo"
        {
            if textFieldOne.text != ""
            {
                switch controller.selectedSegmentIndex
                {
                case 0:
                    unitTwo = "kg"
                    textFieldTwo.text = convertUnit(textFieldOne.text, fromUnit: unitOne, toUnit: unitTwo)
                case 1:
                    unitTwo = "o"
                    textFieldTwo.text = convertUnit(textFieldOne.text, fromUnit: unitOne, toUnit: unitTwo)
                case 2:
                    unitTwo = "ton"
                    textFieldTwo.text = convertUnit(textFieldOne.text, fromUnit: unitOne, toUnit: unitTwo)
                    
                default:
                    NSLog("User Ne bahar Dabba Diya hai !!")
                }
            }
            
            
            
        }
    }
    
    // MARK:- Converter Function
    
    func convertUnit(str : String,fromUnit : String,toUnit : String) -> String
    {
        var output : String
        var num : Float
        switch fromUnit
        {
            case "kg":
                if toUnit == "kg"
                {
                    return str
                }
                if toUnit == "o"
                {
                    num = str.floatValue
                    num = num * 35.274
                    output = "\(num)"
                    return output
                }
                if toUnit == "ton"
                {
                    num = str.floatValue
                    num = num * 0.001
                    output = "\(num)"
                    return output
                }
            case "o":
                if toUnit == "kg"
                {
                    num = str.floatValue
                    num = num * 0.028
                    output = "\(num)"
                    return output
                }
                if toUnit == "o"
                {
                    return str
                }
                if toUnit == "ton"
                {
                    num = str.floatValue
                    num = num * 2.835
                    output = "\(num)"
                    return output
                }
            case "ton":
                if toUnit == "kg"
                {
                    num = str.floatValue
                    num = num * 1.00
                    output = "\(num)"
                    return output
                }
                if toUnit == "o"
                {
                    num = str.floatValue
                    num = num * 35274
                    output = "\(num)"
                    return output
                }
                if toUnit == "ton"
                {
                    return str
                }
            
        default:
            NSLog("User Ne Bahar Dabba Diya !!")
            
        }
        return "Bakwaas"
    }
    
    
    //MARK:- Clear Button
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        textFieldOne.text = ""
        textFieldTwo.text = ""
        return true
    }
    
    
    //MARK:- Dismiss Keyboard
    
    func dismissKeyboard()
    {
        textFieldOne.resignFirstResponder()
        textFieldTwo.resignFirstResponder()
    }
    
    
    //MARK:- Textfield Delegate Functions
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if textField.restorationIdentifier == "textFieldOne"
        {
            switch string {
            case "0","1","2","3","4","5","6","7","8","9":
                if textField.text.utf16Count == 19
                {
                    return false
                }
                textFieldTwo.text = convertUnit(textField.text + string, fromUnit: unitOne, toUnit: unitTwo)
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
                {var tempstr = textField.text.substringToIndex(textField.text.endIndex.predecessor())
                    if tempstr.substringFromIndex(tempstr.endIndex.predecessor()) != "."
                    {
                        textFieldTwo.text = convertUnit(tempstr, fromUnit: unitOne, toUnit: unitTwo)
                    }
                    return true
                }
                else
                {
                    textFieldTwo.text = ""
                    return true
                }
            }
        }
        
        if textField.restorationIdentifier == "textFieldTwo"
        {
            switch string {
            case "0","1","2","3","4","5","6","7","8","9":
                if textField.text.utf16Count == 19
                {
                    return false
                }
                
                textFieldOne.text = convertUnit(textField.text + string, fromUnit: unitTwo, toUnit: unitOne)
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
                        textFieldOne.text = convertUnit(tempstr, fromUnit: unitTwo, toUnit: unitOne)
                    }
                    return true
                }
                else
                {
                    textFieldOne.text = ""
                    return true
                }
            }
        }
        
        return false
        
    }
}
