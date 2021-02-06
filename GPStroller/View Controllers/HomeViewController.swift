//
//  HomeViewController.swift
//  GPStroller
//
//  Created by Mahika Jain on 4/19/20.
//  Copyright © 2020 Mahika Jain. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        
        checkIfUserIsLoggedIn()
    }
    
    func checkIfUserIsLoggedIn(){
        if Auth.auth().currentUser?.uid == nil{
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }
        else{
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: {(snapshot)in
                
                if let dictionary = snapshot.value as? [String: AnyObject]{
                    self.navigationItem.title = dictionary["username"] as? String
                }
            }, withCancel: nil)
        }
    }
    
    @objc func handleLogout(){
        do{
            try Auth.auth().signOut()
        }   catch let logoutError{
            print(logoutError)
        }
    }
    

}
