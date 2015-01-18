//
//  TempViewController_Final.swift
//  WebArch
//
//  Created by Ketul Patani on 14/01/15.
//  Copyright (c) 2015 Ketul Patani. All rights reserved.
//

import UIKit

class TempViewController_Final: UIViewController, UITableViewDelegate, UITableViewDataSource , UITextFieldDelegate{

    @IBOutlet weak var selectUnit: UISegmentedControl!
    @IBOutlet weak var inputField: UITextField!
    var unitInput : String = "C"
    var unitOutput : String!
    var unit : [String] = ["Fahrenheit","Kelvin"]
    var expanded : Int = -1
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        var tap :UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissTableView")
        self.view.addGestureRecognizer(tap)
        self.view.backgroundColor = UIColor(red: 0x67/255, green: 0x5A/255, blue: 0x57/255, alpha: 1.0)
        self.tableView.backgroundColor = UIColor(red: 0x67/255, green: 0x5A/255, blue: 0x57/255, alpha: 1.0)
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissTableView() ///Has to be solved
        
    {
        
        self.inputField.resignFirstResponder()
        expanded = -1
        self.tableView.beginUpdates()
        self.tableView.reloadData()
        self.tableView.endUpdates()
    }
    
    
    
    
    
    @IBAction func unitChoice(sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex
        {
            case 0:
                unit = ["Fahrenheit","Kelvin"]
                unitInput = "C"
                expanded = -1
                self.tableView.reloadData()
            case 1:
                unit = ["Celcius","Kelvin"]
                unitInput = "F"
                expanded = -1
                self.tableView.reloadData()
            case 2:
                unit = ["Celcius","Fahrenheit"]
                unitInput = "K"
                expanded = -1
                self.tableView.reloadData()
            default:
                NSLog("Unreachable state has been reached")
            
            
        }
        
    }
    
    //MARK:- TableView Functions
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell : CustomCell = tableView.dequeueReusableCellWithIdentifier("Cell") as CustomCell
        
        cell.unitName.text = unit[indexPath.row]
        cell.textLabel?.textAlignment = NSTextAlignment.Center
        cell.unitName.textColor = UIColor.whiteColor()
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.textLabel?.hidden = true
        cell.detailTextLabel?.hidden = true
        if indexPath.row % 2 == 0
        {
            cell.backgroundColor = UIColor.grayColor()
            
        }
        else
        {
            cell.backgroundColor = UIColor.lightGrayColor()
        }
        return cell
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == expanded
        {
            
            return 180
            
        }
        
        return 90
    }
    
    
    
    func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath)
    {
        
        if self.inputField.text.isEmpty == false
        {
            if expanded != indexPath.row
            {
                if expanded != -1
                {
                    var path : NSIndexPath = NSIndexPath(forRow: expanded, inSection: indexPath.section)
                    self.tableView.cellForRowAtIndexPath(path)?.textLabel?.hidden = true
                    
                }
                expanded = indexPath.row
                unitOutput = unit[indexPath.row].substringToIndex(unit[indexPath.row].startIndex.successor())
                var ans = convertUnit(inputField.text, fromUnit: unitInput, toUnit: unitOutput)
                var formula = calculateFormula(inputField.text, fromUnit: unitInput, toUnit: unitOutput)
                self.tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text = formula+" = "+ans
                self.tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.hidden = false
                
                self.tableView.beginUpdates()
                self.tableView.endUpdates()
            }
            else
            {
                expanded = -1
                self.tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.hidden = true
                self.tableView.beginUpdates()
                self.tableView.endUpdates()
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
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        expanded = -1
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
    

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

    func calculateFormula(str : String,fromUnit : String,toUnit : String) -> String
    {
        var output : String
        var num : Float
        switch fromUnit
        {
        case "K":
            if toUnit == "C"
            {
                return "\(str)"+"-273.15"
            }
            if toUnit == "F"
            {
                return "1.8 * (\(str) - 273.15) + 32"
            }
        case "C":
            if toUnit == "K"
            {
                return "\(str) + 273.15"
                
            }
            if toUnit == "F"
            {
                return "((\(str) * 9) / 5) + 32"
                
            }
        case "F":
            if toUnit == "K"
            {
                
                return "((\(str)-32) / 1.8 + 273.15"
            }
            if toUnit == "C"
            {
                
                return"((\(str) - 32 ) * 5 ) / 9"
            }
            
        default :
            NSLog("Error Has Ocurred")
        }
        
        return "Bakwaas"
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        if self.inputField.text.isEmpty == false
        {
            if expanded != indexPath.row
            {
                expanded = indexPath.row
                unitOutput = unit[indexPath.row].substringToIndex(unit[indexPath.row].startIndex.successor())
                var ans = convertUnit(inputField.text, fromUnit: unitInput, toUnit: unitOutput)
                var formula = calculateFormula(inputField.text, fromUnit: unitInput, toUnit: unitOutput)
                self.tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text = formula+" = "+ans+" "+unitOutput
                self.tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.hidden = false
                self.tableView.beginUpdates()
                self.tableView.endUpdates()
            }
            else
            {
                expanded = -1
                self.tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.hidden = true
                self.tableView.beginUpdates()
                self.tableView.endUpdates()
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
