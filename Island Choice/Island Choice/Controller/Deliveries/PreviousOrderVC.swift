//
//  PreviousOrderVC.swift
//  Island Choice
//
//  Created by GT-Raj on 25/02/21.
//

import UIKit

class PreviousOrderVC: UIViewController {
    
    @IBOutlet weak var btnPlaceOrder: UIButton!
    // MARK: - Outlets
    @IBOutlet weak var txtPreviousOrderDate: UITextField!
    @IBOutlet weak var btnCalander: UIButton!
    @IBOutlet weak var txtNextDelieveryDate: UITextField!
    @IBOutlet weak var txtDelieveryOrder: UITextField!
    
    @IBOutlet weak var collPreviousOrder: UICollectionView!{
        didSet {
            collPreviousOrder.registerCell(PreviousOrderCollCell.self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Previous Order"
        setupCartBtn()

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


// MARK: - CollectionView Datasource

extension PreviousOrderVC: UICollectionViewDataSource {
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:PreviousOrderCollCell = collectionView.dequequReusableCell(for: indexPath)
        return cell
    }
    
    
}


//MARK: - Action

extension PreviousOrderVC {
    
    @IBAction func btnPlaceOrder(_ sender: UIButton) {
    }
    
    @IBAction func btnCalander(_ sender: UIButton) {
    }
}



// MARK: - CollectionView DelegateFlowlayout

extension PreviousOrderVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - 30) / 2
        let height = collectionView.frame.size.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
}



// MARK: - CollectionView Delegate

extension PreviousOrderVC: UICollectionViewDelegate {
    
   
}
