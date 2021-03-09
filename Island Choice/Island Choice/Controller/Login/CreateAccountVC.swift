//
//  CreateAccountVC.swift
//  Island Choice
//
//  Created by GT-Raj on 09/03/21.
//

import UIKit

class CreateAccountVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        title = "Create Account"
        setupNavigationBarBackBtn()
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
    @IBAction func onPressHomebtnTap(_ sender: UIButton) {
        let vc = HomeRegisterProductVC.instantiate(fromAppStoryboard: .Register)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
