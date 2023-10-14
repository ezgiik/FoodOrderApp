//
//  YemeklerDaoRepository.swift
//  FoodOrderApp
//
//  Created by EZGİ KARABAY on 13.10.2023.
//

import Foundation
import Alamofire
import RxSwift

class YemeklerDaoRepository{
    var yemeklerListesi = BehaviorSubject<[Yemekler]>(value:[Yemekler]())
    
    func adetEkle (adet:Int, yemek_toplam:Int){
        
    }
    func adetCikar (adet:Int, yemek_toplam:Int){
        
    }
    func sepeteEkle() {
        
    }
    
    func yemekSil(){
        
    }
    
    func ara(aramaKelimesi:String){
        
    }
    
    func yemekleriYukle(){
        AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php", method: .get).response { response in
            if let data = response.data {
                do{
                    let cevap = try JSONDecoder().decode(YemeklerCevap.self, from: data)
                    if let liste = cevap.yemekler{
                        self.yemeklerListesi.onNext(liste)
                    }
                }catch{
                    print(error.localizedDescription)
                }
            
            }
        }
        
    }
}
