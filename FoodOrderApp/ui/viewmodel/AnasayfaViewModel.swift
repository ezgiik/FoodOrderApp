//
//  AnasayfaViewModel.swift
//  FoodOrderApp
//
//  Created by EZGİ KARABAY on 13.10.2023.
//

import Foundation
import RxSwift

class AnasayfaViewModel{
    var yrepo = YemeklerDaoRepository()
    var yemeklerListesi = BehaviorSubject<[Yemekler]>(value:[Yemekler]())
    
    init(){
        yemeklerListesi = yrepo.yemeklerListesi
    }
    
    func ara(aramaKelimesi:String){
        yrepo.ara(aramaKelimesi: aramaKelimesi)
    }
    
    func yemekleriYukle(){
        yrepo.yemekleriYukle()
    }
}
