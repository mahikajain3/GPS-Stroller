//
//  HveAccountViewController.swift
//  GPStroller
//
//  Created by Mahika Jain on 4/19/20.
//  Copyright © 2020 Mahika Jain. All rights reserved.
//

import UIKit
import FirebaseAuth

class HveAccountViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var logingButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements(){
        
        //Hide error label
        errorLabel.alpha = 0
        
        //style elements
        Utilities.styleTextField(usernameTextField)
        
        Utilities.styleTextField(passwordTextField)
        
        Utilities.styleFilledButton(logingButton)
    }
    
    func validateFields() -> String? {
        
        //Check tht all fields are filled in
        if usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields."
            }
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false{
            //Password not secure
            return "Please make sure your password is atleast 8 characters, contains a special character and a number."
        }
        
        let cleanedEmail = usernameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isValidEmail(cleanedEmail) == false{
            //Email not valid
            return "Please enter a valid email address."
        }
        
        return nil
    }
    
    @IBAction func loginTap(_ sender: Any) {
        //validate text fields
        let error = validateFields()
        if error != nil{
            //there was something wrong with fields, show error message
            showError(error!)
        }
        else {
        //create cleaned versions of text field
        let username = usernameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //signing in user
        Auth.auth().signIn(withEmail: username, password: password) { (result, error) in
            
            if error != nil{
                //couldnt sign in
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            }
            else{
                let homeViewController =
                    self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
                
                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
            }
            }
        }
    }
    func showError(_ message:String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }

}
