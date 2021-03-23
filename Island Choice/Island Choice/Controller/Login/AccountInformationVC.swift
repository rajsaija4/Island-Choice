//
//  AccountInformationVC.swift
//  Island Choice
//
//  Created by GT-Raj on 09/03/21.
//

import UIKit
import Parchment
import SwiftyJSON

class AccountInformationVC: UIViewController {
    
    //MARK: - Variables
    
    var pagingViewController: PagingViewController!
    var guestOrderModal: RegisterNewCustomerWithOrderModel = RegisterNewCustomerWithOrderModel(json: JSON.null)
    
    //MARK: - Outlets

    @IBOutlet weak var contentView: UIView!

    
    //MARK: - Lifecycle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarBackBtn()
        title = "Account Information"
        
        
       
        setupSubViewControllers()
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

}

//MARK: - Func SetupSubViewController()

extension AccountInformationVC{
    
    fileprivate func setupSubViewControllers() {
        
            title = "Account Information"
        
        let CreditCard = RegisterCreditCardVC.instantiate(fromAppStoryboard: .Register)
        CreditCard.title = "CREDIT CARD"
        CreditCard.guestOrderModal = guestOrderModal
        let Echeck = EcheckVC.instantiate(fromAppStoryboard: .Register)
        Echeck.title = "E-CHECK"
        Echeck.guestOrderModal = guestOrderModal
//        historyVC.onShowStatement = { isShowStatement in
//            historyVC.title = isShowStatement ? "STATEMENTS" : "HISTORY"
//
        
        
        pagingViewController = PagingViewController(viewControllers: [CreditCard,Echeck])
        pagingViewController.menuItemSize = .sizeToFit(minWidth: 50, height: 50)
        pagingViewController.backgroundColor = .cyan
        pagingViewController.selectedBackgroundColor = .cyan
        pagingViewController.indicatorColor = .white
        pagingViewController.textColor = .darkGray
        pagingViewController.selectedTextColor = .black
        
        addChild(pagingViewController)
        contentView.addSubview(pagingViewController.view)
        contentView.constrainToEdges(pagingViewController.view)
        pagingViewController.didMove(toParent: self)
        
    }
}
