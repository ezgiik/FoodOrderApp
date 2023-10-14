//
//  ViewController.swift
//  FoodOrderApp
//
//  Created by EZGİ KARABAY on 11.10.2023.
//

import UIKit
import RxSwift

class Anasayfa: UIViewController {
    
    var yemeklerListesi = [Yemekler]()
    
    var viewModel = AnasayfaViewModel()
    
    @IBOutlet weak var yemeklerCollectionView: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        yemeklerCollectionView.delegate = self
        yemeklerCollectionView.dataSource = self
        
        _ = viewModel.yemeklerListesi.subscribe(onNext: { liste in
            self.yemeklerListesi = liste
            DispatchQueue.main.async {
                self.yemeklerCollectionView.reloadData()
            }
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.yemekleriYukle()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetay" {
            if let yemek = sender as? Yemekler {
                let gidilecekVC = segue.destination as! UrunDetay
                gidilecekVC.yemek = yemek
            }
        }
    }
}

extension Anasayfa : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.ara(aramaKelimesi: searchText)
    }
}

extension Anasayfa : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return yemeklerListesi.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let hucre = collectionView.dequeueReusableCell(withReuseIdentifier: "yemeklerHucre", for: indexPath) as! YemeklerHucre
        
        let yemek = yemeklerListesi[indexPath.row]
        //hucre.imageViewYemek.image = UIImage(named: yemek.yemek_resim)
        hucre.yemekAdiLabel.text = yemek.yemek_adi
        hucre.yemekFiyatLabel.text = yemek.yemek_fiyat
        
        
        return hucre
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let yemek = yemeklerListesi[indexPath.row]
        performSegue(withIdentifier: "toDetay", sender: yemek)
    }
    
    
}



