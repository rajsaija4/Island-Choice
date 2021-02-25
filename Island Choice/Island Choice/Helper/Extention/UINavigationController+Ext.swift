//
//  UINavigationController+Ext.swift
//  Zodi
//
//  Created by AK on 11/09/20.
//  Copyright © 2020 Gurutechnolabs. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {

    
    fileprivate func shadowLayer(shadowView: UIView) -> CAShapeLayer {
        let shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: shadowView.bounds, byRoundingCorners: [.bottomRight], cornerRadii: CGSize(width: 50, height: 50)).cgPath
        
        shadowLayer.fillColor = COLOR.App.cgColor
        return shadowLayer
    }
    
    fileprivate func addStackView(shadowView: UIView) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.tag = -1
        shadowView.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor, constant: -16).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        stackView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor, constant: -8).isActive = true
        return stackView
    }
    
    fileprivate func titleLable(_ name: String) -> UILabel {
        let titleLabel = UILabel()
        titleLabel.tag = -1
        titleLabel.text = name
        titleLabel.font = AppFonts.Poppins_Medium.withSize(17)
        titleLabel.textColor = .white
        return titleLabel
    }
    
    fileprivate func customButton(action: Selector, imgURLString: String) -> UIButton {
        let btnCustom = UIButton(type: .custom)
        btnCustom.imageView?.contentMode = .scaleAspectFill
        if let imgURL = URL(string: imgURLString) {
            btnCustom.kf.setImage(with: imgURL, for: .normal)
        } else {
            btnCustom.setImage(UIImage(named: "img_user"), for: .normal)
        }
    
        btnCustom.cornerRadius = 15
        btnCustom.clipsToBounds = true
        btnCustom.addTarget(self.topViewController, action: action, for: .touchUpInside)
        btnCustom.translatesAutoresizingMaskIntoConstraints = false
        btnCustom.widthAnchor.constraint(equalToConstant: 30).isActive = true
        btnCustom.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return btnCustom
    }
    
    fileprivate func reportButton(action: Selector) -> UIButton {
        let btnCustom = UIButton(type: .custom)
        btnCustom.setImage(UIImage(named: "img_Report"), for: .normal)
        btnCustom.addTarget(self.topViewController, action: action, for: .touchUpInside)
        btnCustom.translatesAutoresizingMaskIntoConstraints = false
        btnCustom.widthAnchor.constraint(equalToConstant: 30).isActive = true
        btnCustom.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return btnCustom
    }
    
    
    
    fileprivate func backButton(action: Selector) -> UIButton {
        let btnBack = UIButton(type: .custom)
        btnBack.setImage(UIImage(named: "img_back"), for: .normal)
        btnBack.tintColor = .white
        btnBack.tag = -2
        btnBack.addTarget(self.topViewController, action: action, for: .touchUpInside)
        btnBack.translatesAutoresizingMaskIntoConstraints = false
        btnBack.widthAnchor.constraint(equalToConstant: 30).isActive = true
        btnBack.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return btnBack
    }
}
