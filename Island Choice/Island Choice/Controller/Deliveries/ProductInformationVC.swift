//
//  ProductInformationVC.swift
//  Island Choice
//
//  Created by GT-Raj on 15/03/21.
//

import UIKit
import Kingfisher

class ProductInformationVC: UIViewController {
    
    var productInfo:ProductRecords!

    @IBOutlet weak var btnBackGround: UIButton!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblProductTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDescriptionTwo: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setImage()
        lblProductTitle.text = productInfo.productDescription
        lblDescription.text = productInfo.webDescription2
        lblDescriptionTwo.text = productInfo.webDescriptionLong
        lblPrice.text = "$\(productInfo.price[0])"

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onPressBackgroundbtnTap(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        
        
    }
    @IBAction func onPressbtnAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
            
        
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


extension ProductInformationVC {
    
    fileprivate func setImage() {
        let product = productInfo.code
        if let imageUrl = URL(string: "https://islandchoiceguam.com//account//images//mw_synced_image_3_\(product).jpg") {
            imgProduct.kf.indicatorType = .activity
            imgProduct.kf.indicator?.startAnimatingView()
            imgProduct.kf.setImage(with: imageUrl, placeholder: UIImage(named: "imgCamera"), options: nil, progressBlock: nil) { (_) in
                self.imgProduct.kf.indicator?.stopAnimatingView()
            }
        }
        
    }
}
