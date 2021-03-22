//
//  UIController+Ext.swift
//
//  Created by Ashish on 20/08/20.
//  Copyright © 2020 Ashish. All rights reserved.
//

import Foundation
import UIKit
import Toast_Swift

extension UIViewController {
    
    func showToast(_ msg: String) {
        view.makeToast(msg, duration: 3.0, position: .top)
    }
    
    func showRootToast(_ msg: String) {
        ROOTVC?.view.makeToast(msg)
    }
    
    func showToastWithPosition(_ msg: String, _ position: ToastPosition) {
        view.makeToast(msg, duration: 3.0, position: position)
    }
    
    func showToastWithDuration(_ msg: String, _ duration: TimeInterval) {
        view.makeToast(msg, duration: duration, position: .center)
    }
    
    func setupCartBtn() {
        let btn = UIBarButtonItem(image: UIImage(named: "img_cart"), style: .plain, target: self, action: #selector(onCartBtnTap(_:)))
        navigationItem.rightBarButtonItem = btn
    }
    
    
    @objc fileprivate func onCartBtnTap(_ sender: UIButton) {
        let vc = CartVC.instantiate(fromAppStoryboard: .Cart)
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func setUpguestCartbtn() {
        let btn = UIBarButtonItem(image: UIImage(named: "img_cart"), style: .plain, target: self, action: #selector(setUpguestCartbtn(_:)))
        navigationItem.rightBarButtonItem = btn
    }
    
    @objc fileprivate func setUpguestCartbtn(_ sender: UIButton) {
        let vc = RegisterCartVC.instantiate(fromAppStoryboard: .Register)
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}



extension UIViewController {
    
    func addBackButtonWithTitle(_ title: String, action: Selector) {
        let btnBack = UIButton(type: .custom)
        btnBack.setImage(UIImage(named: "img_back"), for: .normal)
        btnBack.addTarget(self, action: action, for: .touchUpInside)
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = AppFonts.Poppins_Medium.withSize(17)
        titleLabel.textColor = .white
        
        navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: btnBack), UIBarButtonItem(customView: titleLabel)]
    }
    
    func addTitle(_ title: String) {

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = AppFonts.Poppins_Medium.withSize(17)
        titleLabel.textColor = .white
        
        navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: titleLabel)]
    }
}
