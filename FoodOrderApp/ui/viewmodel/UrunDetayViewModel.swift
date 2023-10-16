//
//  UrunDetayViewModel.swift
//  FoodOrderApp
//
//  Created by EZGİ KARABAY on 13.10.2023.
//

import Foundation

class UrunDetayViewModel {
    
    var yrepo = YemeklerDaoRepository()
    
    func adetEkle (){
        yrepo.adetEkle()
        
    }
    func adetCikar (){
        yrepo.adetCikar()
    }
    func sepeteEkle() {
        yrepo.sepeteEkle()
    }
}
