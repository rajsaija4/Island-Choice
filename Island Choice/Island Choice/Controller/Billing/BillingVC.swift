//
//  BillingVC.swift
//  Island Choice
//
//  Created by GT-Ashish on 19/02/21.
//

import UIKit
import Parchment

class BillingVC: UIViewController {

    @IBOutlet weak var contentView: UIView!
    var pagingViewController: PagingViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupCartBtn()
        setupSubViewControllers()
        setupNavigationBarBackBtn()
    }
    
}



extension BillingVC {
    
    fileprivate func setupSubViewControllers() {
        
        title = "Billing"
        
        let invoiceVC = InvoiceVC.instantiate(fromAppStoryboard: .Billing)
        invoiceVC.title = "OPEN INVOICES"
        let historyVC = HistoryVC.instantiate(fromAppStoryboard: .Billing)
        historyVC.title = "HISTORY"
//        historyVC.onShowStatement = { isShowStatement in
//            historyVC.title = isShowStatement ? "STATEMENTS" : "HISTORY"
//        }
        let paymentMethodVC = PaymentMethodVC.instantiate(fromAppStoryboard: .Billing)
        paymentMethodVC.title = "PAYMENT METHODS"
        
        pagingViewController = PagingViewController(viewControllers: [invoiceVC, historyVC, paymentMethodVC])
        pagingViewController.menuItemSize = .selfSizing(estimatedWidth: 50, height: 50)
        
        addChild(pagingViewController)
        contentView.addSubview(pagingViewController.view)
        contentView.constrainToEdges(pagingViewController.view)
        pagingViewController.didMove(toParent: self)
        
    }
}
