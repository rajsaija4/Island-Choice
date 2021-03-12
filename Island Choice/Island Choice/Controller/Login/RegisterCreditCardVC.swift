//
//  RegisterCreditCardVC.swift
//  Island Choice
//
//  Created by GT-Raj on 09/03/21.
//

import UIKit

class RegisterCreditCardVC: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var txtCountry: UITextField!
    @IBOutlet weak var txtExpirationDate: UITextField!
    @IBOutlet weak var txtVarifivationCode: UITextField!
    @IBOutlet weak var txtCardNumber: UITextField!
    
    
    //MARK: - Lifecycle()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    //MARK: - ActionMethods

    @IBAction func onPressContinuebtnTap(_ sender: Any) {
        
        let vc = AditionInformationVC.instantiate(fromAppStoryboard: .Register)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    @IBAction func onPressbtnCheckTermTap(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
        
        
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
