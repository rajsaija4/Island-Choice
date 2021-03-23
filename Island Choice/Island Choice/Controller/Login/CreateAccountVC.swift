//
//  CreateAccountVC.swift
//  Island Choice
//
//  Created by GT-Raj on 09/03/21.
//

import UIKit

class CreateAccountVC: UIViewController {
    
    //MARK:- LifeCycle()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        AppUserDefaults.save(value: NSUUID().uuidString, forKey: .kGuestUserToken)
        navigationController?.isNavigationBarHidden = false
        title = "Create Account"
        setupNavigationBarBackBtn()
        // Do any additional setup after loading the view.
    }
    

    
    //MARK: - ActionMethods
    
    @IBAction func onPressBusinessRegisterbtnTap(_ sender: Any) {
        let vc = MediumAndLargeScaleRegisterVC.instantiate(fromAppStoryboard: .Register)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func onPressHomebtnTap(_ sender: UIButton) {
        let vc = HomeRegisterProductVC.instantiate(fromAppStoryboard: .Register)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
