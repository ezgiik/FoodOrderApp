//
//  SepetHucre.swift
//  FoodOrderApp
//
//  Created by EZGİ KARABAY on 12.10.2023.
//

import UIKit
import Firebase
import RxSwift

class SepetHucre: UITableViewCell {
    @IBOutlet weak var imageViewYemek: UIImageView!
    
    @IBOutlet weak var yemekAdiLabel: UILabel!
    
    @IBOutlet weak var yemekToplamFiyat: UILabel!
    @IBOutlet weak var yemekAdetLabel: UILabel!
    @IBOutlet weak var yemekFiyatLabel: UILabel!
    
    @IBOutlet weak var yemekSilButton: UIButton!
    
    //var silButtonAction: ((UITableViewCell) -> Void)?
    
    var viewModel = SepetimViewModel()
    
    var yrepo = YemeklerDaoRepository()
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    @IBAction func yemekSilButton(_ sender: UIButton) {
 
    }

}
