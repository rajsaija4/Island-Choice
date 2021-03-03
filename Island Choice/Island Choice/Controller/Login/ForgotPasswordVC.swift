//
//  ForgotPasswordVC.swift
//  Island Choice
//
//  Created by GT-Ashish on 18/02/21.
//

import UIKit

class ForgotPasswordVC: UIViewController {
    
    //MARK: - OUTLET
  
    @IBOutlet weak var txtAccountNumber: UITextField!
    
    @IBOutlet weak var txtZipcode: UITextField!
    //MARK: - VARIABLE
    
    //MARK: - MAIN METHOD

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSendBtnTap(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onCancelBtnTap(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onBackgroundBtnTap(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
