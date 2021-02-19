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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubViewControllers()
    }
    
}



extension BillingVC {
    
    fileprivate func setupSubViewControllers() {
        
        let invoiceVC = InvoiceVC.instantiate(fromAppStoryboard: .Billing)
        invoiceVC.title = "OPEN INVOICES"
        let historyVC = HistoryVC.instantiate(fromAppStoryboard: .Billing)
        historyVC.title = "HISTORY"
        let paymentMethodVC = PaymentMethodVC.instantiate(fromAppStoryboard: .Billing)
        paymentMethodVC.title = "PAYMENT METHODS"
        
        let pagingViewController = PagingViewController(viewControllers: [invoiceVC, historyVC, paymentMethodVC])
        pagingViewController.menuItemSize = .selfSizing(estimatedWidth: 50, height: 50)
        
        addChild(pagingViewController)
        contentView.addSubview(pagingViewController.view)
        contentView.constrainToEdges(pagingViewController.view)
        pagingViewController.didMove(toParent: self)

        
    }
}
