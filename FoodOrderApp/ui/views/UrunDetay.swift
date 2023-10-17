//
//  UrunDetay.swift
//  FoodOrderApp
//
//  Created by EZGİ KARABAY on 11.10.2023.
//

import UIKit
import Firebase
import RxSwift

class UrunDetay: UIViewController {
    
    @IBOutlet weak var yemekToplamFiyat: UILabel!
    @IBOutlet weak var adetLabel: UILabel!
    @IBOutlet weak var yemekAdiLabel: UILabel!
    @IBOutlet weak var yemekFiyatLabel: UILabel!
    @IBOutlet weak var imageViewYemek: UIImageView!
    
    var viewModel = UrunDetayViewModel()
    var sepetListesi = [SepetDetay]()
    var yemek:Yemekler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //yemekToplamFiyat
        if let y = yemek {
            
            yemekAdiLabel.text = y.yemek_adi
            yemekFiyatLabel.text = y.yemek_fiyat!
            
            
            if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(y.yemek_resim_adi!)"){
                DispatchQueue.main.async {
                    self.imageViewYemek.kf.setImage(with: url)
                }
                _ = viewModel.sepetListesi.subscribe(onNext: { liste in
                    self.sepetListesi = liste
                })
                _ = viewModel.yrepo.yemekAdet.subscribe(onNext: { adet in
                    self.adetLabel.text = String(adet)
                })
                
                _ = viewModel.yrepo.yemekToplamFiyat.subscribe(onNext: { yemekFiyat in
                     self.yemekToplamFiyat.text = String(yemekFiyat)
                })
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        yemekToplamFiyat.text = yemek?.yemek_fiyat
    }
    @IBAction func adetEkleButton(_ sender: Any) {
        viewModel.adetEkle()
        viewModel.yrepo.fiyatHesapla(fiyat: Int((yemek?.yemek_fiyat)!)!)
    }
    @IBAction func adetCikarButton(_ sender: Any) {
        viewModel.adetCikar()
        viewModel.yrepo.fiyatHesapla(fiyat: Int((yemek?.yemek_fiyat)!)!)

    }
    
    @IBAction func sepeteEkleButton(_ sender: Any) {
            let user = Auth.auth().currentUser
            let userEmail = user!.email
            let userName = userEmail?.components(separatedBy: "@").first
        //userName = ""
        
        if userName == "" {
            let alert = UIAlertController(title: "Hata", message: "Lütfen giriş yapınız", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
        }

        if let ym = yemek {
            if let yemek_adi = yemekAdiLabel.text, let yemek_resim_adi = ym.yemek_resim_adi, let yemek_fiyat = yemekFiyatLabel.text, let yemek_siparis_adet = adetLabel.text {
                viewModel.sepeteEkle(yemek_adi: yemek_adi, yemek_resim_adi: yemek_resim_adi, yemek_fiyat: Int(yemek_fiyat)!, yemek_siparis_adet: Int(yemek_siparis_adet)!, kullanici_adi: userName!)
            }
        }
        
        performSegue(withIdentifier: "toSepet", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSepet" {
            if let yemek = sender as? Yemekler {
                let gidilecekVC = segue.destination as! Sepetim
                gidilecekVC.yemek = yemek
            }
        }
    }
}


