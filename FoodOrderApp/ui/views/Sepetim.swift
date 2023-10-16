//
//  Sepetim.swift
//  FoodOrderApp
//
//  Created by EZGİ KARABAY on 11.10.2023.
//

import UIKit

class Sepetim: UIViewController {
    
    var sepetListesi = [SepetDetay]()

    @IBOutlet weak var sepetToplamLabel: UILabel!
    
    @IBOutlet weak var sepetTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sepetTableView.delegate = self
        sepetTableView.dataSource = self
        
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

        return hucre
    }
    
}
