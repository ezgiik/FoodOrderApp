//
//  SepetDetay.swift
//  FoodOrderApp
//
//  Created by EZGİ KARABAY on 12.10.2023.
//

import Foundation

class SepetDetay : Codable {
    var sepet_yemek_id:String?
    var yemek_adi:String?
    var yemek_resim_adi:String?
    var yemek_fiyat:String?
    var yemek_siparis_adet:String?
    var kullanici_adi:String?
    var yemek_toplam_fiyat:String?
    var idList:[String?]?
    
    init(){
        self.idList = []
    }
    
    init(sepet_yemek_id: String, yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: String, yemek_siparis_adet: String, kullanici_adi: String, yemek_toplam_fiyat:String, idList:[String]) {
        self.sepet_yemek_id = sepet_yemek_id
        self.yemek_adi = yemek_adi
        self.yemek_resim_adi = yemek_resim_adi
        self.yemek_siparis_adet = yemek_siparis_adet
        self.kullanici_adi = kullanici_adi
        self.yemek_toplam_fiyat = yemek_toplam_fiyat
        self.idList = []
    }
    
    func hesaplaToplamFiyat() {
        if let fiyat = Double(yemek_fiyat ?? "0"), let adet = Double(yemek_siparis_adet ?? "0") {
            let toplam = fiyat * adet
            yemek_toplam_fiyat = "\(toplam)"
        }
    }
}
