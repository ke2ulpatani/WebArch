//
//  FirstViewController.swift
//  WebArch
//
//  Created by Ketul Patani on 22/12/14.
//  Copyright (c) 2014 Ketul Patani. All rights reserved.
//

import UIKit

class BODHViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var binaryLabel: UITextField!
    @IBOutlet weak var decimalLabel: UITextField!
    @IBOutlet weak var hexadecimalLabel: UITextField!
    @IBOutlet weak var octalLabel: UITextField!
    
    @IBOutlet weak var binaryName: UILabel!
    @IBOutlet weak var decimalName: UILabel!
    @IBOutlet weak var hexadecimalName: UILabel!
    @IBOutlet weak var octalName: UILabel!
    
    var isBackSpace : Bool?
    var decimal = 0
    var binary  = 0b0
    var hexadecimal = 0x0
    var octal = 0o0
    
    func dismissKeyboard()
    {
        binaryLabel.resignFirstResponder()
        decimalLabel.resignFirstResponder()
        hexadecimalLabel.resignFirstResponder()
        octalLabel.resignFirstResponder()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self , action: "dismissKeyboard")
        self.view.addGestureRecognizer(tap)
      var keyboardNotification : NSNotificationCenter = NSNotificationCenter.defaultCenter()
        keyboardNotification.addObserver(self, selector: "keyboardWillShow", name: UIKeyboardWillShowNotification, object: nil)
        keyboardNotification.addObserver(self, selector: "keyboardWillHide", name: UIKeyboardWillHideNotification, object: nil)
        self.view.backgroundColor = UIColor(red: 0x5C/255, green: 0xA0/255, blue: 0xEA/255, alpha: 1.0)
        //Do any additional setup after loading the view, typically from a nib.
    }
    
   override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification , object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
  
    
    
    
   func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool
    {
        
       if textField.restorationIdentifier == "binaryLabel"
        {
            switch string
            {
                case "0" , "1":
                    if textField.text.utf16Count == 19
                    {
                        return false
                    }
                    decimal = numToInt(textField.text + string, power: 2)
                    decimalLabel.text = String(decimal)
                    hexadecimalLabel.text = String(decimal, radix: 16)
                    octalLabel.text = String(decimal, radix: 8)
                    return true
               /* case ".":
                    if textField.text.utf16Count == 19
                    {
                        return false
                    }
                    let array = Array(textField.text)
                    var decimalCount = 0
                    for digit in array
                    {
                       if digit == "."
                       {
                            decimalCount += 1
                       }
                    }
                    if decimalCount == 1
                    {
                        return false
                    }
                    else
                    {
                        return true
                    }*/
                case "2" , "3" , "4" , "5" , "6" , "7" , "8" , "9":
                    return false
                
                default:
                    if textField.text.utf16Count >= 2
                    {   decimal = numToInt(textField.text.substringToIndex(textField.text.endIndex.predecessor()), power: 2)
                        decimalLabel.text = String(decimal)
                        hexadecimalLabel.text = String(decimal, radix: 16)
                        octalLabel.text = String(decimal, radix: 8)
                        return true
                    }
                    else
                    {
                        decimalLabel.text = ""
                        hexadecimalLabel.text = ""
                        octalLabel.text = ""
                        return true
                }
            }
         }
        
        if textField.restorationIdentifier == "decimalLabel"
        {
           
            
            
            switch string {
            case "0","1","2","3","4","5","6","7","8","9":
                if textField.text.utf16Count == 19
                {
                    return false
                }
                decimal = (textField.text + string).toInt()!
                binaryLabel.text = String(decimal, radix: 2)
                hexadecimalLabel.text = String(decimal, radix: 16)
                octalLabel.text = String(decimal, radix: 8)
                return true
           /* case ".":
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
                }*/
            default:
              if textField.text.utf16Count >= 2
              { decimal = (textField.text.substringToIndex(textField.text.endIndex.predecessor())).toInt()!
                binaryLabel.text = String(decimal, radix: 2)
                hexadecimalLabel.text = String(decimal, radix: 16)
                octalLabel.text = String(decimal, radix: 8)
                return true
              }
              else
              {
                    binaryLabel.text = ""
                    hexadecimalLabel.text = ""
                    octalLabel.text = ""
                    return true
              }
            }
          }
        
        if textField.restorationIdentifier == "hexadecimalLabel" //Check For Alphabets Other Than Defined And Backspace
        {
            
            switch string {
            case "0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f","A","B","C","D","E","F":
                if textField.text.utf16Count == 19
                {
                    return false
                }
                decimal = numToInt(textField.text + string, power: 16)
                decimalLabel.text = String(decimal)
                binaryLabel.text = String(decimal, radix: 2)
                octalLabel.text = String(decimal, radix: 8)
                return true
           /* case ".":
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
                }*/
            default:
                if textField.text.utf16Count >= 2
                { decimal = numToInt(textField.text.substringToIndex(textField.text.endIndex.predecessor()), power: 16)
                    binaryLabel.text = String(decimal, radix: 2)
                    decimalLabel.text = String(decimal)
                    octalLabel.text = String(decimal, radix: 8)
                    return true
                }
                else
                {
                    binaryLabel.text = ""
                    decimalLabel.text = ""
                    octalLabel.text = ""
                    return true
                }
            }
         }
        
        if textField.restorationIdentifier == "octalLabel"
        {
            switch string {
            case "0","1","2","3","4","5","6","7":
                if textField.text.utf16Count == 19
                {
                    return false
                }
                decimal = numToInt(textField.text + string, power: 8)
                decimalLabel.text = String(decimal)
                hexadecimalLabel.text = String(decimal, radix: 16)
                binaryLabel.text = String(decimal, radix: 2)
                return true
            case "8","9":
                return false
            /*case ".":
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
                }*/
            default:
                if textField.text.utf16Count >= 2
                {
                    decimal = numToInt(textField.text.substringToIndex(textField.text.endIndex.predecessor()), power: 8)
                    binaryLabel.text = String(decimal, radix: 2)
                    hexadecimalLabel.text = String(decimal, radix: 16)
                    decimalLabel.text = String(decimal)
                    return true
                }
                else
                {
                    binaryLabel.text = ""
                    hexadecimalLabel.text = ""
                    decimalLabel.text = ""
                    return true
                }

            }
        }
        
        return false
    }
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        binaryLabel.text = ""
        hexadecimalLabel.text = ""
        octalLabel.text = ""
        decimalLabel.text = ""
        return true
    }
    
    //MARK:- Conversion Functions
    
   func numToInt(str : String, power : Int) -> Int
    {
       var ans : Int = 0
        
        var j : Int = 0
     
        
        if power == 16
        {
            var arr = Array(str)
            var i : Int = 0
            
            for i = arr.count - 1 ; i >= 0 ; i--
            {
                switch arr[i]
                {
                    case "0":
                        ans += 0 * Int( powf(Float(power), Float(j)) )
                        break
                    case "1":
                        ans += 1 * Int( powf(Float(power), Float(j)) )
                        break
                    case "2":
                        ans += 2 * Int( powf(Float(power), Float(j)) )
                        break
                    case "3":
                        ans += 3 * Int( powf(Float(power), Float(j)) )
                        break
                    case "4":
                        ans += 4 * Int( powf(Float(power), Float(j)) )
                        break
                    case "5":
                        ans += 5 * Int( powf(Float(power), Float(j)) )
                        break
                    case "6":
                        ans += 6 * Int( powf(Float(power), Float(j)) )
                        break
                    case "7":
                        ans += 7 * Int( powf(Float(power), Float(j)) )
                        break
                    case "8":
                        ans += 8 * Int( powf(Float(power), Float(j)) )
                        break
                    case "9":
                        ans += 9 * Int( powf(Float(power), Float(j)) )
                        break
                    case "a","A":
                        ans += 10 * Int( powf(Float(power), Float(j)) )
                        break
                    case "b","B":
                        ans += 11 * Int( powf(Float(power), Float(j)) )
                        break
                    case "c","C":
                        ans += 12 * Int( powf(Float(power), Float(j)) )
                        break
                    case "d","D":
                        ans += 13 * Int( powf(Float(power), Float(j)) )
                        break
                    case "e","E":
                        ans += 14 * Int( powf(Float(power), Float(j)) )
                        break
                    case "f","F":
                        ans += 15 * Int( powf(Float(power), Float(j)) )
                        break
                    
                    default:
                        println("Error Input")
                    
                }
                j += 1
                
            }
            return ans
            
        }

        var arr = str.toInt()
        
        while arr != 0
        {
            var c = arr! % 10
            ans = ans + c * Int(powf(Float(power), Float(j)))
            j++
            arr = arr! / 10
        }
        
        return ans
    }
    
    
    //MARK:- KeyBoard Attention
    
    func keyboardWillShow()
    {
      UIView.animateWithDuration(0.4, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, options: nil, animations: {
            self.binaryName.center.y -= CGFloat(40.0)
            self.binaryLabel.center.y -= CGFloat(40.0)
            self.decimalName.center.y -= CGFloat(50.0)
            self.decimalLabel.center.y -= CGFloat(50.0)
            self.hexadecimalName.center.y -= CGFloat(50.0)
            self.hexadecimalLabel.center.y -= CGFloat(50.0)
            self.octalName.center.y -= CGFloat(50.0)
            self.octalLabel.center.y -= CGFloat(50.0)
        }, completion: nil)
    }
    
    func keyboardWillHide()
    {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.5)
        self.binaryName.center.y += CGFloat(40.0)
        self.binaryLabel.center.y += CGFloat(40.0)
        self.decimalName.center.y += CGFloat(40.0)
        self.decimalLabel.center.y += CGFloat(40.0)
        self.hexadecimalName.center.y += CGFloat(40.0)
        self.hexadecimalLabel.center.y += CGFloat(40.0)
        self.octalName.center.y += CGFloat(40.0)
        self.octalLabel.center.y += CGFloat(40.0)
        UIView.commitAnimations()
    }


    
    
    
    
}





