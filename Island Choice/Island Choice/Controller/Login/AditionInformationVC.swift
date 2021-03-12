//
//  AditionInformationVC.swift
//  Island Choice
//
//  Created by GT-Raj on 10/03/21.
//

import UIKit

class AditionInformationVC: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var btnAddContract: UIButton!
    @IBOutlet weak var addContractView: UIView!
    @IBOutlet weak var txtOpenTo: UITextField!
    @IBOutlet weak var txtContractTitle: UITextField!
    @IBOutlet weak var txtNameOfContract: UITextField!
    @IBOutlet weak var txtContractType: UITextField!
    @IBOutlet weak var txtNote: UITextView!
    @IBOutlet weak var txtOpenForm: UITextField!
    
    //MARK: - Lifecycle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create Account"
        setupNavigationBarBackBtn()

        // Do any additional setup after loading the view.
    }
    
// MARK - ActionMethod
    
    @IBAction func onPressContinuebtnTap(_ sender: Any) {
        
        let vc = RegisterCreateAccount.instantiate(fromAppStoryboard: .Register)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onPressCheckPaperlessTap(_ sender: Any) {
    }
    @IBAction func onPressVarieadHoursbtnTap(_ sender: Any) {
    }
    
    @IBAction func onPressAddContractbtnTap(_ sender: Any) {
    
        
        addContractView.isHidden = false
        btnAddContract.isHidden = true
        
    }
    @IBAction func onPressAddRemovebtnTap(_ sender: Any) {
        
        addContractView.isHidden = true
        btnAddContract.isHidden = false
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
