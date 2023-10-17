//
//  SepetimViewModel.swift
//  FoodOrderApp
//
//  Created by EZGİ KARABAY on 13.10.2023.
//

import Foundation
import RxSwift

class SepetimViewModel{
    var yrepo = YemeklerDaoRepository()
    var sepetListesi = BehaviorSubject<[SepetDetay]>(value:[SepetDetay]())
    var yemekAdet = BehaviorSubject<Int>(value: 1)
    var yemekToplamFiyat = BehaviorSubject<Int>(value: 0)
    
    init(){
        yemekAdet = yrepo.yemekAdet
        yemekToplamFiyat = yrepo.yemekToplamFiyat
        sepetListesi = yrepo.sepetListesi
    }
    
    func sepettekiYemekleriGetir(kullanici_adi: String){
        yrepo.sepettekiYemekleriGetir(kullanici_adi: kullanici_adi)
    }
}
