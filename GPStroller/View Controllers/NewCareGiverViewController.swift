//
//  NewCareGiverViewController.swift
//  GPStroller
//
//  Created by Mahika Jain on 4/27/20.
//  Copyright © 2020 Mahika Jain. All rights reserved.
//

import UIKit

class NewCareGiverViewController: UIViewController {

    @IBOutlet weak var fname: UITextField!
    
    @IBOutlet weak var lname: UITextField!
    
    @IBOutlet weak var pnum: UITextField!
    
    @IBOutlet weak var nextButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setUpElements()
    }
    func setUpElements(){
        
        Utilities.styleTextField(fname)
        Utilities.styleTextField(lname)
        Utilities.styleTextField(pnum)
        Utilities.styleFilledButton2(nextButton)
    }
    
    func validateFields() -> String? {
           
           //Check tht all fields are filled in
           if fname.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
               lname.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
               pnum.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
               return "Please fill in all fields."
               }
        return nil
    }
}
