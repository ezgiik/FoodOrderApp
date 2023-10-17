//
//  YemeklerDaoRepository.swift
//  FoodOrderApp
//
//  Created by EZGİ KARABAY on 13.10.2023.
//

import Foundation
import Alamofire
import RxSwift
import Kingfisher


class YemeklerDaoRepository{
    var yemeklerListesi = BehaviorSubject<[Yemekler]>(value:[Yemekler]())
    var sepetListesi = BehaviorSubject<[SepetDetay]>(value:[SepetDetay]())
    var yemekAdet = BehaviorSubject<Int>(value: 1)
    var yemekToplamFiyat = BehaviorSubject<Int>(value: 0)
    
    func adetEkle (){
        let currentValue = try! yemekAdet.value()
        yemekAdet.onNext(currentValue + 1)
    }
    func adetCikar (){
        let currentValue = try! yemekAdet.value()
        if currentValue > 1 {
            yemekAdet.onNext(currentValue - 1)
        }
    }
    func fiyatHesapla(fiyat : Int){
        let adet = try! yemekAdet.value()
        let toplamFiyat = Int(adet) * fiyat
        yemekToplamFiyat.onNext(toplamFiyat)
        
    }
    
    func sepeteEkle(yemek_adi:String, yemek_resim_adi:String, yemek_fiyat:Int, yemek_siparis_adet:Int, kullanici_adi:String) {
        let params:Parameters = ["yemek_adi":yemek_adi,"yemek_resim_adi":yemek_resim_adi,"yemek_fiyat":yemek_fiyat,"yemek_siparis_adet":yemek_siparis_adet,"kullanici_adi":kullanici_adi]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php",method: .post,parameters: params).response { response 
            in
            if let data = response.data{
                do{
                    let cevap = try JSONDecoder().decode(CRUDCevap.self, from: data)
                    print("-------Sepete Ekle-------")
                    print("Başarı : \(cevap.success!)")
                    print("Mesaj : \(cevap.message!)")
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    func sepettekiYemekleriGetir(kullanici_adi: String){
        
        let params:Parameters = ["kullanici_adi" : kullanici_adi]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php", method: .post,parameters: params).response { response in
            if let data = response.data {
                do{
                    let response = try JSONDecoder().decode(SepetYemekCevap.self, from: data)
                    if let liste = response.sepet_yemekler {
                        self.sepetListesi.onNext(liste)
                    }
                    let rawResponse = try JSONSerialization.jsonObject(with: data)
                    print(rawResponse)
                    
                    
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
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
                        
                        if let yemekFiyatString = liste[0].yemek_fiyat, let urunFiyat = Int(yemekFiyatString) {
                            self.yemekToplamFiyat.onNext(urunFiyat)
                        } else {
                            print("Yemek fiyatı geçersiz veya nil.")
                        }

                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
}
