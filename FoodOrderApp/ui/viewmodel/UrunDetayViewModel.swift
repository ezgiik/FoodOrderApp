//
//  UrunDetayViewModel.swift
//  FoodOrderApp
//
//  Created by EZGİ KARABAY on 13.10.2023.
//

import Foundation
import RxSwift

class UrunDetayViewModel {
    
    var sepetListesi = BehaviorSubject<[SepetDetay]>(value:[SepetDetay]())
    var yrepo = YemeklerDaoRepository()
    
    func adetEkle (){
        yrepo.adetEkle()
        
    }
    func adetCikar (){
        yrepo.adetCikar()
    }
    func sepeteEkle(yemek_adi:String, yemek_resim_adi:String, yemek_fiyat:Int, yemek_siparis_adet:Int, kullanici_adi:String) {
        yrepo.sepeteEkle(yemek_adi: yemek_adi, yemek_resim_adi: yemek_resim_adi, yemek_fiyat: yemek_fiyat, yemek_siparis_adet: yemek_siparis_adet,  kullanici_adi: kullanici_adi)
    }
}
