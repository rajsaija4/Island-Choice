//
//  MediumAndLargeScaleRegisterVC.swift
//  Island Choice
//
//  Created by GT-Raj on 10/03/21.
//

import UIKit

class MediumAndLargeScaleRegisterVC: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var txtCompanyName: UITextField!
    @IBOutlet weak var txtContactNumber: UITextField!
    @IBOutlet weak var txtContactPerson: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    // MARK: - Lifecycle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Register Profile"
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: - ActionMethods
    
    @IBAction func onPressSubmitbtnTap(_ sender: UIButton) {
        
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
