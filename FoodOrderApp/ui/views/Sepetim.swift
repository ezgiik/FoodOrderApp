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
        hucre.yemekFiyatLabel.text = "₺" + yemek.yemek_fiyat!
        hucre.yemekAdetLabel.text = yemek.yemek_siparis_adet!
        //hucre.yemekToplamFiyat.text = viewModel.yrepo.yemekToplamFiyat

        return hucre
    }
    
}
