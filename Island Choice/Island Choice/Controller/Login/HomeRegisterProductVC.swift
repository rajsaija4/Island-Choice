//
//  HomeRegisterProduct.swift
//  Island Choice
//
//  Created by GT-Raj on 09/03/21.
//

import UIKit

class HomeRegisterProductVC: UIViewController {

    
    //MARK: - Outlets
    
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var collRegisterAccountProductCell: UICollectionView! {
        didSet {
            collRegisterAccountProductCell.registerCell(ProductCollCell.self)
        }
    }
    
    
    //MARK: - Lifecycle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create Account"
        setupNavigationBarBackBtn()
        // Do any additional setup after loading the view.
    }
    

    //MARK: - ActionMethods
    
    @IBAction func onPressNextbtnTap(_ sender: Any) {
        let vc = RegisterCartVC.instantiate(fromAppStoryboard: .Register)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func onPressSearchTxtTap(_ sender: Any) {
        
        
        
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


//MARK: - CollectionView Datasource

extension HomeRegisterProductVC: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:ProductCollCell = collectionView.dequequReusableCell(for: indexPath)
        return cell
    }
    
    
}



// MARK: - CollectionView Delegate Flowlayout

extension HomeRegisterProductVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - 30) / 2
        let height = width * 2
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    
}



// MARK: - CollectionView Delegate

extension HomeRegisterProductVC: UICollectionViewDelegate {
    
}
