//
//  AccountVC.swift
//  Island Choice
//
//  Created by GT-Ashish on 19/02/21.
//

import UIKit
import MessageUI

class AccountVC: UIViewController, MFMailComposeViewControllerDelegate {

    //MARK: - OUTLET
    @IBOutlet weak var tblAccount: UITableView!{
        didSet{
            tblAccount.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
            tblAccount.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            tblAccount.tableFooterView = UIView(frame: .zero)
        }
    }
    
    //MARK: - VARIABLE
    
    fileprivate var arrSectionTitle = ["Information", "Need Help", "About"]
    fileprivate var arrTitle = [["Billing Information", "Delivery Information", "Change Password"], ["FAQs", "Talk to Us"], ["Terms of Use", "Privacy Policy", "Rate An App", "Logout", "Version 1.0"]]
    
    //MARK: - MAIN METHOD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Account"
        
        setupNavigationBarBackBtn()
        setupCartBtn()
    }


}


extension AccountVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrSectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTitle[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = arrTitle[indexPath.section][indexPath.row]
        
        if indexPath.section == 2 && indexPath.row == 3{
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.textColor = .red
            cell.accessoryType = .none
            cell.textLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        }
        
        if indexPath.section == 2 && indexPath.row == 4{
            cell.textLabel?.textAlignment = .center
            cell.accessoryType = .none
            cell.textLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        headerView.backgroundColor = .cyan
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = arrSectionTitle[section]
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        headerView.addSubview(label)
        label.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 20).isActive = true
        label.rightAnchor.constraint(equalTo: headerView.rightAnchor).isActive = true
        label.topAnchor.constraint(equalTo: headerView.topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        
        return headerView

    }
}



extension AccountVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
            case 0:
                switch indexPath.row {
                    case 0:
                        let vc = BillingInformationVC.instantiate(fromAppStoryboard: .Account)
                        vc.hidesBottomBarWhenPushed = true
                        self.navigationController?.pushViewController(vc, animated: true)
                    case 1:
                        let vc = DeliveryInformationVC.instantiate(fromAppStoryboard: .Account)
                        vc.hidesBottomBarWhenPushed = true
                        self.navigationController?.pushViewController(vc, animated: true)
                    case 2:
                        let vc = ChangePasswordVC.instantiate(fromAppStoryboard: .Account)
                        vc.hidesBottomBarWhenPushed = true
                        self.navigationController?.pushViewController(vc, animated: true)
                    default:
                        break
                }
                
        case 1:
            switch  indexPath.row {
            case 1:
                sendEmail()
            default:
                break
            }
                
        case 2:
            switch indexPath.row {
            case 2:
                guard let url = URL(string: "https://itunes.apple.com/us/app/myapp/id\(APPID)?ls=1&mt=8") else {
                    return
                }
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            case 3:
                AppUserDefaults.removeValue(forKey: .CustomerId)
                APPDEL?.setupLogin()
            default:
                break
            }
            
            default:
                break
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
}

extension AccountVC {
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["contact@islandchoiceguam.com"])
            mail.setMessageBody("", isHTML: true)

            present(mail, animated: true)
        } else {
            self.showToast("Device not configured to send emails, trying with share ...")
        }
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
