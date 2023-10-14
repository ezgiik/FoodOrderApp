//
//  UrunDetayViewModel.swift
//  FoodOrderApp
//
//  Created by EZGİ KARABAY on 13.10.2023.
//

import Foundation

class UrunDetayViewModel {
    
    var yrepo = YemeklerDaoRepository()
    
    func adetEkle (adet:Int, yemek_toplam:Int){
        yrepo.adetEkle(adet: adet, yemek_toplam: yemek_toplam)
        
    }
    func adetCikar (adet:Int, yemek_toplam:Int){
        yrepo.adetCikar(adet: adet, yemek_toplam: yemek_toplam)
    }
    func sepeteEkle() {
        yrepo.sepeteEkle()
    }
}
