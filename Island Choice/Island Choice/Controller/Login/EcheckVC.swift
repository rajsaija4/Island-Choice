//
//  EcheckVC.swift
//  Island Choice
//
//  Created by GT-Raj on 09/03/21.
//

import UIKit

class EcheckVC: UIViewController {
    
    
    @IBOutlet weak var txtAccountNumber: UITextField!
    @IBOutlet weak var txtRountingNumber: UITextField!
    @IBOutlet weak var txtNameAccount: UITextField!
    @IBOutlet weak var txtBankName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onPressContinuebtnTap(_ sender: Any) {
        
        let vc = AditionInformationVC.instantiate(fromAppStoryboard: .Register)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    @IBAction func onPressCheckingbtnTap(_ sender: Any) {
        
    }
    
    @IBAction func onPressBusinessCheckbtnTap(_ sender: Any) {
    }
    
    @IBAction func onPressSavingbtnTap(_ sender: Any) {
    }
    
    @IBAction func onPressCheckOnebtnTap(_ sender: Any) {
    }
    
    @IBAction func onPressTwocheckbtnTap(_ sender: Any) {
        
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
