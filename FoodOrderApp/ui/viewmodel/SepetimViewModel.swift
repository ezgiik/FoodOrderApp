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
    
    init(){
        sepetListesi = yrepo.sepetListesi
    }
    
    func sepettekiYemekleriGetir(kullanici_adi: String){
        yrepo.sepettekiYemekleriGetir(kullanici_adi: kullanici_adi)
    }
}
