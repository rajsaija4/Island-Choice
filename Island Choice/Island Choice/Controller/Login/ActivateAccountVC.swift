//
//  ActivateAccountVC.swift
//  Island Choice
//
//  Created by GT-Raj on 27/02/21.
//

import UIKit

class ActivateAccountVC: UIViewController {
    
    //MARK: - Lifecycle()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Activate Account"
        navigationController?.isNavigationBarHidden = false
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func onPressPasswordVisiblebtnTap(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func onPressRetypePasswordbtnTap(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
    }
}

extension ActivateAccountVC {
    
}
