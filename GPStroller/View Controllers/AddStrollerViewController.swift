//
//  AddStrollerViewController.swift
//  GPStroller
//
//  Created by Mahika Jain on 4/19/20.
//  Copyright © 2020 Mahika Jain. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import Firebase

class AddStrollerViewController: UIViewController {

    @IBOutlet weak var childNameFieldText: UITextField!
    
    @IBOutlet weak var strollerNameFieldText: UITextField!
    
    @IBOutlet weak var gpstrollerAcctFieldText: UITextField!
    
    @IBOutlet weak var done: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
        
        fetchUser()
    }
    
    func setUpElements(){
        
        Utilities.styleTextField(childNameFieldText)
        Utilities.styleTextField(strollerNameFieldText)
        Utilities.styleTextField(gpstrollerAcctFieldText)
        Utilities.styleFilledButton2(done)
    }
    
    func addStroller(){
        guard let uid = Auth.auth().currentUser?.uid else{return}
        //let storageRef = Storage.storage().reference().child("users/strollers/\(uid)")
        
    }
    
    func fetchUser(){
        Database.database().reference().child("users").observe(.childAdded, with: {(snapshot) in
            
        }, withCancel: nil)
    }

    @IBAction func doneTap(_ sender: Any) {
        
        //validate the fields
        //let error = validateFields()
        
        //if error != nil{
            //showError(error!)
        //}
        //else{
            
            //get user
           // handle = Auth.auth().addStateDidChangeListener({ (<#Auth#>, <#User?#>) in
            //    <#code#>
           // })
            
            //create stroller
           // Auth.auth().current
        //}
        
    }
    

}
