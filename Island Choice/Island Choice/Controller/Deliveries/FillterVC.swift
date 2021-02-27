//
//  FillterVC.swift
//  Island Choice
//
//  Created by GT-Ashish on 27/02/21.
//

import UIKit

class FillterVC: UIViewController {

  
    @IBOutlet weak var tblFillterProductCatageory: UITableView! {
        didSet {
            tblFillterProductCatageory.register(FillterProductViewCell.self)
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Filter Product"

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onPressCheckProductbtnTap(_ sender: UIButton) {
        
        if sender.isSelected {
            print("Check")
        }
        
        else {
            print("uncheck")
        }
        
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
// MARK: - CollectionView Datasource

extension FillterVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell:FillterProductViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.btnChekProductCatageory.tag = indexPath.row
        cell.btnChekProductCatageory.addTarget(self, action: #selector(onCheckBtnTap(_:)), for: .touchUpInside)
        return cell
    }
    
    
    @objc fileprivate func onCheckBtnTap(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
        
        
    }
    
    
}


// MARK: - TableView Delegate

extension FillterVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
        return 50
    }
    
}

