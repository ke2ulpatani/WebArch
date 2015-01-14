//
//  TempSubView.swift
//  WebArch
//
//  Created by Ketul Patani on 03/01/15.
//  Copyright (c) 2015 Ketul Patani. All rights reserved.
//

import UIKit

class TempSubView: UIViewController, UITextFieldDelegate {

    var unit = ["K","C","F"]
    var speed : String?
    var i : Int?
    
    @IBOutlet var tempLabel: UITextField!
    @IBOutlet var tempUnit: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tempLabel.text = speed
        self.tempUnit.text = unit[i!] /*"\u{00B0}"+*/
        self.tempLabel.delegate = TempViewController()
        self.view.tag = 0
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
