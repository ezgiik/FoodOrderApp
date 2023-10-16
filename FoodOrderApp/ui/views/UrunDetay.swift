//
//  UrunDetay.swift
//  FoodOrderApp
//
//  Created by EZGİ KARABAY on 11.10.2023.
//

import UIKit

class UrunDetay: UIViewController {
    
    @IBOutlet weak var yemekToplamFiyat: UILabel!
    @IBOutlet weak var adetLabel: UILabel!
    
    @IBOutlet weak var yemekAdiLabel: UILabel!
    @IBOutlet weak var yemekFiyatLabel: UILabel!
    @IBOutlet weak var imageViewYemek: UIImageView!
    
    var viewModel = UrunDetayViewModel()
    
    var yemek:Yemekler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adetLabel.text = "\(viewModel.yrepo.urunAdet)"
        
        if let y = yemek {
            yemekAdiLabel.text = y.yemek_adi
            yemekFiyatLabel.text = "₺" + String(y.yemek_fiyat!)
            if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(y.yemek_resim_adi!)"){
                    DispatchQueue.main.async {
                        self.imageViewYemek.kf.setImage(with: url)
                    }
                }
          }
        }
        
        @IBAction func adetEkleButton(_ sender: Any) {
            viewModel.adetEkle()
            adetLabel.text = "\(viewModel.yrepo.urunAdet)"
        }
        
        @IBAction func adetCikarButton(_ sender: Any) {
            viewModel.adetCikar()
            adetLabel.text = "\(viewModel.yrepo.urunAdet)"
            
        }
        @IBAction func sepeteEkleButton(_ sender: Any) {
            viewModel.sepeteEkle()
        }
        
        
    }

