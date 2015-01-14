//
//  TempViewController.swift
//  WebArch
//
//  Created by Ketul Patani on 22/12/14.
//  Copyright (c) 2014 Ketul Patani. All rights reserved.
//

import UIKit


class TempViewController: UIViewController,UIPageViewControllerDataSource, UITextFieldDelegate, UIPageViewControllerDelegate{

    var unit = ["K","C","F"]

    @IBOutlet var subViewUpper: UIView!
    @IBOutlet var subViewDown: UIView!
    var pageviewControllerUpper : UIPageViewController?
    var pageviewControllerLower : UIPageViewController?
    
    var upperTextField : String! = ""
    var lowerTextField : String! = ""
    var upperUnit : String! = ""
    var lowerUnit : String! = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(tap)

        createPageViewForUpper()
        createPageViewForDown()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissKeyboard()
    {
        subViewUpper.resignFirstResponder()
        subViewDown.resignFirstResponder()
    }
    
    func getSubView(temp : String, unit : Int, position: String) -> TempSubView
    {
        
        var subView = self.storyboard?.instantiateViewControllerWithIdentifier("subViewForPageView") as TempSubView
        subView.speed = temp
        subView.i = unit
        if position == "Upper"
        {
            upperTextField = temp
            upperUnit = self.unit[unit]
            subView.tempLabel.restorationIdentifier = "UpperInput"
        }
        if position == "Lower"
        {
            lowerTextField = temp
            lowerUnit = self.unit[unit]
            subView.tempLabel.restorationIdentifier = "LowerInput"
        }
        return subView
        
    
    }
    

    
    func createPageViewForUpper()
    {
        var pageView = self.storyboard?.instantiateViewControllerWithIdentifier("pageViewForSubView") as UIPageViewController
        pageView.dataSource = self
        pageView.delegate = self
        var firstSubview = getSubView("", unit: 0,position: "Upper")
        var subviewCollection : NSArray = [firstSubview]
        pageView.setViewControllers(subviewCollection, direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        pageView.restorationIdentifier = "Upper"
        pageviewControllerUpper = pageView
        self.subViewUpper.addSubview(pageviewControllerUpper!.view)
        
        self.pageviewControllerUpper?.view.frame = self.subViewUpper.bounds
        
    }
    
    func createPageViewForDown()
    {
        var pageView = self.storyboard?.instantiateViewControllerWithIdentifier("pageViewForSubView") as UIPageViewController
        pageView.dataSource = self
        pageView.delegate = self
        var firstSubview = getSubView("", unit: 0,position:"Lower")
        var subviewCollection : NSArray = [firstSubview]
        pageView.setViewControllers(subviewCollection, direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        pageView.restorationIdentifier = "Lower"
        pageviewControllerLower = pageView
        self.subViewDown.addSubview(pageviewControllerLower!.view)
        self.subViewDown.addSubview(pageviewControllerLowe)
        self.pageviewControllerLower?.view.frame = self.subViewDown.bounds
        
    }
    
    
    
    //MARK:- PageView Functions
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        
        if pageViewController.restorationIdentifier == "Upper"
        {
            
            var subViewControllerUpper = viewController as TempSubView
            
            
            var k : Int = subViewControllerUpper.i!
            var activeTextField = subViewControllerUpper.tempLabel as UITextField
            
            
            if lowerTextField == ""
            {
                if k < 2
                {
                    k += 1
                    return getSubView(activeTextField.text, unit: k,position: "Upper")
                }
                else
                {
                    return nil
                }
            }
            else
            {
                if k < 2
                {
                    k += 1
                    var ans = convertUnit(lowerTextField, fromUnit: lowerUnit, toUnit: unit[k])
                    return getSubView(ans, unit: k, position: "Upper")
                }
                else
                {
                    return nil
                }
            }
            
            
            
        }
        
        if pageViewController.restorationIdentifier == "Lower"
        {
            var subViewControllerLower = viewController as TempSubView
            
            
            var k : Int = subViewControllerLower.i!
            var activeTextField = subViewControllerLower.tempLabel as UITextField
        
            if upperTextField == ""
            {
                if k < 2
                {
                    k += 1
                    return getSubView(activeTextField.text, unit: k,position: "Lower")
                }
                else
                {
                    return nil
                }
                
                
            }
            else
            {
                if k < 2
                {
                    k += 1
                    var ans = convertUnit(upperTextField, fromUnit: upperUnit, toUnit: unit[k])
                    return getSubView(ans, unit: k,position: "Lower")
                }
                else
                {
                    return nil
                }
            }
         }
        
       
        
        return nil
        
    }
    
    
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if pageViewController.restorationIdentifier == "Upper"
        {
            
            var subViewControllerUpper = viewController as TempSubView
            
            
            var k : Int = subViewControllerUpper.i!
            var activeTextField = subViewControllerUpper.tempLabel as UITextField
            
            
            if lowerTextField == ""
            {
                if k > 0
                {
                    k -= 1
                    return getSubView(activeTextField.text, unit: k,position: "Upper")
                }
                else
                {
                    return nil
                }
                
                
            }
            else
            {
                if k > 0
                {
                    k -= 1
                    var ans = convertUnit(lowerTextField, fromUnit: lowerUnit, toUnit: unit[k])
                    return getSubView(ans, unit: k,position: "Upper")
                }
                else
                {
                    return nil
                }
            }
            
            
            
         }
        
        if pageViewController.restorationIdentifier == "Lower"
        {
            var subViewControllerLower = viewController as TempSubView
            
            
            var k : Int = subViewControllerLower.i!
            var activeTextField = subViewControllerLower.tempLabel as UITextField
            
            
            if upperTextField == ""
            {
                if k > 0
                {
                    k -= 1
                    return getSubView(activeTextField.text, unit: k,position:"Lower")
                }
                else
                {
                    return nil
                }
                
            }
            else
            {
                if k > 0
                {
                    k -= 1
                    var ans = convertUnit(upperTextField, fromUnit: upperUnit, toUnit: unit[k])
                    return getSubView(ans, unit: k,position:"Lower")
                }
                else
                {
                    return nil
                }
            }
          }

        return nil
    }
    
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 3
    }
    
    //MARK:- PageView Delegate
    
    
    
    
    
    //MARK:- Convert Unit
    
    
    func convertUnit(str : String,fromUnit : String,toUnit : String) -> String
    {
        var output : String
        var num : Float
        switch fromUnit
        {
            case "K":
                if toUnit == "K"
                {
                    return str
                }
                if toUnit == "C"
                {
                    num = str.floatValue
                    num = num - 273.15
                    output = "\(num)"
                    return output
                }
                if toUnit == "F"
                {
                    num = str.floatValue
                    num = 1.8 * (num - 273.15) + 32
                    output = "\(num)"
                    return output
                }
            case "C":
                if toUnit == "K"
                {
                    num = str.floatValue
                    num = num + 273.15
                    output = "\(num)"
                    return output
                }
                if toUnit == "C"
                {
                    return str
                }
                if toUnit == "F"
                {
                    num = str.floatValue
                    num = ((num * 9) / 5) + 32
                    output = "\(num)"
                    return output
                }
            case "F":
                if toUnit == "K"
                {
                    num = str.floatValue
                    num = ((num - 32 ) / 1.8) + 273.15
                    output = "\(num)"
                    return output
                }
                if toUnit == "C"
                {
                    num = str.floatValue
                    num = ((num - 32 ) * 5 ) / 9
                    output = "\(num)"
                    return output
                }
                if toUnit == "F"
                {
                    return str
                }
            
            default :
            NSLog("Error Has Ocurred")
         }
        
        return "Bakwaas"
    }
    
    
  /* func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if textField.restorationIdentifier == "UpperInput"
        {
            switch string {
            case "0","1","2","3","4","5","6","7","8","9":
                if textField.text.utf16Count == 19
                {
                    return false
                }
                
                var str = convertUnit(textField.text + string, fromUnit: upperUnit, toUnit: lowerUnit)
                
                //var k = find(unit, lowerUnit)
                //var viewTemp = getSubView(str, unit: k!, position: "Lower")
                //var viewTemp = self.subViewDown.viewWithTag(0)
                //viewTemp.
                //subViewDown.addSubview(viewTemp.view)
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
                { (textField.text.substringToIndex(textField.text.endIndex.predecessor())).toInt()!
                    
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
                { (textField.text.substringToIndex(textField.text.endIndex.predecessor())).toInt()!
                    
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
    */
    
}
