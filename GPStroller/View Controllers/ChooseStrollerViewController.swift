//
//  ChooseStrollerViewController.swift
//  GPStroller
//
//  Created by Mahika Jain on 4/19/20.
//  Copyright © 2020 Mahika Jain. All rights reserved.
//

import UIKit

class ChooseStrollerViewController: UIViewController {

    @IBOutlet weak var newStroller: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    func setUpElements(){
        
        Utilities.styleFilledButton2(newStroller)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
