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
        
        if let y = yemek {
            yemekAdiLabel.text = y.yemek_adi
            //imageViewYemek.image = UIImage(named: y.yemek_resim!)
            yemekFiyatLabel.text = "₺" + String(describing: y.yemek_fiyat!)
          }
                
        }
        
        @IBAction func adetEkleButton(_ sender: Any) {
            
        }
        
        @IBAction func adetCikarButton(_ sender: Any) {
            
        }
        @IBAction func sepeteEkleButton(_ sender: Any) {
            viewModel.sepeteEkle()
        }
        
        
    }

