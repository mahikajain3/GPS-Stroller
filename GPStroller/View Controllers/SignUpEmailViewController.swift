//
//  SignUpEmailViewController.swift
//  GPStroller
//
//  Created by Mahika Jain on 4/21/20.
//  Copyright © 2020 Mahika Jain. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpEmailViewController: UIViewController {

    @IBOutlet weak var firstname: UITextField!
    
    @IBOutlet weak var lastname: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    func setUpElements(){
    
    //Hide error button
    errorLabel.alpha = 0
    
    //style the elements
    Utilities.styleTextField(firstname)
    
    Utilities.styleTextField(lastname)
    
    Utilities.styleTextField(email)
    
    Utilities.styleTextField(username)
    
    Utilities.styleTextField(password)
    
    Utilities.styleFilledButton(signupButton)
    }

    func validateFields() -> String? {
        
        //Check tht all fields are filled in
        if firstname.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastname.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            email.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            username.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            password.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields."
            }
        let cleanedPassword = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false{
            //Password not secure
            return "Please make sure your password is atleast 8 characters, contains a special character and a number."
        }
        
        let cleanedEmail = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isValidEmail(cleanedEmail) == false{
            //Email not valid
            return "Please enter a valid email address."
        }
        
        return nil
    }
    
    
    
    @IBAction func signupTap(_ sender: Any) {
        
        //Validate fields
        let error = validateFields()
        if error != nil{
            //there was something wrong with fields, show error message
            showError(error!)
        }
        else{
            
            //Create cleaned versions of the data
            let firstName = firstname.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastname.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let userName = username.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let emailAdd = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let passWord = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //Create user
            Auth.auth().createUser(withEmail: emailAdd, password: passWord) { (result, err) in
                
                //Check for errors
                if err != nil {
                    
                    //there was an error creating user
                    self.showError("Error creating user.")
                }
                else{
                    
                    //User created successfully, store first, last name etc.
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["firstname":firstName, "lastname":lastName, "username":userName, "uid":result!.user.uid]) { (error) in
                        
                        if error != nil{
                            //Show error message
                            self.showError("User could not be stored in database.")
                        }
                    }
                    
                    //Transition to home screen
                    self.transitionToHome()
                }
            }
        }
    }
    
    func showError(_ message:String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome(){
        
        let homeViewController = 
        storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
}
