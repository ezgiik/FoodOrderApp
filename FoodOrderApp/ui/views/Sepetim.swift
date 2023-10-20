//
//  Sepetim.swift
//  FoodOrderApp
//
//  Created by EZGİ KARABAY on 11.10.2023.
//

import UIKit
import RxSwift
import Alamofire
import Kingfisher
import Firebase

class Sepetim: UIViewController {
    var sepetListesi = [SepetDetay]()
    var viewModel = SepetimViewModel()
    var yemek:Yemekler?
    
    //var yemekToplamFiyat = BehaviorSubject<Int>(value: 0)
    
    @IBOutlet weak var sepetToplamLabel: UILabel!
    
    @IBOutlet weak var sepetTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        
        
        sepetTableView.delegate = self
        sepetTableView.dataSource = self
        
        let user = Auth.auth().currentUser
        let userEmail = user!.email
        let userName = userEmail?.components(separatedBy: "@").first
    
        viewModel.yrepo.sepettekiYemekleriGetir(kullanici_adi: userName!)
        
        _ = viewModel.sepetListesi.subscribe(onNext: { liste in
            self.sepetListesi = liste
            DispatchQueue.main.async {
                self.sepetTableView.reloadData()
            }
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let user = Auth.auth().currentUser
        let userEmail = user!.email
        let userName = userEmail?.components(separatedBy: "@").first
    
        viewModel.yrepo.sepettekiYemekleriGetir(kullanici_adi: userName!)
        
    }
    
    
    @IBAction func sepetiOnaylaButton(_ sender: Any) {
    }
    
    @objc func silButtonTapped(_ sender: UIButton) {
        
        
        
        
        if let cell = sender.superview?.superview as? SepetHucre {
            if let indexPath = sepetTableView.indexPath(for: cell) {
                let sepetYemek = sepetListesi[indexPath.row]
                
                viewModel.yrepo.yemekSil(sepet_yemek_id: Int(sepetYemek.sepet_yemek_id!)!, kullanici_adi: sepetYemek.kullanici_adi!)
                
                let filtrelenmisSepet = sepetListesi.filter {sepet in
                    return sepet.yemek_adi == sepetYemek.yemek_adi
                }.first
                
                for id in filtrelenmisSepet!.idList!{
                    
                    self.viewModel.yrepo.yemekSil(sepet_yemek_id: Int(id!)!, kullanici_adi: sepetYemek.kullanici_adi!)
                }
                
                sepetListesi.remove(at: indexPath.row)
                sepetTableView.deleteRows(at: [indexPath], with: .fade)
                
            }
        }
    }
}

extension Sepetim : UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sepetListesi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let hucre = tableView.dequeueReusableCell(withIdentifier: "sepetHucre") as! SepetHucre
        
        let yemek = sepetListesi[indexPath.row]
        
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(yemek.yemek_resim_adi!)"){
            DispatchQueue.main.async {
                hucre.imageViewYemek.kf.setImage(with: url)
            }
        }
        hucre.yemekAdiLabel.text = yemek.yemek_adi!
        hucre.yemekFiyatLabel.text = yemek.yemek_fiyat!
        hucre.yemekAdetLabel.text = yemek.yemek_siparis_adet!
        
        if let yemekFiyat = yemek.yemek_fiyat, let yemekAdet = yemek.yemek_siparis_adet, let yf = Int(yemekFiyat), let ad = Int(yemekAdet) {
            let result = yf * ad
            hucre.yemekToplamFiyat.text = "\(result)"
        } else {
            print("Fiyat veya adet değerleri uygun formatta değil.")
        }
        
        let toplam = sepetListesi.reduce(0) {
            $0 + Int(Double($1.yemek_toplam_fiyat ?? "0") ?? 0)
        }
        sepetToplamLabel.text = String(toplam)
        
        
        hucre.arkaPlan.backgroundColor = UIColor(white: 0.94, alpha: 1)
        hucre.arkaPlan.layer.cornerRadius = 25
        
        hucre.yemekSilButton.addTarget(self, action: #selector(silButtonTapped(_:)), for: .touchUpInside)
        
        return hucre
    }
    
    }
