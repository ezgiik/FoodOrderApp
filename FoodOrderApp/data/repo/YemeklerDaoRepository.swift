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
    
    func sepettekiYemekleriGetir(kullanici_adi: String) {
        let params: Parameters = ["kullanici_adi": kullanici_adi]

        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php", method: .post, parameters: params).response { response in
            guard let data = response.data else {
                print("Veri alınamadı.")
                return
            }

            do {
                let sepetYemekCevap = try JSONDecoder().decode(SepetYemekCevap.self, from: data)
                guard var sepetDetaylari = sepetYemekCevap.sepet_yemekler else {
                    print("Sepet detayları alınamadı.")
                    return
                }
                sepetDetaylari.sort(by: { (ilkEleman, ikinciEleman) -> Bool in
                    let id1 = Int(ilkEleman.sepet_yemek_id ?? "") ?? 0
                    let id2 = Int(ikinciEleman.sepet_yemek_id ?? "") ?? 0
                    return id1 < id2
                })

                var yemekGruplari: [String: (toplamAdet: Int, toplamFiyat: Double)] = [:]

                for detay in sepetDetaylari {
                    if let yemekAdi = detay.yemek_adi, let adetStr = detay.yemek_siparis_adet, let adet = Int(adetStr), let fiyatStr = detay.yemek_fiyat, let fiyat = Double(fiyatStr) {
                        let mevcut = yemekGruplari[yemekAdi] ?? (0, 0.0)
                        yemekGruplari[yemekAdi] = (mevcut.toplamAdet + adet, mevcut.toplamFiyat + (fiyat * Double(adet)))
                    }
                }

                let guncellenmisListe = yemekGruplari.map { (yemekAdi, bilgiler) -> SepetDetay in
                    let yeniDetay = SepetDetay()
                    yeniDetay.yemek_adi = yemekAdi
                    yeniDetay.yemek_siparis_adet = String(bilgiler.toplamAdet)
                    yeniDetay.yemek_toplam_fiyat = String(bilgiler.toplamFiyat)

                    yeniDetay.yemek_resim_adi = sepetDetaylari.first(where: { $0.yemek_adi == yemekAdi })?.yemek_resim_adi
                    yeniDetay.sepet_yemek_id = sepetDetaylari.first(where: { $0.yemek_adi == yemekAdi })?.sepet_yemek_id
                    yeniDetay.kullanici_adi = sepetDetaylari.first(where: { $0.yemek_adi == yemekAdi })?.kullanici_adi
                    yeniDetay.yemek_fiyat = sepetDetaylari.first(where: { $0.yemek_adi == yemekAdi })?.yemek_fiyat
                    
                    yeniDetay.idList = sepetDetaylari.filter { $0.yemek_adi == yemekAdi }.map {
                        $0.sepet_yemek_id}

                    return yeniDetay
                }

                self.sepetListesi.onNext(guncellenmisListe)

            } catch {
                print(error)
            }
        }
    }
    
    func yemekSil(sepet_yemek_id:Int, kullanici_adi:String){
        
        let params:Parameters = ["sepet_yemek_id":sepet_yemek_id,"kullanici_adi":kullanici_adi]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php",method: .post,parameters: params).response { response in
            if let data = response.data {
                do{
                    let cevap = try JSONDecoder().decode(CRUDCevap.self, from: data)
                    print("------- DELETE -------")
                    print("Başarı : \(cevap.success!)")
                    print("Mesaj  : \(cevap.message!)")
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
        
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
