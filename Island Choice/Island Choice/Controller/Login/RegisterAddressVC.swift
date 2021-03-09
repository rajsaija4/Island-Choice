//
//  RegisterAddressVC.swift
//  Island Choice
//
//  Created by GT-Raj on 09/03/21.
//

import UIKit

class RegisterAddressVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create Account"
        setupNavigationBarBackBtn()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onPressDiffrentAddressbtnTap(_ sender: Any) {
        
        let vc = LoginBillingInformationVC.instantiate(fromAppStoryboard: .Register)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func onPressContinuebtnTap(_ sender: Any) {
        let vc = AccountInformationVC.instantiate(fromAppStoryboard: .Register)
        
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

}
