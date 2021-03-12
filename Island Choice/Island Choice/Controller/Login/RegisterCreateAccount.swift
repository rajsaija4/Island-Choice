//
//  RegisterCreateAccount.swift
//  Island Choice
//
//  Created by GT-Raj on 10/03/21.
//

import UIKit

class RegisterCreateAccount: UIViewController {
    
    // MARK: - Outlets

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtRetypePassword: UITextField!
   
    
    //MARK: - Lifecycle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create Profile"

        // Do any additional setup after loading the view.
    }
    
    
    //MARK: - ActionMethods
    
    @IBAction func onPressCheckAgreemenrtbtnTap(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
    }
    
    @IBAction func onPressPasswordShowbtnTap(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
        
    }
    @IBAction func onPressRetypePasswordShowbtnTap(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
    }
    
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
