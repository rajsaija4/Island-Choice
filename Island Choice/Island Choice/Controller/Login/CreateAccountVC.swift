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
        
        navigationController?.isNavigationBarHidden = false
        title = "Create Account"
        setupNavigationBarBackBtn()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        AppUserDefaults.save(value: NSUUID().uuidString, forKey: .kGuestUserToken)
        GetCustomerGuestCartDetails.arrCartProduct.removeAll()
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
        getClearGuestCart()
       
    }
    
}

extension CreateAccountVC {
    fileprivate func getClearGuestCart() {
       showHUD()
    NetworkManager.SignUp.GetGuestCartClear({ (json) in
        print(json)
        self.hideHUD()
        let vc = HomeRegisterProductVC.instantiate(fromAppStoryboard: .Register)
        self.navigationController?.pushViewController(vc, animated: true)
       
      
    }, { (error) in
      
        self.hideHUD()
        self.showToast(error)
    })
}
    
}
